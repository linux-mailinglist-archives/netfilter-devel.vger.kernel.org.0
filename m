Return-Path: <netfilter-devel+bounces-13585-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iTBJNDVFRmrXNQsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13585-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 13:02:13 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC36F6591
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 13:02:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13585-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13585-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F38D318CD39
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jul 2026 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1559D3B8BC6;
	Thu,  2 Jul 2026 10:50:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2F3C65FA;
	Thu,  2 Jul 2026 10:50:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989420; cv=none; b=j+9BXlSQtu53ChYaUtuk/ddGU3Bqb89+kG5/YF6ac2P/dmueHvjsCcQs7FChEARXHHv9KGbDeWX2g/1ZiwUAEPTX3fKzVijFXn0gA8S2sTvN2Y8KhDVwHqoxoDBrzUi1oDkLeEuT2BT2h57ZZh5XNYEkyS3vDQj4NbhtFC1JE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989420; c=relaxed/simple;
	bh=djG+BVoeZp0a8+Pmhp0HRSNWjH4cFkQP5T/KGW9CgtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+ZIL/NPS+nfVRR3IBcEXozj2m3xGkRTnneOmJ4uo6j7yJ4Y4EM8zXGMmnkkP2FC/kBPG6U1bftXZ8HapxWevIyqS+J0D5QXekqYA9dXJ40EtLTXu5wShrDNTpbmFqfa7mYvOJstvXTfRcNpyfwe9013YQ0E2OXsikF0tzQDHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EFD2E602A3; Thu, 02 Jul 2026 12:50:16 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 01/12] netfilter: nfnetlink_hook: Dump nat type chains
Date: Thu,  2 Jul 2026 12:49:52 +0200
Message-ID: <20260702105003.13550-2-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702105003.13550-1-fw@strlen.de>
References: <20260702105003.13550-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13585-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,strlen.de:from_mime,vger.kernel.org:from_smtp,nwl.cc:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85FC36F6591

From: Phil Sutter <phil@nwl.cc>

These chains are indirectly attached to the hook since they are
not called for packets belonging to an established connection.

Introduce NF_HOOK_OP_NAT to identify the container and dump attached
entries instead of the container itself.

