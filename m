Return-Path: <netfilter-devel+bounces-13272-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ad8MDwsBMGqFLgUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13272-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 15:41:31 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD52C686D1B
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 15:41:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=carlosgrillet.me header.s=zmail header.b=ifRVySHL;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13272-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13272-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751403094CB9
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCA3F54C8;
	Mon, 15 Jun 2026 13:39:34 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748ED3F1ADB;
	Mon, 15 Jun 2026 13:39:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530774; cv=pass; b=rN67AJKJ8KIkx1o2G/tmCTbwT5FViLFEaD4r0tTURZn2Sz9ARtnhs3Lh3O+03U2vADczuM4rbCmXOUo6ujKeiG3TSkw8ek2CNQiyB/e7yGE+7gLAi2WqqJlkmr83j8UbHhgTiyOvsDZyz0Ny/p/T91fETuprWeQe3TrPVDAsRvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530774; c=relaxed/simple;
	bh=2A6STF/MS+4ul6GuxfPH6JzRgXXUBeXshuUyEuGTass=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHmVQ0dX6nMubPyEWUPTU0hGkK2Haof26bJ/IhibQOZGI+3W7M3T47lj+FbL/8nC1G6K1gRn/RzCsFSjGouwh9063NMCfVYdbQpkFUwt1xRUW8Rs4zymXyD1F8dZvLMzOBLPRtqoRw307SnqbFM20pUZInRsT5GehSAbyyqRj3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=carlosgrillet.me; spf=pass smtp.mailfrom=carlosgrillet.me; dkim=pass (1024-bit key) header.d=carlosgrillet.me header.i=carlos@carlosgrillet.me header.b=ifRVySHL; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1781530747; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=INcEJzgGC3OmluO+0JakfsiJH4MYa+VtrQXs0R5oHX6fvrStgqyQU1GquSEKKaZJvA8mJ6+R9jI2vk7/Z/kMq18GlxzDVyqdLfLwytiNKSHbE5/vO064X7lcCZhUHFXraPP1Xo0KJ2z9495RDOhvmL3UA/yrJaNaV1for7+/izg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1781530747; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e3M0BYPSTdgDLkWHJBCNI7FKNBWlduHVIRnKBaVQo0Y=; 
	b=PdtpukDJ1YXVZxE5O3aLu30BhnjBepdfOkC16mgMyXjZyeDD+KUMPIxoRiDE+icC5jA8FHoUKwR+2m0s9C1L4+Ed6W54KDHIhrVME+k8aj4tmHdiazXeSftx14cXF/tddQQcSE2FPqYJJB1x5zTO3FENAgA5VGPubjTYYAmjrjw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=carlosgrillet.me;
	spf=pass  smtp.mailfrom=carlos@carlosgrillet.me;
	dmarc=pass header.from=<carlos@carlosgrillet.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781530747;
	s=zmail; d=carlosgrillet.me; i=carlos@carlosgrillet.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=e3M0BYPSTdgDLkWHJBCNI7FKNBWlduHVIRnKBaVQo0Y=;
	b=ifRVySHLlczo+JzaesVfz3oW6wk19d+4aRVjpF47jTRYOwICf+In/iLMVMhpujdR
	9S/IrpsanmTloWA0qXNUDd5C6q5IV4PJ3m4Q9DppusHmk9yyefssBPJUOF4dw/PyRTF
	hXH6oFyVWug5q8wuDTXGtWAycHSeYBxrRoDGVc/4=
Received: by mx.zoho.eu with SMTPS id 1781530745922740.3070521561446;
	Mon, 15 Jun 2026 15:39:05 +0200 (CEST)
From: Carlos Grillet <carlos@carlosgrillet.me>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH nf-next v2 3/6] netfilter: nf_sockopt: replace u_int8_t with u8
Date: Mon, 15 Jun 2026 15:38:28 +0200
Message-ID: <20260615133835.51273-4-carlos@carlosgrillet.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615133835.51273-1-carlos@carlosgrillet.me>
References: <20260615133835.51273-1-carlos@carlosgrillet.me>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[carlosgrillet.me:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13272-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	DMARC_NA(0.00)[carlosgrillet.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos@carlosgrillet.me,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[carlosgrillet.me:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,carlosgrillet.me:dkim,carlosgrillet.me:email,carlosgrillet.me:mid,carlosgrillet.me:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD52C686D1B

Replace POSIX u_int8_t with preferred kernel type u8, update prototype
and struct definition.

No functional changes.

Signed-off-by: Carlos Grillet <carlos@carlosgrillet.me>
---
 include/linux/netfilter.h  | 6 +++---
 net/netfilter/nf_sockopt.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index efbbfa770d66..91b68bdba3f5 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -181,7 +181,7 @@ static inline void nf_hook_state_init(struct nf_hook_state *p,
 struct nf_sockopt_ops {
 	struct list_head list;
 
-	u_int8_t pf;
+	u8 pf;
 
 	/* Non-inclusive ranges: use 0/0/NULL to never get called. */
 	int set_optmin;
@@ -357,9 +357,9 @@ NF_HOOK_LIST(uint8_t pf, unsigned int hook, struct net *net, struct sock *sk,
 }
 
 /* Call setsockopt() */
-int nf_setsockopt(struct sock *sk, u_int8_t pf, int optval, sockptr_t opt,
+int nf_setsockopt(struct sock *sk, u8 pf, int optval, sockptr_t opt,
 		  unsigned int len);
-int nf_getsockopt(struct sock *sk, u_int8_t pf, int optval, char __user *opt,
+int nf_getsockopt(struct sock *sk, u8 pf, int optval, char __user *opt,
 		  int *len);
 
 struct flowi;
diff --git a/net/netfilter/nf_sockopt.c b/net/netfilter/nf_sockopt.c
index 34afcd03b6f6..19a1d028158c 100644
--- a/net/netfilter/nf_sockopt.c
+++ b/net/netfilter/nf_sockopt.c
@@ -59,8 +59,8 @@ void nf_unregister_sockopt(struct nf_sockopt_ops *reg)
 }
 EXPORT_SYMBOL(nf_unregister_sockopt);
 
-static struct nf_sockopt_ops *nf_sockopt_find(struct sock *sk, u_int8_t pf,
-		int val, int get)
+static struct nf_sockopt_ops *nf_sockopt_find(struct sock *sk, u8 pf,
+					      int val, int get)
 {
 	struct nf_sockopt_ops *ops;
 
@@ -89,7 +89,7 @@ static struct nf_sockopt_ops *nf_sockopt_find(struct sock *sk, u_int8_t pf,
 	return ops;
 }
 
-int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, sockptr_t opt,
+int nf_setsockopt(struct sock *sk, u8 pf, int val, sockptr_t opt,
 		  unsigned int len)
 {
 	struct nf_sockopt_ops *ops;
@@ -104,7 +104,7 @@ int nf_setsockopt(struct sock *sk, u_int8_t pf, int val, sockptr_t opt,
 }
 EXPORT_SYMBOL(nf_setsockopt);
 
-int nf_getsockopt(struct sock *sk, u_int8_t pf, int val, char __user *opt,
+int nf_getsockopt(struct sock *sk, u8 pf, int val, char __user *opt,
 		  int *len)
 {
 	struct nf_sockopt_ops *ops;
-- 
2.54.0


