Return-Path: <netfilter-devel+bounces-4382-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487D599B5DF
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Oct 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7FB1F21054
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Oct 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4822E859;
	Sat, 12 Oct 2024 15:30:11 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA35186A
	for <netfilter-devel@vger.kernel.org>; Sat, 12 Oct 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728747011; cv=none; b=KPNO6kdzIZWhPqymSXawxbW97FabQERquQ/u3VY8LPGzvwraooYqRbERhU5GfPx9oJQ7GMd3EqNfDYOF6WvK0CQ7i/dJ/zLA9Dh/NvHpdqGTdNqCvuXUMbXTMnbQCGubGEws2x7EA0TXyLnX3bIgp58SNZojP2enQChrp6mviQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728747011; c=relaxed/simple;
	bh=sOef+wYERr+SsNmJEpWFJ922N0p6mQ+bpPpQRBLcTfE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=asQC4k3SinZVQeIy6SUx3ylR6D2wyVfQcTWgETMCV9k1Bm/Xo3fLV6ILxJNGutyAmzk7sMRtORAhxB4NSay4EFp3zWVcq7QX/W/10w5gjAKGR8X1QFqPWIP3k4BGc2AoTED4Q4DwLUrMPm3+2eYSa4CVZ+mmc2Zio8Ly9tzLExY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack 2/3] conntrack: improve --mark parser
Date: Sat, 12 Oct 2024 17:29:56 +0200
Message-Id: <20241012152957.30724-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241012152957.30724-1-pablo@netfilter.org>
References: <20241012152957.30724-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance helper function to parse mark and mask (if available), bail out
if input is not correct.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/conntrack.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/src/conntrack.c b/src/conntrack.c
index f3725eefd5de..1da98697a264 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -1232,17 +1232,37 @@ static int parse_value(const char *str, uint32_t *ret, uint64_t max)
 	return 0;
 }
 
-static void
+static int
 parse_u32_mask(const char *arg, struct u32_mask *m)
 {
-	char *end;
+	uint64_t val, mask;
+	char *endptr;
+
+	val = strtoul(arg, &endptr, 0);
+	if (endptr == arg ||
+	    (*endptr != '\0' && *endptr != '/') ||
+	    (val == ULONG_MAX && errno == ERANGE) ||
+	    (val == 0 && errno == ERANGE) ||
+	    val > UINT32_MAX)
+		return -1;
 
-	m->value = (uint32_t) strtoul(arg, &end, 0);
+	m->value = val;
 
-	if (*end == '/')
-		m->mask = (uint32_t) strtoul(end+1, NULL, 0);
-	else
+	if (*endptr == '/') {
+		mask = (uint32_t) strtoul(endptr + 1, &endptr, 0);
+		if (endptr == arg ||
+		    *endptr != '\0' ||
+		    (val == ULONG_MAX && errno == ERANGE) ||
+		    (val == 0 && errno == ERANGE) ||
+		    val > UINT32_MAX)
+			return -1;
+
+		m->mask = mask;
+	} else {
 		m->mask = ~0;
+	}
+
+	return 0;
 }
 
 static int
@@ -3114,7 +3134,9 @@ static void do_parse(struct ct_cmd *ct_cmd, int argc, char *argv[])
 			break;
 		case 'm':
 			options |= opt2type[c];
-			parse_u32_mask(optarg, &tmpl->mark);
+			if (parse_u32_mask(optarg, &tmpl->mark) < 0)
+				exit_error(OTHER_PROBLEM, "unexpected value '%s' with -%c option", optarg, c);
+
 			tmpl->filter_mark_kernel.val = tmpl->mark.value;
 			tmpl->filter_mark_kernel.mask = tmpl->mark.mask;
 			tmpl->filter_mark_kernel_set = true;
-- 
2.30.2