Dump these entries with the dispatcher's priority value since their own
priority merely defines ordering within the dispatcher's list.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter.h      |  7 +++++++
 net/netfilter/nf_nat_core.c    |  6 ------
 net/netfilter/nf_nat_proto.c   |  8 ++++++++
 net/netfilter/nfnetlink_hook.c | 37 ++++++++++++++++++++++++++++++----
 4 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index efbbfa770d66..e99afc1414cd 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -93,6 +93,7 @@ enum nf_hook_ops_type {
 	NF_HOOK_OP_NF_TABLES,
 	NF_HOOK_OP_BPF,
 	NF_HOOK_OP_NFT_FT,
+	NF_HOOK_OP_NAT,
 };
 
 struct nf_hook_ops {
@@ -140,6 +141,12 @@ struct nf_hook_entries {
 	 */
 };
 
+struct nf_nat_lookup_hook_priv {
+	struct nf_hook_entries __rcu *entries;
+
+	struct rcu_head rcu_head;
+};
+
 #ifdef CONFIG_NETFILTER
 static inline struct nf_hook_ops **nf_hook_entries_get_hook_ops(const struct nf_hook_entries *e)
 {
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 63ff6b4d5d21..8ac326e1eb5b 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -39,12 +39,6 @@ static struct hlist_head *nf_nat_bysource __read_mostly;
 static unsigned int nf_nat_htable_size __read_mostly;
 static siphash_aligned_key_t nf_nat_hash_rnd;
 
-struct nf_nat_lookup_hook_priv {
-	struct nf_hook_entries __rcu *entries;
-
-	struct rcu_head rcu_head;
-};
-
 struct nf_nat_hooks_net {
 	struct nf_hook_ops *nat_hook_ops;
 	unsigned int users;
diff --git a/net/netfilter/nf_nat_proto.c b/net/netfilter/nf_nat_proto.c
index 07f51fe75fbe..64b9bac228ea 100644
--- a/net/netfilter/nf_nat_proto.c
+++ b/net/netfilter/nf_nat_proto.c
@@ -770,6 +770,7 @@ static const struct nf_hook_ops nf_nat_ipv4_ops[] = {
 		.pf		= NFPROTO_IPV4,
 		.hooknum	= NF_INET_PRE_ROUTING,
 		.priority	= NF_IP_PRI_NAT_DST,
+		.hook_ops_type	= NF_HOOK_OP_NAT,
 	},
 	/* After packet filtering, change source */
 	{
@@ -777,6 +778,7 @@ static const struct nf_hook_ops nf_nat_ipv4_ops[] = {
 		.pf		= NFPROTO_IPV4,
 		.hooknum	= NF_INET_POST_ROUTING,
 		.priority	= NF_IP_PRI_NAT_SRC,
+		.hook_ops_type	= NF_HOOK_OP_NAT,
 	},
 	/* Before packet filtering, change destination */
 	{
@@ -784,6 +786,7 @@ static const struct nf_hook_ops nf_nat_ipv4_ops[] = {
 		.pf		= NFPROTO_IPV4,
 		.hooknum	= NF_INET_LOCAL_OUT,
 		.priority	= NF_IP_PRI_NAT_DST,
+		.hook_ops_type	= NF_HOOK_OP_NAT,
 	},
 	/* After packet filtering, change source */
 	{
@@ -791,6 +794,7 @@ static const struct nf_hook_ops nf_nat_ipv4_ops[] = {
 		.pf		= NFPROTO_IPV4,
 		.hooknum	= NF_INET_LOCAL_IN,
 		.priority	= NF_IP_PRI_NAT_SRC,
+		.hook_ops_type	= NF_HOOK_OP_NAT,
 	},
 };
 
@@ -1031,6 +1035,7 @@ static const struct nf_hook_ops nf_nat_ipv6_ops[] = {
 		.pf		= NFPROTO_IPV6,
 		.hooknum	= NF_INET_PRE_ROUTING,
 		.priority	= NF_IP6_PRI_NAT_DST,
+		.hook_ops_type	= NF_HOOK_OP_NAT,
 	},
 	/* After packet filtering, change source */
 	{
@@ -1038,6 +1043,7 @@ static const struct nf_hook_ops nf_nat_ipv6_ops[] = {
 		.pf		= NFPROTO_IPV6,
 		.hooknum	= NF_INET_POST_ROUTING,
 		.priority	= NF_IP6_PRI_NAT_SRC,
+		.hook_ops_type	= NF_HOOK_OP_NAT,
 	},
 	/* Before packet filtering, change destination */
 	{
@@ -1045,6 +1051,7 @@ static const struct nf_hook_ops nf_nat_ipv6_ops[] = {
 		.pf		= NFPROTO_IPV6,
 		.hooknum	= NF_INET_LOCAL_OUT,
 		.priority	= NF_IP6_PRI_NAT_DST,
+		.hook_ops_type	= NF_HOOK_OP_NAT,
 	},
 	/* After packet filtering, change source */
 	{
@@ -1052,6 +1059,7 @@ static const struct nf_hook_ops nf_nat_ipv6_ops[] = {
 		.pf		= NFPROTO_IPV6,
 		.hooknum	= NF_INET_LOCAL_IN,
 		.priority	= NF_IP6_PRI_NAT_SRC,
+		.hook_ops_type	= NF_HOOK_OP_NAT,
 	},
 };
 
diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
index 5623c18fcd12..95005e9a6066 100644
--- a/net/netfilter/nfnetlink_hook.c
+++ b/net/netfilter/nfnetlink_hook.c
@@ -190,7 +190,7 @@ static int nfnl_hook_put_nft_ft_info(struct sk_buff *nlskb,
 
 static int nfnl_hook_dump_one(struct sk_buff *nlskb,
 			      const struct nfnl_dump_hook_data *ctx,
-			      const struct nf_hook_ops *ops,
+			      const struct nf_hook_ops *ops, int priority,
 			      int family, unsigned int seq)
 {
 	u16 event = nfnl_msg_type(NFNL_SUBSYS_HOOK, NFNL_MSG_HOOK_GET);
@@ -244,7 +244,7 @@ static int nfnl_hook_dump_one(struct sk_buff *nlskb,
 	if (ret)
 		goto nla_put_failure;
 
-	ret = nla_put_be32(nlskb, NFNLA_HOOK_PRIORITY, htonl(ops->priority));
+	ret = nla_put_be32(nlskb, NFNLA_HOOK_PRIORITY, htonl(priority));
 	if (ret)
 		goto nla_put_failure;
 
@@ -337,6 +337,30 @@ nfnl_hook_entries_head(u8 pf, unsigned int hook, struct net *net, const char *de
 	return hook_head;
 }
 
+static int nfnl_hook_dump_nat(struct sk_buff *nlskb,
+			      const struct nfnl_dump_hook_data *ctx,
+			      const struct nf_hook_ops *ops,
+			      int family, unsigned int seq)
+{
+	struct nf_nat_lookup_hook_priv *priv = ops->priv;
+	struct nf_hook_entries *e = rcu_dereference(priv->entries);
+	struct nf_hook_ops **nat_ops;
+	int i, err;
+
+	if (!e)
+		return 0;
+
+	nat_ops = nf_hook_entries_get_hook_ops(e);
+
+	for (i = 0; i < e->num_hook_entries; i++) {
+		err = nfnl_hook_dump_one(nlskb, ctx, nat_ops[i],
+					 ops->priority, family, seq);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 static int nfnl_hook_dump(struct sk_buff *nlskb,
 			  struct netlink_callback *cb)
 {
@@ -365,8 +389,13 @@ static int nfnl_hook_dump(struct sk_buff *nlskb,
 	ops = nf_hook_entries_get_hook_ops(e);
 
 	for (; i < e->num_hook_entries; i++) {
-		err = nfnl_hook_dump_one(nlskb, ctx, ops[i], family,
-					 cb->nlh->nlmsg_seq);
+		if (ops[i]->hook_ops_type == NF_HOOK_OP_NAT)
+			err = nfnl_hook_dump_nat(nlskb, ctx, ops[i], family,
+						 cb->nlh->nlmsg_seq);
+		else
+			err = nfnl_hook_dump_one(nlskb, ctx, ops[i],
+						 ops[i]->priority, family,
+						 cb->nlh->nlmsg_seq);
 		if (err)
 			break;
 	}
-- 
2.54.0


