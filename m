Return-Path: <netfilter-devel+bounces-13596-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zQBBI7dLRmoEOAsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13596-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 13:29:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5456F6B6E
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 13:29:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13596-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13596-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A04230D9E82
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jul 2026 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC63C1F26;
	Thu,  2 Jul 2026 10:51:06 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FD3C0A04;
	Thu,  2 Jul 2026 10:51:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989466; cv=none; b=GXG2XlNCBf+11UF2ngb7bnsH1J0WGsUKcxyt/tltIJlF67NmSdX291eali4RkJFEwzMVqu3RHQ9AYKRS0fQjqssxzc+lo/tr98uDsalvFb3Zsy6pcVsXLUqqv2GZscTlMlIHlY8P4vj/CeE3rWB+cbtvm+Fs6xR6GMRsrBamFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989466; c=relaxed/simple;
	bh=yXz8pA0a7Rye/dDiFDNiR2tC9kLLnoX0kp2s/xXTkdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7Myj6AIj9uA85stWwZ3eX0/XRzee6qmxeNbn7WUHJi9b5q8/4U5NbL0toUk9aetvLryMroXY+Su8Bgjn0F5PDvBwax9zUPITXnryajbP0VAVvZEqxLTPBFL/uuJopJcCYfe3fUqgVRdbzJXLvRrduBSUTK7/s9WAH2mvbW+1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D16CD606B9; Thu, 02 Jul 2026 12:51:03 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 12/12] netfilter: nft_ct: support expectation creation for natted flows
Date: Thu,  2 Jul 2026 12:50:03 +0200
Message-ID: <20260702105003.13550-13-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13596-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D5456F6B6E

This feature only works for connections originating from the host
and only if there no source address rewrite.

Add the needed nat glue to have the expectation follow the original
nat binding.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_ct.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 03a88c77e0f0..358b9287e12e 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1297,6 +1297,17 @@ static int nft_ct_expect_obj_dump(struct sk_buff *skb,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
+static void nft_ct_nat_follow_master(struct nf_conn *ct, struct nf_conntrack_expect *this)
+{
+	const struct nf_ct_helper_expectfn *expfn;
+
+	expfn = nf_ct_helper_expectfn_find_by_name("nat-follow-master");
+	if (expfn)
+		expfn->expectfn(ct, this);
+}
+#endif
+
 static void nft_ct_expect_obj_eval(struct nft_object *obj,
 				   struct nft_regs *regs,
 				   const struct nft_pktinfo *pkt)
@@ -1342,6 +1353,13 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
 		          priv->l4proto, NULL, &priv->dport);
 	exp->timeout += priv->timeout;
 
+#if IS_ENABLED(CONFIG_NF_NAT)
+	if (ct->status & IPS_NAT_MASK) {
+		exp->saved_proto.tcp.port = priv->dport;
+		exp->dir = !dir;
+		exp->expectfn = nft_ct_nat_follow_master;
+	}
+#endif
 	if (nf_ct_expect_related(exp, 0) != 0)
 		regs->verdict.code = NF_DROP;
 
@@ -1375,6 +1393,13 @@ static struct nft_object_type nft_ct_expect_obj_type __read_mostly = {
 	.owner		= THIS_MODULE,
 };
 
+#if IS_ENABLED(CONFIG_NF_NAT)
+static struct nf_ct_helper_expectfn nft_ct_nat __read_mostly = {
+	.name = "nft_ct-follow-master",
+	.expectfn = nft_ct_nat_follow_master,
+};
+#endif
+
 static int __init nft_ct_module_init(void)
 {
 	int err;
@@ -1400,6 +1425,9 @@ static int __init nft_ct_module_init(void)
 	err = nft_register_obj(&nft_ct_timeout_obj_type);
 	if (err < 0)
 		goto err4;
+#endif
+#if IS_ENABLED(CONFIG_NF_NAT)
+	nf_ct_helper_expectfn_register(&nft_ct_nat);
 #endif
 	return 0;
 
@@ -1425,6 +1453,13 @@ static void __exit nft_ct_module_exit(void)
 	nft_unregister_obj(&nft_ct_helper_obj_type);
 	nft_unregister_expr(&nft_notrack_type);
 	nft_unregister_expr(&nft_ct_type);
+
+#if IS_ENABLED(CONFIG_NF_NAT)
+	nf_ct_helper_expectfn_unregister(&nft_ct_nat);
+	synchronize_rcu();
+	nf_ct_helper_expectfn_destroy(&nft_ct_nat);
+	synchronize_rcu();
+#endif
 }
 
 module_init(nft_ct_module_init);
-- 
2.54.0


