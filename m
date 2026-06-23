Return-Path: <netfilter-devel+bounces-13434-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LtxHHNQGO2pLOwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13434-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 00:21:08 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B506BA658
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 00:21:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=W6HL6ici;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13434-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13434-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D65A30071FE
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 22:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49E73C37B3;
	Tue, 23 Jun 2026 22:16:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95B3C9893;
	Tue, 23 Jun 2026 22:16:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252977; cv=none; b=LJdaMVgoqOww43+K+3yKAWl4nzhWiy7NbdKg7BOZ20j/mBRVXiY8SIRNg0Dx6XOFtWkgRrxqBjcpfKa9oNa6ntUETXNW6PKeSpX/i/S2i1CDoRCRT4iwBeeKGfVpRsQmystFab3GFIRrk1eVVeA4QYAYisOYQuMn4O+d6bbdPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252977; c=relaxed/simple;
	bh=aA431i9XHRwdlz8EXIoj3qjcwhsOtUVntti4s7Sj03g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uN93MToZ5yyoDXPqNFNmbhpWa9f+G6dZRNAf1cpnQ7OMnUZQjIaot/RMszeHrx77BqEVRlUutXobas0w61ZEPPtQf29deBJiI3rObiGsytpT7K+FP6/I1z2yx95hZG8T0I+hrfGKYyGU5IVSzPFejCxluCjrDuvGCgtFDiXZbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=W6HL6ici; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 9632D60578;
	Wed, 24 Jun 2026 00:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782252971;
	bh=8VfnkJwQXW/HFVNgcjfeUuskYH2HnWdXcjQVzz2LOa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6HL6iciUkQedLDsERjpIYM8Bri4Xexj1/vg4VYpvNZ95XXYLAiQRhhnkAPKHHVYZ
	 a7qm/m+pCsWTjvYp69E8AWxXDN50N+mtC69PN7JDaz0LGAsL1vDI3jTwKTyIabzHAH
	 RaX3pLbnOVB1X90yaFgJmiaDSezIOssl2LFR7Cvw2zwzoutdB/wM5/Kj7rATQeZTmx
	 AU2U7SlHYy3UWYm2Eu+IxbPtSLM2ByUJFELmXJutU+cMjy5kQ/1IKG3l+/z6FlK5dJ
	 hIfVb2gfkdYxQ0GBT4VXfV0fE8jJmRBUo/4S+QGSfZf0YNLSW2RrFZpLnuLt9Zn1FE
	 FQe/bAnob+SMg==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 14/14] netfilter: nf_conntrack_helper: cap maximum number of expectation at helper registration
Date: Wed, 24 Jun 2026 00:15:47 +0200
Message-ID: <20260623221548.701545-15-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13434-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: D3B506BA658

On helper registration, the maximum number of expectations cannot go over
NF_CT_EXPECT_MAX_CNT (255), but zero can be specified then
nf_conntrack_expect_max applies. Turn zero into NF_CT_EXPECT_MAX_CNT
otherwise, expectation LRU eviction on insertion is disabled.

Moreover, expand this sanity check all expectation classes.

This max_expecy policy is only tunable since userspace helpers are
available, set Fixes: tag to the commit that adds such infrastructure.

Remove the check for p->max_expected given this field must always
be non-zero after this patch.

Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_expect.c | 3 +--
 net/netfilter/nf_conntrack_helper.c | 9 +++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 113bb1cb1683..38630c5e006f 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -496,8 +496,7 @@ static inline int __nf_ct_expect_check(struct nf_conntrack_expect *expect,
 					   lockdep_is_held(&nf_conntrack_expect_lock));
 	if (helper) {
 		p = &helper->expect_policy[expect->class];
-		if (p->max_expected &&
-		    master_help->expecting[expect->class] >= p->max_expected)
+		if (master_help->expecting[expect->class] >= p->max_expected)
 			evict_oldest_expect(master_help, expect, p);
 	} else {
 		const struct nf_conntrack_expect_policy default_exp_policy = {
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 8b94001c2430..500509b17663 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -374,8 +374,13 @@ int __nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 	if (!nf_ct_helper_hash)
 		return -ENOENT;
 
-	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
-		return -EINVAL;
+	for (i = 0; i <= me->expect_class_max; i++) {
+		if (!me->expect_policy[i].max_expected)
+			me->expect_policy[i].max_expected = NF_CT_EXPECT_MAX_CNT;
+
+		if (me->expect_policy[i].max_expected > NF_CT_EXPECT_MAX_CNT)
+			return -EINVAL;
+	}
 
 	mutex_lock(&nf_ct_helper_mutex);
 	for (i = 0; i < nf_ct_helper_hsize; i++) {
-- 
2.47.3


