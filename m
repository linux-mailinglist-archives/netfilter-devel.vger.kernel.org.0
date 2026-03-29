Return-Path: <netfilter-devel+bounces-11482-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ6oJ8wryWknvgUAu9opvQ
	(envelope-from <netfilter-devel+bounces-11482-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 29 Mar 2026 15:40:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 49091352463
	for <lists+netfilter-devel@lfdr.de>; Sun, 29 Mar 2026 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 998FF3002B31
	for <lists+netfilter-devel@lfdr.de>; Sun, 29 Mar 2026 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524330FC26;
	Sun, 29 Mar 2026 13:40:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A814F9C0
	for <netfilter-devel@vger.kernel.org>; Sun, 29 Mar 2026 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791626; cv=none; b=HsjFICdiYkccCAv71ZC5R+0e6jkClqd6xXtuV/ExBXXR0GfjoHSQUkQhX2my6tWjI8voq7QRHPEMEWqqKaWvkrcn0efqfZQR5h7nHEnY2UCe7Bb++bpH8cMQzWNk8mM01e4SZ9dzGKEvIFbjVht0jw0iku4j0cWkcCI/bki+mrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791626; c=relaxed/simple;
	bh=meFUZnXTDxDLeeObQlwRDieff/kiqR5Yzytc/25OMAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaJvrXpM7fP0wVTPe6MFq+axxWgz947Eep32l8Yimxe3tVxyuHQdQWG3NBpot7Ilj+28Dqgt5Alcc8ZZJU6WlBM2t2l8NoPLMsO23YcuCSQQdZCkRKqpIKmfFE8feGF4IxGW2GmkurSRQFoq+xh36h+m4UmhDZG6yFm72DLtoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1387360A55; Sun, 29 Mar 2026 15:40:22 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: x_tables: ensure names are nul-terminated
Date: Sun, 29 Mar 2026 15:40:13 +0200
Message-ID: <20260329134016.30245-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11482-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49091352463
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject names that lack a \0 character before feeding them
to functions that expect c-strings.

Fixes tag is the most recent commit that needs this change.

Fixes: c38c4597e4bf ("netfilter: implement xt_cgroup cgroup2 path match")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/xt_cgroup.c  |  6 ++++++
 net/netfilter/xt_physdev.c | 10 ++++++++++
 net/netfilter/xt_rateest.c |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/net/netfilter/xt_cgroup.c b/net/netfilter/xt_cgroup.c
index c437fbd59ec1..43d2ae2be628 100644
--- a/net/netfilter/xt_cgroup.c
+++ b/net/netfilter/xt_cgroup.c
@@ -65,6 +65,9 @@ static int cgroup_mt_check_v1(const struct xt_mtchk_param *par)
 
 	info->priv = NULL;
 	if (info->has_path) {
+		if (strnlen(info->path, sizeof(info->path)) >= sizeof(info->path))
+			return -ENAMETOOLONG;
+
 		cgrp = cgroup_get_from_path(info->path);
 		if (IS_ERR(cgrp)) {
 			pr_info_ratelimited("invalid path, errno=%ld\n",
@@ -102,6 +105,9 @@ static int cgroup_mt_check_v2(const struct xt_mtchk_param *par)
 
 	info->priv = NULL;
 	if (info->has_path) {
+		if (strnlen(info->path, sizeof(info->path)) >= sizeof(info->path))
+			return -ENAMETOOLONG;
+
 		cgrp = cgroup_get_from_path(info->path);
 		if (IS_ERR(cgrp)) {
 			pr_info_ratelimited("invalid path, errno=%ld\n",
diff --git a/net/netfilter/xt_physdev.c b/net/netfilter/xt_physdev.c
index 343e65f377d4..1b522a181a8d 100644
--- a/net/netfilter/xt_physdev.c
+++ b/net/netfilter/xt_physdev.c
@@ -107,6 +107,16 @@ static int physdev_mt_check(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	}
 
+#define X(memb) strnlen(info->memb , sizeof(info->memb)) >= sizeof(info->memb)
+	if (X(physindev))
+		return -ENAMETOOLONG;
+	if (X(physoutdev))
+		return -ENAMETOOLONG;
+	if (X(in_mask))
+		return -ENAMETOOLONG;
+	if (X(out_mask))
+		return -ENAMETOOLONG;
+#undef X
 	if (!brnf_probed) {
 		brnf_probed = true;
 		request_module("br_netfilter");
diff --git a/net/netfilter/xt_rateest.c b/net/netfilter/xt_rateest.c
index 72324bd976af..b1d736c15fcb 100644
--- a/net/netfilter/xt_rateest.c
+++ b/net/netfilter/xt_rateest.c
@@ -91,6 +91,11 @@ static int xt_rateest_mt_checkentry(const struct xt_mtchk_param *par)
 		goto err1;
 	}
 
+	if (strnlen(info->name1, sizeof(info->name1)) >= sizeof(info->name1))
+		return -ENAMETOOLONG;
+	if (strnlen(info->name2, sizeof(info->name2)) >= sizeof(info->name2))
+		return -ENAMETOOLONG;
+
 	ret  = -ENOENT;
 	est1 = xt_rateest_lookup(par->net, info->name1);
 	if (!est1)
-- 
2.53.0


