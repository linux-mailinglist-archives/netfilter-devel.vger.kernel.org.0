Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9DB748997
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Jul 2023 18:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjGEQys (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jul 2023 12:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGEQyo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:54:44 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1A1C1995;
        Wed,  5 Jul 2023 09:54:35 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     sashal@kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,5.4 03/10] netfilter: add helper function to set up the nfnetlink header and use it
Date:   Wed,  5 Jul 2023 18:54:16 +0200
Message-Id: <20230705165423.50054-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230705165423.50054-1-pablo@netfilter.org>
References: <20230705165423.50054-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

[ 19c28b1374fb1073a9ec873a6c10bf5f16b10b9d ]

This patch adds a helper function to set up the netlink and nfnetlink headers.
Update existing codebase to use it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/linux/netfilter/nfnetlink.h  |  27 +++++++
 net/netfilter/ipset/ip_set_core.c    |  17 +----
 net/netfilter/nf_conntrack_netlink.c |  77 ++++++--------------
 net/netfilter/nf_tables_api.c        | 102 +++++++--------------------
 net/netfilter/nf_tables_trace.c      |   9 +--
 net/netfilter/nfnetlink_acct.c       |  11 +--
 net/netfilter/nfnetlink_cthelper.c   |  11 +--
 net/netfilter/nfnetlink_cttimeout.c  |  22 ++----
 net/netfilter/nfnetlink_log.c        |  11 +--
 net/netfilter/nfnetlink_queue.c      |  12 ++--
 net/netfilter/nft_compat.c           |  11 +--
 11 files changed, 102 insertions(+), 208 deletions(-)

diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index 41de4156540a..0518ca72b761 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -56,6 +56,33 @@ static inline u16 nfnl_msg_type(u8 subsys, u8 msg_type)
 	return subsys << 8 | msg_type;
 }
 
+static inline void nfnl_fill_hdr(struct nlmsghdr *nlh, u8 family, u8 version,
+				 __be16 res_id)
+{
+	struct nfgenmsg *nfmsg;
+
+	nfmsg = nlmsg_data(nlh);
+	nfmsg->nfgen_family = family;
+	nfmsg->version = version;
+	nfmsg->res_id = res_id;
+}
+
+static inline struct nlmsghdr *nfnl_msg_put(struct sk_buff *skb, u32 portid,
+					    u32 seq, int type, int flags,
+					    u8 family, u8 version,
+					    __be16 res_id)
+{
+	struct nlmsghdr *nlh;
+
+	nlh = nlmsg_put(skb, portid, seq, type, sizeof(struct nfgenmsg), flags);
+	if (!nlh)
+		return NULL;
+
+	nfnl_fill_hdr(nlh, family, version, res_id);
+
+	return nlh;
+}
+
 void nfnl_lock(__u8 subsys_id);
 void nfnl_unlock(__u8 subsys_id);
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index e3c14f8890a8..1cf143f5df2e 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -811,20 +811,9 @@ static struct nlmsghdr *
 start_msg(struct sk_buff *skb, u32 portid, u32 seq, unsigned int flags,
 	  enum ipset_cmd cmd)
 {
-	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
-
-	nlh = nlmsg_put(skb, portid, seq, nfnl_msg_type(NFNL_SUBSYS_IPSET, cmd),
-			sizeof(*nfmsg), flags);
-	if (!nlh)
-		return NULL;
-
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = NFPROTO_IPV4;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
-	return nlh;
+	return nfnl_msg_put(skb, portid, seq,
+			    nfnl_msg_type(NFNL_SUBSYS_IPSET, cmd), flags,
+			    NFPROTO_IPV4, NFNETLINK_V0, 0);
 }
 
 /* Create a set */
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 4328d10ad1bc..45d02185f4b9 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -515,20 +515,15 @@ ctnetlink_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 {
 	const struct nf_conntrack_zone *zone;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct nlattr *nest_parms;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK, IPCTNL_MSG_CT_NEW);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, nf_ct_l3num(ct),
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = nf_ct_l3num(ct);
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	zone = nf_ct_zone(ct);
 
 	nest_parms = nla_nest_start(skb, CTA_TUPLE_ORIG);
