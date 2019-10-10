Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FFDD33FB
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Oct 2019 00:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfJJWd7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Oct 2019 18:33:59 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:53572 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfJJWd7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:33:59 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1iIh0O-00064X-QS; Fri, 11 Oct 2019 00:33:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, Edward Cree <ecree@solarflare.com>
Subject: [PATCH v2 nf-next] netfilter: add and use nf_hook_slow_list()
Date:   Fri, 11 Oct 2019 00:30:37 +0200
Message-Id: <20191010223037.10811-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

At this time, NF_HOOK_LIST() macro will iterate the list and then calls
nf_hook() for each individual skb.

This makes it so the entire list is passed into the netfilter core.
The advantage is that we only need to fetch the rule blob once per list
instead of per-skb.

NF_HOOK_LIST now only works for ipv4 and ipv6, as those are the only
callers.

v2: use skb_list_del_init() instead of list_del (Edward Cree)

Cc: Edward Cree <ecree@solarflare.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter.h | 41 +++++++++++++++++++++++++++++----------
 net/netfilter/core.c      | 20 +++++++++++++++++++
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 77ebb61faf48..eb312e7ca36e 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -199,6 +199,8 @@ extern struct static_key nf_hooks_needed[NFPROTO_NUMPROTO][NF_MAX_HOOKS];
 int nf_hook_slow(struct sk_buff *skb, struct nf_hook_state *state,
 		 const struct nf_hook_entries *e, unsigned int i);
 
+void nf_hook_slow_list(struct list_head *head, struct nf_hook_state *state,
+		       const struct nf_hook_entries *e);
 /**
  *	nf_hook - call a netfilter hook
  *
@@ -311,17 +313,36 @@ NF_HOOK_LIST(uint8_t pf, unsigned int hook, struct net *net, struct sock *sk,
 	     struct list_head *head, struct net_device *in, struct net_device *out,
 	     int (*okfn)(struct net *, struct sock *, struct sk_buff *))
 {
-	struct sk_buff *skb, *next;
-	struct list_head sublist;
-
-	INIT_LIST_HEAD(&sublist);
-	list_for_each_entry_safe(skb, next, head, list) {
-		list_del(&skb->list);
-		if (nf_hook(pf, hook, net, sk, skb, in, out, okfn) == 1)
-			list_add_tail(&skb->list, &sublist);
+	struct nf_hook_entries *hook_head = NULL;
+
+#ifdef CONFIG_JUMP_LABEL
+	if (__builtin_constant_p(pf) &&
+	    __builtin_constant_p(hook) &&
+	    !static_key_false(&nf_hooks_needed[pf][hook]))
+		return;
+#endif
+
+	rcu_read_lock();
+	switch (pf) {
+	case NFPROTO_IPV4:
+		hook_head = rcu_dereference(net->nf.hooks_ipv4[hook]);
+		break;
+	case NFPROTO_IPV6:
+		hook_head = rcu_dereference(net->nf.hooks_ipv6[hook]);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
 	}
-	/* Put passed packets back on main list */
-	list_splice(&sublist, head);
+
+	if (hook_head) {
+		struct nf_hook_state state;
+
+		nf_hook_state_init(&state, hook, pf, in, out, sk, net, okfn);
+
+		nf_hook_slow_list(head, &state, hook_head);
+	}
+	rcu_read_unlock();
 }
 
 /* Call setsockopt() */
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 5d5bdf450091..78f046ec506f 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -536,6 +536,26 @@ int nf_hook_slow(struct sk_buff *skb, struct nf_hook_state *state,
 }
 EXPORT_SYMBOL(nf_hook_slow);
 
+void nf_hook_slow_list(struct list_head *head, struct nf_hook_state *state,
+		       const struct nf_hook_entries *e)
+{
+	struct sk_buff *skb, *next;
+	struct list_head sublist;
+	int ret;
+
+	INIT_LIST_HEAD(&sublist);
+
+	list_for_each_entry_safe(skb, next, head, list) {
+		skb_list_del_init(skb);
+		ret = nf_hook_slow(skb, state, e, 0);
+		if (ret == 1)
+			list_add_tail(&skb->list, &sublist);
+	}
+	/* Put passed packets back on main list */
+	list_splice(&sublist, head);
+}
+EXPORT_SYMBOL(nf_hook_slow_list);
+
 /* This needs to be compiled in any case to avoid dependencies between the
  * nfnetlink_queue code and nf_conntrack.
  */
-- 
2.21.0

