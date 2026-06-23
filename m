Return-Path: <netfilter-devel+bounces-13405-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lJd+F9EdOmri1gcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13405-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 07:46:57 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ED56B43DF
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 07:46:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=Vt0KiXo9;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13405-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13405-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5B29304225A
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 05:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AAD3A9615;
	Tue, 23 Jun 2026 05:46:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE46369D65
	for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2026 05:46:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782193604; cv=none; b=sWop4ruehmPtYFK6iXX4MAIiVZRsK4S+Hi4xkb6wJZeR5i/fXN5CS42itTG/bg0TglwVabYvaNONZSa6qp6ErBGDarafkWvxFk+0tZzoiGUu37LJ08SNUrtPDErjDppi3WQmjDVBWjmItZd02CzATN/4Wl8Lji+vjl9hIEQF654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782193604; c=relaxed/simple;
	bh=thxankseAyvoCnZfzBzW+4sqmtHFw2hSASAWtisq7RE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXbY86lWE+O8qpX6bfDxnHU/TsLsZhzUA67/JE5zeD07ucKmvLLUU/mGM80uNRS33IYW74uuAY5GSqA5tGVjpsJl/Hx9o09nLXtFjp+l7N2NhoW0mvwh126y3hPhF6MNjshoeCK51ejiDjxMsVkMzt1WoUsRDuNdV8tMXPmOj34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Vt0KiXo9; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 18584605A3
	for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2026 07:46:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782193601;
	bh=HzRuzPeA6yK+qaJ23cYFaU6R3YWkc8pLHMEQWYD6Bmo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Vt0KiXo9mOoJ0CO+FUIKxG6z1sbqWQfQ6Bx2Th6zxq7PREEv913na3XnMRZwQ8OVm
	 VEMOdhOawPTj9u5eQ2aWsEGyWXcW4hPfqLXlqhJMolwzzpzHjZH8y2H47ZlWZF5/0D
	 h7zmail57ZyNrZqZcIS8r3qurv2D1Amb6bJ1uBAlU0Zq2P7bPdkbnvIM2if1Cc9sO+
	 NhDjDzSRr6F6E0BzQ0hGYY3eRrWLCtEmW5tRsHmJJMTfbU0oYvQBrlV49rnYAFoCYh
	 78xO6fcjdAo2SsluqzmqPNsjkh9Mtp+Swqy3GcyFi/78kZPOja81MLRsU90kQi0fK+
	 SCJB5BHpjJ/3Q==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf,v1 3/4] netfilter: nf_conntrack_expect: run expectation eviction with no helper
Date: Tue, 23 Jun 2026 07:46:34 +0200
Message-ID: <20260623054635.335065-3-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13405-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1ED56B43DF

Run expectation eviction if no helper is specified to deal with the
nft_ct expectation support.

Cap the maximum expectation limit per master conntrack to
NF_CT_EXPECT_MAX_CNT (255).

Fixes: 857b46027d6f ("netfilter: nft_ct: add ct expectations support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v1: resend to let sashiko pick in with this batch.

 net/netfilter/nf_conntrack_expect.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 9454913e1b33..113bb1cb1683 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -499,6 +499,13 @@ static inline int __nf_ct_expect_check(struct nf_conntrack_expect *expect,
 		if (p->max_expected &&
 		    master_help->expecting[expect->class] >= p->max_expected)
 			evict_oldest_expect(master_help, expect, p);
+	} else {
+		const struct nf_conntrack_expect_policy default_exp_policy = {
+			.max_expected = NF_CT_EXPECT_MAX_CNT,
+		};
+
+		if (master_help->expecting[expect->class] >= default_exp_policy.max_expected)
+			evict_oldest_expect(master_help, expect, &default_exp_policy);
 	}
 
 	cnet = nf_ct_pernet(net);
-- 
2.47.3


