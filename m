Return-Path: <netfilter-devel+bounces-13431-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WTMQJncGO2olOwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13431-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 00:19:35 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EB46BA63E
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 00:19:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=e+bKp6qs;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13431-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13431-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CBA530E0E6E
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2F3C6A43;
	Tue, 23 Jun 2026 22:16:11 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A553C2B80;
	Tue, 23 Jun 2026 22:16:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252971; cv=none; b=hPh+QFuRJ02m/1GhW5mxCukHWpH5bqYWV/1PCVlVdgEnFGohRulHDcU5wHVixUIVjXRZkiziqWb7d7kYvgG2VemBQBIjUf00BzYshAn7g9SSbyLA3l+2UFvPs2lBScERWlb3iAl7R2b1ikKyHjEppruFgaW/UedbsEhy3CV//00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252971; c=relaxed/simple;
	bh=Z5VRN2JRtxpRUAM3dZobPdVCHO3ep3XUKyavmw8XuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQ7wDBQGjOvRCRQ6ag/DzzvirhO1Tv//00tT8E+805C3muIkWTKg/g5AvqHxBBED+yXRAh+ADk5kTYcji82XmJZZsDRGwuefWIiJptoiH9OZGYY2TBDg7+Z42arWUTRv8plbhtbA/OWmUpbO4G9SEP6kM8sviGX08xmGq3YgXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=e+bKp6qs; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id DCCA060585;
	Wed, 24 Jun 2026 00:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782252967;
	bh=M5CTEJPOXsDfRxeKORugO36vFdcyuQ5+lpU4qSmlYRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+bKp6qslSrCv79NVfJm6f6MgSmkjD7g2nsqJlfhO9PgogryJSv8B0sgbUHzTu47I
	 JUrz/Dpjbj9UoqPv8f1BEyEWlrFFXrqQ4B8A9fBg5ZcUTt3Eitva5vScP1DFDxMQtc
	 cF4/K7y3XK/402EFRENIBbfBrEvRE6KTgzzGKMBPZLL50ENDGJWtx37oRQmg9KpJ0e
	 +nLmlKRVmKI26K/rH676o77wp4bhlitdwaMUsO8AuMGkncoNcBbpYVu/g96Dc/kXry
	 iknk/KmcER1hkogpZQxIsCWobuW+IVQKuqmvayCjfH/pbzxzUCazxh/eeYz9E6anKR
	 sF0e9nm3BXPjA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 11/14] netfilter: nf_conntrack_expect: store master_tuple in expectation
Date: Wed, 24 Jun 2026 00:15:44 +0200
Message-ID: <20260623221548.701545-12-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623221548.701545-1-pablo@netfilter.org>
References: <20260623221548.701545-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13431-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid,netfilter.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06EB46BA63E

Store master conntrack tuple in the expectation since exp->master might
refer to a different conntrack when accessed from rcu read side lock
area due to typesafe rcu rules.

Fixes: 02a3231b6d82 ("netfilter: nf_conntrack_expect: store netns and zone in expectation")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_conntrack_expect.h |  1 +
 net/netfilter/nf_conntrack_broadcast.c      |  1 +
 net/netfilter/nf_conntrack_expect.c         |  2 ++
 net/netfilter/nf_conntrack_netlink.c        | 10 ++++------
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_expect.h b/include/net/netfilter/nf_conntrack_expect.h
index be4a120d549e..c024345c9bd8 100644
--- a/include/net/netfilter/nf_conntrack_expect.h
+++ b/include/net/netfilter/nf_conntrack_expect.h
@@ -26,6 +26,7 @@ struct nf_conntrack_expect {
 	possible_net_t net;
 
 	/* We expect this tuple, with the following mask */
+	struct nf_conntrack_tuple master_tuple;
 	struct nf_conntrack_tuple tuple;
 	struct nf_conntrack_tuple_mask mask;
 
diff --git a/net/netfilter/nf_conntrack_broadcast.c b/net/netfilter/nf_conntrack_broadcast.c
index 400119b6320e..bf78828c7549 100644
--- a/net/netfilter/nf_conntrack_broadcast.c
+++ b/net/netfilter/nf_conntrack_broadcast.c
@@ -62,6 +62,7 @@ int nf_conntrack_broadcast_help(struct sk_buff *skb,
 	if (exp == NULL)
 		goto out;
 
+	exp->master_tuple	  = ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;
 	exp->tuple                = ct->tuplehash[IP_CT_DIR_REPLY].tuple;
 
 	helper = rcu_dereference(help->helper);
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 49e18eda037e..9454913e1b33 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -355,6 +355,8 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
 	exp->tuple.src.l3num = family;
 	exp->tuple.dst.protonum = proto;
 
+	exp->master_tuple = ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;
+
 	if (saddr) {
 		memcpy(&exp->tuple.src.u3, saddr, len);
 		if (sizeof(exp->tuple.src.u3) > len)
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index cb38ef42e9e6..4217715d42dc 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3002,7 +3002,6 @@ ctnetlink_exp_dump_expect(struct sk_buff *skb,
 			  const struct nf_conntrack_expect *exp)
 {
 	__s32 timeout = (__s32)(READ_ONCE(exp->timeout) - nfct_time_stamp) / HZ;
-	struct nf_conn *master = exp->master;
 	struct nf_conntrack_helper *helper;
 #if IS_ENABLED(CONFIG_NF_NAT)
 	struct nlattr *nest_parms;
@@ -3017,9 +3016,7 @@ ctnetlink_exp_dump_expect(struct sk_buff *skb,
 		goto nla_put_failure;
 	if (ctnetlink_exp_dump_mask(skb, &exp->tuple, &exp->mask) < 0)
 		goto nla_put_failure;
-	if (ctnetlink_exp_dump_tuple(skb,
-				 &master->tuplehash[IP_CT_DIR_ORIGINAL].tuple,
-				 CTA_EXPECT_MASTER) < 0)
+	if (ctnetlink_exp_dump_tuple(skb, &exp->master_tuple, CTA_EXPECT_MASTER) < 0)
 		goto nla_put_failure;
 
 #if IS_ENABLED(CONFIG_NF_NAT)
@@ -3032,9 +3029,9 @@ ctnetlink_exp_dump_expect(struct sk_buff *skb,
 		if (nla_put_be32(skb, CTA_EXPECT_NAT_DIR, htonl(exp->dir)))
 			goto nla_put_failure;
 
-		nat_tuple.src.l3num = nf_ct_l3num(master);
+		nat_tuple.src.l3num = exp->master_tuple.src.l3num;
 		nat_tuple.src.u3 = exp->saved_addr;
-		nat_tuple.dst.protonum = nf_ct_protonum(master);
+		nat_tuple.dst.protonum = exp->master_tuple.dst.protonum;
 		nat_tuple.src.u = exp->saved_proto;
 
 		if (ctnetlink_exp_dump_tuple(skb, &nat_tuple,
@@ -3576,6 +3573,7 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 #endif
 	rcu_assign_pointer(exp->helper, helper);
 	rcu_assign_pointer(exp->assign_helper, assign_helper);
+	exp->master_tuple = ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple;
 	exp->tuple = *tuple;
 	exp->mask.src.u3 = mask->src.u3;
 	exp->mask.src.u.all = mask->src.u.all;
-- 
2.47.3


