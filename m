Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E184FBA56
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 Apr 2022 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiDKLD6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Apr 2022 07:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiDKLDz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:03:55 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E6BC47
        for <netfilter-devel@vger.kernel.org>; Mon, 11 Apr 2022 04:01:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ndrnf-0000Ic-Ky; Mon, 11 Apr 2022 13:01:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v4 02/10] netfilter: conntrack: include ecache dying list in dumps
Date:   Mon, 11 Apr 2022 13:01:17 +0200
Message-Id: <20220411110125.4854-3-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411110125.4854-1-fw@strlen.de>
References: <20220411110125.4854-1-fw@strlen.de>
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
index a6135b5030dd..b57d73785e4d 100644
--- a/include/net/netfilter/nf_conntrack_ecache.h
+++ b/include/net/netfilter/nf_conntrack_ecache.h
@@ -164,6 +164,8 @@ void nf_conntrack_ecache_work(struct net *net, enum nf_ct_ecache_state state);
 void nf_conntrack_ecache_pernet_init(struct net *net);
 void nf_conntrack_ecache_pernet_fini(struct net *net);
 
+struct nf_conntrack_net_ecache *nf_conn_pernet_ecache(const struct net *net);
+
 static inline bool nf_conntrack_ecache_dwork_pending(const struct net *net)
 {
 	return net->ct.ecache_dwork_pending;
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
index 4d5e729741b2..b362c399efeb 100644
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -38,6 +38,16 @@ enum retry_state {
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
index 924d766e6c53..a4ec2aad2187 100644
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
2.35.1

