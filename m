Return-Path: <netfilter-devel+bounces-13916-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pTPNLZUOVWrfjQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13916-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 18:13:09 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 108E774D765
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 18:13:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=WjbNEaAm;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13916-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13916-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C2E3140B1B
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B1331EC2;
	Mon, 13 Jul 2026 16:07:09 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB6C331EBD
	for <netfilter-devel@vger.kernel.org>; Mon, 13 Jul 2026 16:07:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958828; cv=none; b=ZXvmU4/KDu7XfINveb4ZyT3HeW/2+ObNCdEG5uVfyUvvXtE6nU94cGKC2bySOZey39b1mTkefwgV2aQH4zyPCG3ZTs0youW4sh7QC8uYvt5/jyaEDQLfQuTFw8sS8Hi5lY6gHvB8mMKqRlryFR6t7RN9bOWfCwMgjPSpVxoS/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958828; c=relaxed/simple;
	bh=/6ShAaTGo/nNDFEBzkxv79qzJ8KZ82OAzqXky8kSwGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWq1b/aTRdpsqPfAm74s+Tj51uUcD2H1aB7jJGUqRlN5zEYhcR3n/DveNo9D72P3LzRl97CAOAF6WYPcc6A77+J+AyffRC6xTyuUMrYMEV0NCtn5X4qF7gih74yrdbHhgEcGY63OBGsrHpjryrh8OIvgHI7+rodh1xLJ1qZbdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WjbNEaAm; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id CDBAF602A9
	for <netfilter-devel@vger.kernel.org>; Mon, 13 Jul 2026 18:07:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783958823;
	bh=MgIowq5HlH/kfLKpkaomLS+to2yS14kNUzQBz2Iv5EU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WjbNEaAmby+yjGAXCLHIV0UF/VXMwn26xWYLAaWImj4nDD/OkNmT7HVwkQdXMdYbY
	 QRFd5V3Whe4GfbAXVyQIERQJR8P03TrcWujAozjyclZfnSUV52U5GmhJ2jVEzKOKX2
	 I2qkWf/BpmIi6nNOQNdvtGD5hDxdL+ns/brRFfNkFlINKWnuZuXkSfv4bVyYNq4Y0+
	 JFVlytaP667edJ9Sc/UayiyttVDY4PNN+DDl5atxD2A5qjsjDAt2mfM7krckGduv4R
	 hm9GWaQeEXRRHmqhkrWGonO8sBQrFcrlHgfkYC5t9THP7r+v4iIVmg7tgBfoXWUxfQ
	 cxujWNqnu24aA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 2/2] netfilter: nf_conntrack_expect: store event cache in expectation
