Return-Path: <netfilter-devel+bounces-12873-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOuVMhzUFWrRcgcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12873-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 19:10:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0C5DA621
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 19:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5EA4314B728
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808553D47CB;
	Tue, 26 May 2026 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="DaSoyxzE"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C23CDBB7
	for <netfilter-devel@vger.kernel.org>; Tue, 26 May 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813661; cv=none; b=LuP7dlvjpj11VtPcRv8Y5PLh4yca7LGuC4/lLu/WUQ3qaDqCj+0QIseScYEj6uP8nfaJznS848HS+TRT+n7GY5jaXjgf2WmEa25oaCHxPfb4geR6pXhoijxQwiuq+hM9kJXbk86MkYPf1fuCBuFfgiXYJ/HtCbsAVfLU8GsZwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813661; c=relaxed/simple;
	bh=FRocLct9yf8B5Q1BHPkogeeW88tDJW+arFoeAKfhAIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxmGbxR4M8S2/a3s2TJ9TiAB/6kuDBgtX+x3StNYAp1EOTxprS+XSiAxBIpkzI7FIeny+fZdvjsSYaTB1eu3oVEwWW94IY+CSbUVoa1W6CbGCKe5/9DayHD5EH0BZeUxWajdJe8G/p/0WZwKDMOVZNEYrs3pP1IN26MMnfeX7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=DaSoyxzE; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 63779604FC;
	Tue, 26 May 2026 18:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1779813657;
	bh=jm8apwYagPKvlLotsYgylRksqtbtE5qhVmQ7xOMm+KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DaSoyxzEj4NeIoVjI+fu7kobqxUhRgU7oeLnPh/mGK2cCySTv3lJXdTGSEzFU4J9C
	 qiyQU5YRSmdv2mhxon+Aj1WvXQLI64bCCcx3yQRx6F2RpoYkZy8J+NKHB1lQPjn8/O
	 m33V0lTUxDyCGtHCblTIR0R7xQoVNkcjXKdoqv0fknVO4wa9zpzh8MlbIhMrckt8bJ
	 zy5HwoITJQZ9/6Vi8dVAmth/EjFuy9aBtLS+XzWU6yzuUZL8Ui+3BfsnAiH+HLdQQA
	 35Iaw9s0WCobRMRES7y8BLh/6TVzQnlf/2pOPAKVnhFKXRCyFb2br+n93DRcIPijNd
	 WFsoBxUiNDNJg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf-next 4/6] netfilter: nf_conntrack_pptp: move GRE specific cleanup to GRE tracker
Date: Tue, 26 May 2026 18:40:47 +0200
Message-ID: <20260526164049.148218-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526164049.148218-1-pablo@netfilter.org>
References: <20260526164049.148218-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-12873-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:email,netfilter.org:mid,netfilter.org:dkim]
X-Rspamd-Queue-Id: 54E0C5DA621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the GRE specific cleanup to nf_conntrack_proto_gre.c to ensure that
the .destroy callback for the pptp helper is still reachable by existing
conntrack entries while pptp module is being removed.

This is a preparation patch, no functional changes are intended.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../net/netfilter/ipv4/nf_conntrack_ipv4.h    |  4 ++
 net/netfilter/nf_conntrack_pptp.c             | 63 +------------------
 net/netfilter/nf_conntrack_proto_gre.c        | 61 ++++++++++++++++++
 3 files changed, 67 insertions(+), 61 deletions(-)

diff --git a/include/net/netfilter/ipv4/nf_conntrack_ipv4.h b/include/net/netfilter/ipv4/nf_conntrack_ipv4.h
index b39417ad955e..0b07d5e69c15 100644
--- a/include/net/netfilter/ipv4/nf_conntrack_ipv4.h
+++ b/include/net/netfilter/ipv4/nf_conntrack_ipv4.h
@@ -20,4 +20,8 @@ extern const struct nf_conntrack_l4proto nf_conntrack_l4proto_sctp;
 extern const struct nf_conntrack_l4proto nf_conntrack_l4proto_gre;
 #endif
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_PPTP)
+void gre_pptp_destroy_siblings(struct nf_conn *ct);
+#endif
+
 #endif /*_NF_CONNTRACK_IPV4_H*/
