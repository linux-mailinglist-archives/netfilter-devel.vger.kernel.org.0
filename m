Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BAA4E5306
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Mar 2022 14:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbiCWNYM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Mar 2022 09:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244260AbiCWNYM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:24:12 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E0F7CDF8
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Mar 2022 06:22:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nX0wj-00014w-7m; Wed, 23 Mar 2022 14:22:41 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v3 06/16] netfilter: conntrack: include ecache dying list in dumps
Date:   Wed, 23 Mar 2022 14:22:04 +0100
Message-Id: <20220323132214.6700-7-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220323132214.6700-1-fw@strlen.de>
References: <20220323132214.6700-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The new pernet dying list includes conntrack entries that await
delivery of the 'destroy' event via ctnetlink.

The old percpu dying list will be removed soon.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_conntrack_ecache.h |  2 +
 net/netfilter/nf_conntrack_ecache.c         | 10 +++++
 net/netfilter/nf_conntrack_netlink.c        | 43 +++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/include/net/netfilter/nf_conntrack_ecache.h b/include/net/netfilter/nf_conntrack_ecache.h
index 0364c4782ec3..c8dd9cd8cb64 100644
--- a/include/net/netfilter/nf_conntrack_ecache.h
+++ b/include/net/netfilter/nf_conntrack_ecache.h
@@ -148,6 +148,8 @@ void nf_conntrack_ecache_work(struct net *net, enum nf_ct_ecache_state state);
 void nf_conntrack_ecache_pernet_init(struct net *net);
 void nf_conntrack_ecache_pernet_fini(struct net *net);
 
+struct nf_conntrack_net_ecache *nf_conn_pernet_ecache(const struct net *net);
+
 static inline bool nf_conntrack_ecache_dwork_pending(const struct net *net)
 {
 	return net->ct.ecache_dwork_pending;
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
index b6680e108b40..d34939797638 100644
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -39,6 +39,16 @@ enum retry_state {
 	STATE_DONE,
 };
 
+struct nf_conntrack_net_ecache *nf_conn_pernet_ecache(const struct net *net)
+{
+	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
+
+	return &cnet->ecache;
+}
+#if IS_MODULE(CONFIG_NF_CT_NETLINK)
+EXPORT_SYMBOL_GPL(nf_conn_pernet_ecache);
+#endif
+
 static enum retry_state ecache_work_evict_list(struct nf_conntrack_net *cnet)
 {
 	unsigned long stop = jiffies + ECACHE_MAX_JIFFIES;
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 5f3d211a41e3..3cd0d9d35b13 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -62,6 +62,7 @@ struct ctnetlink_list_dump_ctx {
 	struct nf_conn *last;
 	unsigned int cpu;
 	bool done;
+	bool retrans_done;
 };
 
 static int ctnetlink_dump_tuples_proto(struct sk_buff *skb,
@@ -1802,6 +1803,48 @@ ctnetlink_dump_list(struct sk_buff *skb, struct netlink_callback *cb, bool dying
 static int
 ctnetlink_dump_dying(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	struct ctnetlink_list_dump_ctx *ctx = (void *)cb->ctx;
+	struct nf_conn *last = ctx->last;
+#ifdef CONFIG_NF_CONNTRACK_EVENTS
+	const struct net *net = sock_net(skb->sk);
+	struct nf_conntrack_net_ecache *ecache_net;
+	struct nf_conntrack_tuple_hash *h;
+	struct hlist_nulls_node *n;
+#endif
+
+	if (ctx->retrans_done)
+		return ctnetlink_dump_list(skb, cb, true);
+
+	ctx->last = NULL;
+
+#ifdef CONFIG_NF_CONNTRACK_EVENTS
+	ecache_net = nf_conn_pernet_ecache(net);
+	spin_lock_bh(&ecache_net->dying_lock);
+
+	hlist_nulls_for_each_entry(h, n, &ecache_net->dying_list, hnnode) {
+		struct nf_conn *ct;
+		int res;
+
+		ct = nf_ct_tuplehash_to_ctrack(h);
+		if (last && last != ct)
+			continue;
+
+		res = ctnetlink_dump_one_entry(skb, cb, ct, true);
+		if (res < 0) {
+			spin_unlock_bh(&ecache_net->dying_lock);
+			nf_ct_put(last);
+			return skb->len;
+		}
+
+		nf_ct_put(last);
+		last = NULL;
+	}
+
+	spin_unlock_bh(&ecache_net->dying_lock);
+#endif
+	nf_ct_put(last);
+	ctx->retrans_done = true;
+
 	return ctnetlink_dump_list(skb, cb, true);
 }
 
-- 
2.34.1