Date: Mon, 13 Jul 2026 18:06:58 +0200
Message-ID: <20260713160658.1711939-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713160658.1711939-1-pablo@netfilter.org>
References: <20260713160658.1711939-1-pablo@netfilter.org>
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
	TAGGED_FROM(0.00)[bounces-13916-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:from_mime,netfilter.org:mid,netfilter.org:email,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 108E774D765

Store the event cache in the expectation instead of accessing the
exp->master cache, as a step forward towards turning the exp->master
into a cookie.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_conntrack_expect.h | 3 +++
 net/netfilter/nf_conntrack_broadcast.c      | 6 ++++++
 net/netfilter/nf_conntrack_ecache.c         | 7 +------
 net/netfilter/nf_conntrack_expect.c         | 5 +++++
 net/netfilter/nf_conntrack_netlink.c        | 5 +++++
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_expect.h b/include/net/netfilter/nf_conntrack_expect.h
index c024345c9bd8..5d0f5b2f12a7 100644
--- a/include/net/netfilter/nf_conntrack_expect.h
+++ b/include/net/netfilter/nf_conntrack_expect.h
@@ -42,6 +42,9 @@ struct nf_conntrack_expect {
 	/* Expectation class */
 	unsigned int class;
 
+	/* Event filter mask */
+	u16 event_mask;
+
 	/* Function to call after setup and insertion */
 	void (*expectfn)(struct nf_conn *new,
 			 struct nf_conntrack_expect *this);
diff --git a/net/netfilter/nf_conntrack_broadcast.c b/net/netfilter/nf_conntrack_broadcast.c
index 6ff954f1bfb8..0922e30b6ab0 100644
--- a/net/netfilter/nf_conntrack_broadcast.c
+++ b/net/netfilter/nf_conntrack_broadcast.c
@@ -14,6 +14,7 @@
 #include <net/netfilter/nf_conntrack.h>
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <net/netfilter/nf_conntrack_expect.h>
+#include <net/netfilter/nf_conntrack_ecache.h>
 
 int nf_conntrack_broadcast_help(struct sk_buff *skb,
 				struct nf_conn *ct,
@@ -27,6 +28,7 @@ int nf_conntrack_broadcast_help(struct sk_buff *skb,
 	struct rtable *rt = skb_rtable(skb);
 	struct in_device *in_dev;
 	struct nf_conn_help *help = nfct_help(ct);
+	struct nf_conntrack_ecache *ecache;
 	__be32 mask = 0;
 
 	if (!help)
@@ -79,6 +81,10 @@ int nf_conntrack_broadcast_help(struct sk_buff *skb,
 #ifdef CONFIG_NF_CONNTRACK_ZONES
 	exp->zone = ct->zone;
 #endif
+	ecache = nf_ct_ecache_find(ct);
+	if (ecache)
+		exp->event_mask = ecache->expmask;
+
 	nf_ct_expect_related(exp, 0);
 	nf_ct_expect_put(exp);
 
diff --git a/net/netfilter/nf_conntrack_ecache.c b/net/netfilter/nf_conntrack_ecache.c
index 9df159448b89..4c7d1799158d 100644
--- a/net/netfilter/nf_conntrack_ecache.c
+++ b/net/netfilter/nf_conntrack_ecache.c
@@ -245,7 +245,6 @@ void nf_ct_expect_event_report(enum ip_conntrack_expect_events event,
 {
 	struct net *net = nf_ct_exp_net(exp);
 	struct nf_ct_event_notifier *notify;
-	struct nf_conntrack_ecache *e;
 
 	lockdep_nfct_expect_lock_held();
 
@@ -254,11 +253,7 @@ void nf_ct_expect_event_report(enum ip_conntrack_expect_events event,
 	if (!notify)
 		goto out_unlock;
 
-	e = nf_ct_ecache_find(exp->master);
-	if (!e)
-		goto out_unlock;
-
-	if (e->expmask & (1 << event)) {
+	if (exp->event_mask & (1 << event)) {
 		struct nf_exp_event item = {
 			.exp	= exp,
 			.portid	= portid,
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 7ae68d60586a..cd9af3620af5 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -330,6 +330,7 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
 	struct nf_conntrack_helper *helper = NULL;
 	struct nf_conn *ct = exp->master;
 	struct net *net = read_pnet(&ct->ct_net);
+	struct nf_conntrack_ecache *ecache;
 	struct nf_conn_help *help;
 	int len;
 
@@ -342,6 +343,10 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
 	exp->class = class;
 	exp->expectfn = NULL;
 
+	ecache = nf_ct_ecache_find(ct);
+	if (ecache)
+		exp->event_mask = ecache->expmask;
+
 	help = nfct_help(ct);
 	if (help)
 		helper = rcu_dereference(help->helper);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 31cbb1b55b9e..fc3f60099af3 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3524,6 +3524,7 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 {
 	struct net *net = read_pnet(&ct->ct_net);
 	struct nf_conntrack_helper *helper;
+	struct nf_conntrack_ecache *ecache;
 	struct nf_conntrack_expect *exp;
 	struct nf_conn_help *help;
 	u32 class = 0;
@@ -3575,6 +3576,10 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 	exp->mask.src.u3 = mask->src.u3;
 	exp->mask.src.u.all = mask->src.u.all;
 
+	ecache = nf_ct_ecache_find(ct);
+	if (ecache)
+		exp->event_mask = ecache->expmask;
+
 	if (cda[CTA_EXPECT_NAT]) {
 		err = ctnetlink_parse_expect_nat(cda[CTA_EXPECT_NAT],
 						 exp, nf_ct_l3num(ct));
-- 
2.47.3


