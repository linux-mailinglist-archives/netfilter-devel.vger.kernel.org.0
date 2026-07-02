Return-Path: <netfilter-devel+bounces-13586-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nezxLdxFRmoZNgsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13586-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 13:05:00 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF766F664F
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 13:05:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13586-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13586-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC0B306261A
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jul 2026 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE83ACA5B;
	Thu,  2 Jul 2026 10:50:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40723ACA64;
	Thu,  2 Jul 2026 10:50:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989424; cv=none; b=dzN3ZWpi4/IKNcvPK6zctVYNmBy3zgl3FPT09d3oecOj6VMgSfhBcv2NFmW3m2ugXv6m/4MICILajuphICSqgY9uYF+LOoQXEiuPLJ5UxT51yG9dJZZghk8xNTIsCmGsHbxc/uBLsd/LS+caqm7X0yuuGNnhfnQXCuLTYzq/0nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989424; c=relaxed/simple;
	bh=6j4dqiXeB6O8iPce9uppX9Fhkr9FogfrOhqB/0Uo5gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh3jvNU7NLgKKfmzAQTfkla7vKAmI9InU+348jCpbhhpN528D0VDQJjrby0BUutgQTqRXBSFrdjJ7S8VivA7gedcy8uo3b4qcsiCz+on7AFqzbV+xrRKGxwYaugnVZ6OvkjCQJ8IEhl6iYg/WeSSmLIhziOTnpZTOdBtMxPrMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 344766032C; Thu, 02 Jul 2026 12:50:21 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 02/12] netfilter: x_tables: replace strlcat() with snprintf()
Date: Thu,  2 Jul 2026 12:49:53 +0200
Message-ID: <20260702105003.13550-3-fw@strlen.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13586-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FF766F664F

From: Ian Bridges <icb@fastmail.org>

In preparation for removing the deprecated strlcat() API[1], replace the
strscpy()/strlcat() pairs in xt_proto_init() and xt_proto_fini() with
snprintf(), which builds each /proc file name in a single call.

Each name is "<prefix><suffix>", where <prefix> is the address-family
string xt_prefix[af] and <suffix> is one of the FORMAT_TABLES,
FORMAT_MATCHES or FORMAT_TARGETS literals. Prepend %s to the FORMAT
macros and switch to snprintf().

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/x_tables.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 4e6708c23922..e64116bf2637 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1920,9 +1920,9 @@ static const struct seq_operations xt_target_seq_ops = {
 	.show	= xt_target_seq_show,
 };
 
-#define FORMAT_TABLES	"_tables_names"
-#define	FORMAT_MATCHES	"_tables_matches"
-#define FORMAT_TARGETS 	"_tables_targets"
+#define FORMAT_TABLES	"%s_tables_names"
+#define	FORMAT_MATCHES	"%s_tables_matches"
+#define FORMAT_TARGETS	"%s_tables_targets"
 
 #endif /* CONFIG_PROC_FS */
 
@@ -2033,8 +2033,7 @@ int xt_proto_init(struct net *net, u_int8_t af)
 	root_uid = make_kuid(net->user_ns, 0);
 	root_gid = make_kgid(net->user_ns, 0);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TABLES, sizeof(buf));
+	snprintf(buf, sizeof(buf), FORMAT_TABLES, xt_prefix[af]);
 	proc = proc_create_net_data(buf, 0440, net->proc_net, &xt_table_seq_ops,
 			sizeof(struct seq_net_private),
 			(void *)(unsigned long)af);
@@ -2043,8 +2042,7 @@ int xt_proto_init(struct net *net, u_int8_t af)
 	if (uid_valid(root_uid) && gid_valid(root_gid))
 		proc_set_user(proc, root_uid, root_gid);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
+	snprintf(buf, sizeof(buf), FORMAT_MATCHES, xt_prefix[af]);
 	proc = proc_create_seq_private(buf, 0440, net->proc_net,
 			&xt_match_seq_ops, sizeof(struct nf_mttg_trav),
 			(void *)(unsigned long)af);
@@ -2053,8 +2051,7 @@ int xt_proto_init(struct net *net, u_int8_t af)
 	if (uid_valid(root_uid) && gid_valid(root_gid))
 		proc_set_user(proc, root_uid, root_gid);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
+	snprintf(buf, sizeof(buf), FORMAT_TARGETS, xt_prefix[af]);
 	proc = proc_create_seq_private(buf, 0440, net->proc_net,
 			 &xt_target_seq_ops, sizeof(struct nf_mttg_trav),
 			 (void *)(unsigned long)af);
@@ -2068,13 +2065,11 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 #ifdef CONFIG_PROC_FS
 out_remove_matches:
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
+	snprintf(buf, sizeof(buf), FORMAT_MATCHES, xt_prefix[af]);
 	remove_proc_entry(buf, net->proc_net);
 
 out_remove_tables:
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TABLES, sizeof(buf));
+	snprintf(buf, sizeof(buf), FORMAT_TABLES, xt_prefix[af]);
 	remove_proc_entry(buf, net->proc_net);
 out:
 	return -1;
@@ -2087,16 +2082,13 @@ void xt_proto_fini(struct net *net, u_int8_t af)
 #ifdef CONFIG_PROC_FS
 	char buf[XT_FUNCTION_MAXNAMELEN];
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TABLES, sizeof(buf));
+	snprintf(buf, sizeof(buf), FORMAT_TABLES, xt_prefix[af]);
 	remove_proc_entry(buf, net->proc_net);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
+	snprintf(buf, sizeof(buf), FORMAT_TARGETS, xt_prefix[af]);
 	remove_proc_entry(buf, net->proc_net);
 
-	strscpy(buf, xt_prefix[af], sizeof(buf));
-	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
+	snprintf(buf, sizeof(buf), FORMAT_MATCHES, xt_prefix[af]);
 	remove_proc_entry(buf, net->proc_net);
 #endif /*CONFIG_PROC_FS*/
 }
-- 
2.54.0