diff --git a/net/netfilter/nf_conntrack_pptp.c b/net/netfilter/nf_conntrack_pptp.c
index 1c0b310d4b63..16147cf71088 100644
--- a/net/netfilter/nf_conntrack_pptp.c
+++ b/net/netfilter/nf_conntrack_pptp.c
@@ -124,65 +124,6 @@ static void pptp_expectfn(struct nf_conn *ct,
 	}
 }
 
-static int destroy_sibling_or_exp(struct net *net, struct nf_conn *ct,
-				  const struct nf_conntrack_tuple *t)
-{
-	const struct nf_conntrack_tuple_hash *h;
-	const struct nf_conntrack_zone *zone;
-	struct nf_conntrack_expect *exp;
-	struct nf_conn *sibling;
-
-	pr_debug("trying to timeout ct or exp for tuple ");
-	nf_ct_dump_tuple(t);
-
-	zone = nf_ct_zone(ct);
-	h = nf_conntrack_find_get(net, zone, t);
-	if (h)  {
-		sibling = nf_ct_tuplehash_to_ctrack(h);
-		pr_debug("setting timeout of conntrack %p to 0\n", sibling);
-		sibling->proto.gre.timeout	  = 0;
-		sibling->proto.gre.stream_timeout = 0;
-		nf_ct_kill(sibling);
-		nf_ct_put(sibling);
-		return 1;
-	} else {
-		exp = nf_ct_expect_find_get(net, zone, t);
-		if (exp) {
-			pr_debug("unexpect_related of expect %p\n", exp);
-			nf_ct_unexpect_related(exp);
-			nf_ct_expect_put(exp);
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/* timeout GRE data connections */
-static void pptp_destroy_siblings(struct nf_conn *ct)
-{
-	struct net *net = nf_ct_net(ct);
-	const struct nf_ct_pptp_master *ct_pptp_info = nfct_help_data(ct);
-	struct nf_conntrack_tuple t;
-
-	nf_ct_gre_keymap_destroy(ct);
-
-	/* try original (pns->pac) tuple */
-	memcpy(&t, &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple, sizeof(t));
-	t.dst.protonum = IPPROTO_GRE;
-	t.src.u.gre.key = ct_pptp_info->pns_call_id;
-	t.dst.u.gre.key = ct_pptp_info->pac_call_id;
-	if (!destroy_sibling_or_exp(net, ct, &t))
-		pr_debug("failed to timeout original pns->pac ct/exp\n");
-
-	/* try reply (pac->pns) tuple */
-	memcpy(&t, &ct->tuplehash[IP_CT_DIR_REPLY].tuple, sizeof(t));
-	t.dst.protonum = IPPROTO_GRE;
-	t.src.u.gre.key = ct_pptp_info->pac_call_id;
-	t.dst.u.gre.key = ct_pptp_info->pns_call_id;
-	if (!destroy_sibling_or_exp(net, ct, &t))
-		pr_debug("failed to timeout reply pac->pns ct/exp\n");
-}
-
 /* expect GRE connections (PNS->PAC and PAC->PNS direction) */
 static int exp_gre(struct nf_conn *ct, __be16 callid, __be16 peer_callid)
 {
@@ -347,7 +288,7 @@ pptp_inbound_pkt(struct sk_buff *skb, unsigned int protoff,
 		info->cstate = PPTP_CALL_NONE;
 
 		/* untrack this call id, unexpect GRE packets */
-		pptp_destroy_siblings(ct);
+		gre_pptp_destroy_siblings(ct);
 		break;
 
 	case PPTP_WAN_ERROR_NOTIFY:
@@ -597,7 +538,7 @@ static int __init nf_conntrack_pptp_init(void)
 			  "pptp", PPTP_CONTROL_PORT, PPTP_CONTROL_PORT, PPTP_CONTROL_PORT,
 			  &pptp_exp_policy, 0, conntrack_pptp_help, NULL, THIS_MODULE);
 
-	pptp.destroy = pptp_destroy_siblings;
+	pptp.destroy = gre_pptp_destroy_siblings;
 
 	return nf_conntrack_helper_register(&pptp, &pptp_ptr);
 }
diff --git a/net/netfilter/nf_conntrack_proto_gre.c b/net/netfilter/nf_conntrack_proto_gre.c
index 94c19bc4edc5..a3f907416ff3 100644
--- a/net/netfilter/nf_conntrack_proto_gre.c
+++ b/net/netfilter/nf_conntrack_proto_gre.c
@@ -293,6 +293,67 @@ gre_timeout_nla_policy[CTA_TIMEOUT_GRE_MAX+1] = {
 };
 #endif /* CONFIG_NF_CONNTRACK_TIMEOUT */
 
+#if IS_ENABLED(CONFIG_NF_CONNTRACK_PPTP)
+static int destroy_sibling_or_exp(struct net *net, struct nf_conn *ct,
+				  const struct nf_conntrack_tuple *t)
+{
+	const struct nf_conntrack_tuple_hash *h;
+	const struct nf_conntrack_zone *zone;
+	struct nf_conntrack_expect *exp;
+	struct nf_conn *sibling;
+
+	pr_debug("trying to timeout ct or exp for tuple ");
+	nf_ct_dump_tuple(t);
+
+	zone = nf_ct_zone(ct);
+	h = nf_conntrack_find_get(net, zone, t);
+	if (h)  {
+		sibling = nf_ct_tuplehash_to_ctrack(h);
+		pr_debug("setting timeout of conntrack %p to 0\n", sibling);
+		sibling->proto.gre.timeout        = 0;
+		sibling->proto.gre.stream_timeout = 0;
+		nf_ct_kill(sibling);
+		nf_ct_put(sibling);
+		return 1;
+	} else {
+		exp = nf_ct_expect_find_get(net, zone, t);
+		if (exp) {
+			pr_debug("unexpect_related of expect %p\n", exp);
+			nf_ct_unexpect_related(exp);
+			nf_ct_expect_put(exp);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+void gre_pptp_destroy_siblings(struct nf_conn *ct)
+{
+	struct net *net = nf_ct_net(ct);
+	const struct nf_ct_pptp_master *ct_pptp_info = nfct_help_data(ct);
+	struct nf_conntrack_tuple t;
+
+	nf_ct_gre_keymap_destroy(ct);
+
+	/* try original (pns->pac) tuple */
+	memcpy(&t, &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple, sizeof(t));
+	t.dst.protonum = IPPROTO_GRE;
+	t.src.u.gre.key = ct_pptp_info->pns_call_id;
+	t.dst.u.gre.key = ct_pptp_info->pac_call_id;
+	if (!destroy_sibling_or_exp(net, ct, &t))
+		pr_debug("failed to timeout original pns->pac ct/exp\n");
+
+	/* try reply (pac->pns) tuple */
+	memcpy(&t, &ct->tuplehash[IP_CT_DIR_REPLY].tuple, sizeof(t));
+	t.dst.protonum = IPPROTO_GRE;
+	t.src.u.gre.key = ct_pptp_info->pac_call_id;
+	t.dst.u.gre.key = ct_pptp_info->pns_call_id;
+	if (!destroy_sibling_or_exp(net, ct, &t))
+		pr_debug("failed to timeout reply pac->pns ct/exp\n");
+}
+EXPORT_SYMBOL_GPL(gre_pptp_destroy_siblings);
+#endif
+
 void nf_conntrack_gre_init_net(struct net *net)
 {
 	struct nf_gre_net *net_gre = gre_pernet(net);
-- 
2.47.3


