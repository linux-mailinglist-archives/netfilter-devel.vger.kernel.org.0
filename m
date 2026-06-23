Return-Path: <netfilter-devel+bounces-13406-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ol7KCNodOmrj1gcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13406-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 07:47:06 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6CE6B43E3
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 07:47:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=c+z86n0v;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13406-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13406-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25638304699C
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 05:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84EE3A9629;
	Tue, 23 Jun 2026 05:46:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E23446A7
	for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2026 05:46:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193604; cv=none; b=sF0g2OIVCBzkah4MDTKLOrczIOyUqb4SpQV6xH/FsXOJcRaB3vl06wZoCDz9lm2Zgkdv+Plwr52T3AhFayLcn1pH+aC8gHbTnEwz3yOjt5VxfLf/RJAbOr61RhcV5qrZwbOEUPmhRbGSdZ4VaJYlJEOoP0b2c0CSLaZndym/ysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193604; c=relaxed/simple;
	bh=zHBuTbzZW550waKC4ZsA98k1TkJdP/ptGqw4k54JOH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e37NYjcwBPI/D1AJ4kCrie6k5uHhT6h7+tOkZTuRW50pFX+MHuXzTMepIZay4uF6w4Q5zgr1SGLSEpX88APNKcpGx77In6wGKxS9a5/JsDcxTH8+qJ+857nACsTfzE4EBznXc8ZWAXACT0H/c45prJ9AMH33x4rz6LwM+7UTOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=c+z86n0v; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E1C1C605A4
	for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2026 07:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782193602;
	bh=uKp5wqKqB/EWJ0RmjGU8fyXBLZc0C9RUly+BAL4EX+w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c+z86n0vAAweno63NLm9oHiNpDOgfiEhbSMDnHNJ8fHMGS9UQEGyi76Sq/aCpuxss
	 GtmyfmUF+RGimYJLw8PaHNXTC/zeSmr4krrzVwdm9Gy9ORfDNHUMU8bTR/25mv+oJW
	 S8U8IiXnhlfKwjLzGK82lgzo5BL+Hc1SdLjZc6FZF/rqr5cZYqtSOFpfJed1wJJ1c9
	 WedLQrkZHfM/EEozB8P4chjoZxyYa8E36xy74DS6iu4BTe6c8VEMW11anv3EsuHJlD
	 8YU8xchzoX1EvVAxV0FwIDdOrMKM2KnHluziAy1439bxhThKz4ZzqrF/QRtK2hzttA
	 NTFJ4QXug2rtQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v1 4/4] netfilter: nf_conntrack_helper: cap maximum number of expectation at helper registration
Date: Tue, 23 Jun 2026 07:46:35 +0200
Message-ID: <20260623054635.335065-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623054635.335065-1-pablo@netfilter.org>
References: <20260623054635.335065-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13406-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C6CE6B43E3

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
v1: resend to let sashiko pick in with this batch.

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
index 8b94001c2430..a7fffe26b830 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -374,8 +374,13 @@ int __nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 	if (!nf_ct_helper_hash)
 		return -ENOENT;
 
-	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
-		return -EINVAL;
+	for (i = 0; i < me->expect_class_max; i++) {
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