@@ -685,7 +680,6 @@ ctnetlink_conntrack_event(unsigned int events, struct nf_ct_event *item)
 	const struct nf_conntrack_zone *zone;
 	struct net *net;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct nlattr *nest_parms;
 	struct nf_conn *ct = item->ct;
 	struct sk_buff *skb;
@@ -715,15 +709,11 @@ ctnetlink_conntrack_event(unsigned int events, struct nf_ct_event *item)
 		goto errout;
 
 	type = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK, type);
-	nlh = nlmsg_put(skb, item->portid, 0, type, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, item->portid, 0, type, flags, nf_ct_l3num(ct),
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = nf_ct_l3num(ct);
-	nfmsg->version	= NFNETLINK_V0;
-	nfmsg->res_id	= 0;
-
 	zone = nf_ct_zone(ct);
 
 	nest_parms = nla_nest_start(skb, CTA_TUPLE_ORIG);
@@ -2200,20 +2190,15 @@ ctnetlink_ct_stat_cpu_fill_info(struct sk_buff *skb, u32 portid, u32 seq,
 				__u16 cpu, const struct ip_conntrack_stat *st)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK,
 			      IPCTNL_MSG_CT_GET_STATS_CPU);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, htons(cpu));
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = htons(cpu);
-
 	if (nla_put_be32(skb, CTA_STATS_FOUND, htonl(st->found)) ||
 	    nla_put_be32(skb, CTA_STATS_INVALID, htonl(st->invalid)) ||
 	    nla_put_be32(skb, CTA_STATS_IGNORE, htonl(st->ignore)) ||
@@ -2284,20 +2269,15 @@ ctnetlink_stat_ct_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 			    struct net *net)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 	unsigned int nr_conntracks = atomic_read(&net->ct.count);
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK, IPCTNL_MSG_CT_GET_STATS);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	if (nla_put_be32(skb, CTA_STATS_GLOBAL_ENTRIES, htonl(nr_conntracks)))
 		goto nla_put_failure;
 
@@ -2803,19 +2783,14 @@ ctnetlink_exp_fill_info(struct sk_buff *skb, u32 portid, u32 seq,
 			int event, const struct nf_conntrack_expect *exp)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_EXP, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags,
+			   exp->tuple.src.l3num, NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = exp->tuple.src.l3num;
-	nfmsg->version	    = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	if (ctnetlink_exp_dump_expect(skb, exp) < 0)
 		goto nla_put_failure;
 
@@ -2835,7 +2810,6 @@ ctnetlink_expect_event(unsigned int events, struct nf_exp_event *item)
 	struct nf_conntrack_expect *exp = item->exp;
 	struct net *net = nf_ct_exp_net(exp);
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct sk_buff *skb;
 	unsigned int type, group;
 	int flags = 0;
@@ -2858,15 +2832,11 @@ ctnetlink_expect_event(unsigned int events, struct nf_exp_event *item)
 		goto errout;
 
 	type = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_EXP, type);
-	nlh = nlmsg_put(skb, item->portid, 0, type, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, item->portid, 0, type, flags,
+			   exp->tuple.src.l3num, NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = exp->tuple.src.l3num;
-	nfmsg->version	    = NFNETLINK_V0;
-	nfmsg->res_id	    = 0;
-
 	if (ctnetlink_exp_dump_expect(skb, exp) < 0)
 		goto nla_put_failure;
 
@@ -3436,20 +3406,15 @@ ctnetlink_exp_stat_fill_info(struct sk_buff *skb, u32 portid, u32 seq, int cpu,
 			     const struct ip_conntrack_stat *st)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0, event;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK,
 			      IPCTNL_MSG_EXP_GET_STATS_CPU);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, htons(cpu));
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = htons(cpu);
-
 	if (nla_put_be32(skb, CTA_STATS_EXP_NEW, htonl(st->expect_new)) ||
 	    nla_put_be32(skb, CTA_STATS_EXP_CREATE, htonl(st->expect_create)) ||
 	    nla_put_be32(skb, CTA_STATS_EXP_DELETE, htonl(st->expect_delete)))
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 323537fb869e..c67dfff6916a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -605,18 +605,13 @@ static int nf_tables_fill_table_info(struct sk_buff *skb, struct net *net,
 				     int family, const struct nft_table *table)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_TABLE_NAME, table->name) ||
 	    nla_put_be32(skb, NFTA_TABLE_FLAGS, htonl(table->flags)) ||
 	    nla_put_be32(skb, NFTA_TABLE_USE, htonl(table->use)) ||
