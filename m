Return-Path: <netfilter-devel+bounces-12263-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YABEEMjw8Gn9bAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12263-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2026 19:39:20 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B75EC48A17F
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2026 19:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F89300A8CB
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2026 17:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCE0288AD;
	Tue, 28 Apr 2026 17:38:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D2328B71
	for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397922; cv=none; b=osBPsQIifrjSG7p7I4C4EGNg97Oz9SJt8qZ3s775AXWhXIqX4ZjJ1qQty1vOS0oNUx5DCHbKt/FgfzOi9ayJVBW5kY5eyjkeICZ6AYbwv/xjfdeQ+3h8DQEgvjKs35bjzpa1mzR79GjOnIy4rScKa3dT+7GqAHqnnukUIdii0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397922; c=relaxed/simple;
	bh=PKbfCDOi3rxVdzhMcSLz7Lur94PMNKTcygmMMeCbFXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RifeReswJ08t47b7gj7suvKS/keC1uGUA0to4cxLSPNgQ/H1fbexMU1CRZ3zm6BpJpwsEkjfCDVrlai6q35m8GuH/FboQwucdU/uSek9RggAdDaSdbBq4TO/FOgps5BI6/YZW3ep2jhqsLfIHE3++qn4EY3mifC3f6eDhJpYwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C857460420; Tue, 28 Apr 2026 19:38:29 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: xt_CT: fix usersize for v1 and v2 revision
Date: Tue, 28 Apr 2026 19:37:57 +0200
Message-ID: <20260428173803.14100-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B75EC48A17F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-12263-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.560];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

While resurrecting the conntrack-tool test cases I found following bug:
In:
iptables -I OUTPUT -t raw -p 13 -j CT --timeout test-generic
Out:
[0:0] -A OUTPUT -p 13 -j CT --timeout test

Data after first four bytes of the timeout policy name is never
copied to userspace because its treated as kernel-only.

Fixes: ec2318904965 ("xtables: extend matches and targets with .usersize")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/xt_CT.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/xt_CT.c b/net/netfilter/xt_CT.c
index 498f5871c84a..d2aeacf94230 100644
--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -354,7 +354,7 @@ static struct xt_target xt_ct_tg_reg[] __read_mostly = {
 		.family		= NFPROTO_IPV4,
 		.revision	= 1,
 		.targetsize	= sizeof(struct xt_ct_target_info_v1),
-		.usersize	= offsetof(struct xt_ct_target_info, ct),
+		.usersize	= offsetof(struct xt_ct_target_info_v1, ct),
 		.checkentry	= xt_ct_tg_check_v1,
 		.destroy	= xt_ct_tg_destroy_v1,
 		.target		= xt_ct_target_v1,
@@ -366,7 +366,7 @@ static struct xt_target xt_ct_tg_reg[] __read_mostly = {
 		.family		= NFPROTO_IPV4,
 		.revision	= 2,
 		.targetsize	= sizeof(struct xt_ct_target_info_v1),
-		.usersize	= offsetof(struct xt_ct_target_info, ct),
+		.usersize	= offsetof(struct xt_ct_target_info_v1, ct),
 		.checkentry	= xt_ct_tg_check_v2,
 		.destroy	= xt_ct_tg_destroy_v1,
 		.target		= xt_ct_target_v1,
@@ -398,7 +398,7 @@ static struct xt_target xt_ct_tg_reg[] __read_mostly = {
 		.family		= NFPROTO_IPV6,
 		.revision	= 1,
 		.targetsize	= sizeof(struct xt_ct_target_info_v1),
-		.usersize	= offsetof(struct xt_ct_target_info, ct),
+		.usersize	= offsetof(struct xt_ct_target_info_v1, ct),
 		.checkentry	= xt_ct_tg_check_v1,
 		.destroy	= xt_ct_tg_destroy_v1,
 		.target		= xt_ct_target_v1,
@@ -410,7 +410,7 @@ static struct xt_target xt_ct_tg_reg[] __read_mostly = {
 		.family		= NFPROTO_IPV6,
 		.revision	= 2,
 		.targetsize	= sizeof(struct xt_ct_target_info_v1),
-		.usersize	= offsetof(struct xt_ct_target_info, ct),
+		.usersize	= offsetof(struct xt_ct_target_info_v1, ct),
 		.checkentry	= xt_ct_tg_check_v2,
 		.destroy	= xt_ct_tg_destroy_v1,
 		.target		= xt_ct_target_v1,
-- 
2.53.0