@@ -1269,18 +1264,13 @@ static int nf_tables_fill_chain_info(struct sk_buff *skb, struct net *net,
 				     const struct nft_chain *chain)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_CHAIN_TABLE, table->name))
 		goto nla_put_failure;
 	if (nla_put_be64(skb, NFTA_CHAIN_HANDLE, cpu_to_be64(chain->handle),
@@ -2359,20 +2349,15 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
 				    const struct nft_rule *prule)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	const struct nft_expr *expr, *next;
 	struct nlattr *list;
 	u16 type = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
 
-	nlh = nlmsg_put(skb, portid, seq, type, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, type, flags, family, NFNETLINK_V0,
+			   nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_RULE_TABLE, table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_RULE_CHAIN, chain->name))
@@ -3315,23 +3300,17 @@ __be64 nf_jiffies64_to_msecs(u64 input)
 static int nf_tables_fill_set(struct sk_buff *skb, const struct nft_ctx *ctx,
 			      const struct nft_set *set, u16 event, u16 flags)
 {
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct nlattr *desc;
 	u32 portid = ctx->portid;
 	u32 seq = ctx->seq;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg),
-			flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
+			   NFNETLINK_V0, nft_base_seq(ctx->net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= ctx->family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(ctx->net);
-
 	if (nla_put_string(skb, NFTA_SET_TABLE, ctx->table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_SET_NAME, set->name))
@@ -4144,7 +4123,6 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nft_set *set;
 	struct nft_set_dump_args args;
 	bool set_found = false;
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
 	u32 portid, seq;
@@ -4177,16 +4155,11 @@ static int nf_tables_dump_set(struct sk_buff *skb, struct netlink_callback *cb)
 	portid = NETLINK_CB(cb->skb).portid;
 	seq    = cb->nlh->nlmsg_seq;
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg),
-			NLM_F_MULTI);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, NLM_F_MULTI,
+			   table->family, NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = table->family;
-	nfmsg->version      = NFNETLINK_V0;
-	nfmsg->res_id	    = nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_SET_ELEM_LIST_TABLE, table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_SET_ELEM_LIST_SET, set->name))
@@ -4243,22 +4216,16 @@ static int nf_tables_fill_setelem_info(struct sk_buff *skb,
 				       const struct nft_set *set,
 				       const struct nft_set_elem *elem)
 {
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct nlattr *nest;
 	int err;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg),
-			flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, ctx->family,
+			   NFNETLINK_V0, nft_base_seq(ctx->net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= ctx->family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(ctx->net);
-
 	if (nla_put_string(skb, NFTA_SET_TABLE, ctx->table->name))
 		goto nla_put_failure;
 	if (nla_put_string(skb, NFTA_SET_NAME, set->name))
@@ -5377,19 +5344,14 @@ static int nf_tables_fill_obj_info(struct sk_buff *skb, struct net *net,
 				   int family, const struct nft_table *table,
 				   struct nft_object *obj, bool reset)
 {
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_OBJ_TABLE, table->name) ||
 	    nla_put_string(skb, NFTA_OBJ_NAME, obj->key.name) ||
 	    nla_put_be32(skb, NFTA_OBJ_TYPE, htonl(obj->ops->type->type)) ||
@@ -6052,20 +6014,15 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 					 struct nft_flowtable *flowtable)
 {
 	struct nlattr *nest, *nest_devs;
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	int i;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_string(skb, NFTA_FLOWTABLE_TABLE, flowtable->table->name) ||
 	    nla_put_string(skb, NFTA_FLOWTABLE_NAME, flowtable->name) ||
 	    nla_put_be32(skb, NFTA_FLOWTABLE_USE, htonl(flowtable->use)) ||
@@ -6291,19 +6248,14 @@ static int nf_tables_fill_gen_info(struct sk_buff *skb, struct net *net,
 				   u32 portid, u32 seq)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	char buf[TASK_COMM_LEN];
 	int event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_NEWGEN);
 
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(struct nfgenmsg), 0);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, 0, AF_UNSPEC,
+			   NFNETLINK_V0, nft_base_seq(net));
+	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= AF_UNSPEC;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= nft_base_seq(net);
-
 	if (nla_put_be32(skb, NFTA_GEN_ID, htonl(net->nft.base_seq)) ||
 	    nla_put_be32(skb, NFTA_GEN_PROC_PID, htonl(task_pid_nr(current))) ||
 	    nla_put_string(skb, NFTA_GEN_PROC_NAME, get_task_comm(buf, current)))
diff --git a/net/netfilter/nf_tables_trace.c b/net/netfilter/nf_tables_trace.c
index 87b36da5cd98..0cf3278007ba 100644
--- a/net/netfilter/nf_tables_trace.c
+++ b/net/netfilter/nf_tables_trace.c
@@ -183,7 +183,6 @@ static bool nft_trace_have_verdict_chain(struct nft_traceinfo *info)
 void nft_trace_notify(struct nft_traceinfo *info)
 {
 	const struct nft_pktinfo *pkt = info->pkt;
-	struct nfgenmsg *nfmsg;
 	struct nlmsghdr *nlh;
 	struct sk_buff *skb;
 	unsigned int size;
@@ -219,15 +218,11 @@ void nft_trace_notify(struct nft_traceinfo *info)
 		return;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFTABLES, NFT_MSG_TRACE);
-	nlh = nlmsg_put(skb, 0, 0, event, sizeof(struct nfgenmsg), 0);
+	nlh = nfnl_msg_put(skb, 0, 0, event, 0, info->basechain->type->family,
+			   NFNETLINK_V0, 0);
 	if (!nlh)
 		goto nla_put_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family	= info->basechain->type->family;
-	nfmsg->version		= NFNETLINK_V0;
-	nfmsg->res_id		= 0;
-
 	if (nla_put_be32(skb, NFTA_TRACE_NFPROTO, htonl(nft_pf(pkt))))
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nfnetlink_acct.c b/net/netfilter/nfnetlink_acct.c
index 2481470dec36..4b46421c5e17 100644
--- a/net/netfilter/nfnetlink_acct.c
+++ b/net/netfilter/nfnetlink_acct.c
@@ -132,21 +132,16 @@ nfnl_acct_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 		   int event, struct nf_acct *acct)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	u64 pkts, bytes;
 	u32 old_flags;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_ACCT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, NFACCT_NAME, acct->name))
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
index 3d5fc07b2530..cb9c2e955996 100644
--- a/net/netfilter/nfnetlink_cthelper.c
+++ b/net/netfilter/nfnetlink_cthelper.c
@@ -530,20 +530,15 @@ nfnl_cthelper_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 			int event, struct nf_conntrack_helper *helper)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	int status;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTHELPER, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, NFCTH_NAME, helper->name))
 		goto nla_put_failure;
 
diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index da915c224a82..a854e1560cc1 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -160,22 +160,17 @@ ctnl_timeout_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 		       int event, struct ctnl_timeout *timeout)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	const struct nf_conntrack_l4proto *l4proto = timeout->timeout.l4proto;
 	struct nlattr *nest_parms;
 	int ret;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_TIMEOUT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, CTA_TIMEOUT_NAME, timeout->name) ||
 	    nla_put_be16(skb, CTA_TIMEOUT_L3PROTO,
 			 htons(timeout->timeout.l3num)) ||
@@ -382,21 +377,16 @@ cttimeout_default_fill_info(struct net *net, struct sk_buff *skb, u32 portid,
 			    const unsigned int *timeouts)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 	struct nlattr *nest_parms;
 	int ret;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_CTNETLINK_TIMEOUT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, AF_UNSPEC,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = AF_UNSPEC;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_be16(skb, CTA_TIMEOUT_L3PROTO, htons(l3num)) ||
 	    nla_put_u8(skb, CTA_TIMEOUT_L4PROTO, l4proto->l4proto))
 		goto nla_put_failure;
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 33c13edbca4b..f087baa95b07 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -452,20 +452,15 @@ __build_packet_message(struct nfnl_log_net *log,
 {
 	struct nfulnl_msg_packet_hdr pmsg;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	sk_buff_data_t old_tail = inst->skb->tail;
 	struct sock *sk;
 	const unsigned char *hwhdrp;
 
-	nlh = nlmsg_put(inst->skb, 0, 0,
-			nfnl_msg_type(NFNL_SUBSYS_ULOG, NFULNL_MSG_PACKET),
-			sizeof(struct nfgenmsg), 0);
+	nlh = nfnl_msg_put(inst->skb, 0, 0,
+			   nfnl_msg_type(NFNL_SUBSYS_ULOG, NFULNL_MSG_PACKET),
+			   0, pf, NFNETLINK_V0, htons(inst->group_num));
 	if (!nlh)
 		return -1;
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = pf;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = htons(inst->group_num);
 
 	memset(&pmsg, 0, sizeof(pmsg));
 	pmsg.hw_protocol	= skb->protocol;
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index ad88904ee3f9..772f8c69818c 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -383,7 +383,6 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	struct nlattr *nla;
 	struct nfqnl_msg_packet_hdr *pmsg;
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	struct sk_buff *entskb = entry->skb;
 	struct net_device *indev;
 	struct net_device *outdev;
@@ -469,18 +468,15 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 		goto nlmsg_failure;
 	}
 
-	nlh = nlmsg_put(skb, 0, 0,
-			nfnl_msg_type(NFNL_SUBSYS_QUEUE, NFQNL_MSG_PACKET),
-			sizeof(struct nfgenmsg), 0);
+	nlh = nfnl_msg_put(skb, 0, 0,
+			   nfnl_msg_type(NFNL_SUBSYS_QUEUE, NFQNL_MSG_PACKET),
+			   0, entry->state.pf, NFNETLINK_V0,
+			   htons(queue->queue_num));
 	if (!nlh) {
 		skb_tx_error(entskb);
 		kfree_skb(skb);
 		goto nlmsg_failure;
 	}
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = entry->state.pf;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = htons(queue->queue_num);
 
 	nla = __nla_reserve(skb, NFQA_PACKET_HDR, sizeof(*pmsg));
 	pmsg = nla_data(nla);
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index bbe03b9a03b1..1c975e1d3fea 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -591,19 +591,14 @@ nfnl_compat_fill_info(struct sk_buff *skb, u32 portid, u32 seq, u32 type,
 		      int rev, int target)
 {
 	struct nlmsghdr *nlh;
-	struct nfgenmsg *nfmsg;
 	unsigned int flags = portid ? NLM_F_MULTI : 0;
 
 	event = nfnl_msg_type(NFNL_SUBSYS_NFT_COMPAT, event);
-	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*nfmsg), flags);
-	if (nlh == NULL)
+	nlh = nfnl_msg_put(skb, portid, seq, event, flags, family,
+			   NFNETLINK_V0, 0);
+	if (!nlh)
 		goto nlmsg_failure;
 
-	nfmsg = nlmsg_data(nlh);
-	nfmsg->nfgen_family = family;
-	nfmsg->version = NFNETLINK_V0;
-	nfmsg->res_id = 0;
-
 	if (nla_put_string(skb, NFTA_COMPAT_NAME, name) ||
 	    nla_put_be32(skb, NFTA_COMPAT_REV, htonl(rev)) ||
 	    nla_put_be32(skb, NFTA_COMPAT_TYPE, htonl(target)))
-- 
2.30.2

