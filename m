Return-Path: <netfilter-devel+bounces-7361-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD3AC6355
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 May 2025 09:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779B21BA2962
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 May 2025 07:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491151FF1D1;
	Wed, 28 May 2025 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzbR2seu"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B719005E
	for <netfilter-devel@vger.kernel.org>; Wed, 28 May 2025 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418650; cv=none; b=Q+qpLkGHokezOUeTeZyhXBOYaeWc88QVIZtLWKOyCfc3M+Xk6cFVqKii0BjSTqWQw7DB5WXBEsTlIa2EPs8VwxgGzG6/ZTH3sc/jWruWIp3Qyd9BDNVeudTX5PEcX3qhfmdFTdlnHcLKT13qMXpHukUFQltj5FHnY2xHZW+lORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418650; c=relaxed/simple;
	bh=9Bd6NS7xjIuqgrQe3tBzD8eszTn9mloiNreDQKdpUrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ux+iUyWxnwegE51AdPzmZ2ISy+F+Y+AvmHhoLH1+AcenbaSwTi7kCumEjdQluhoGWNlN5rRHqFQX3ZwBNRwjGJLS2equWpgdO8rmBBOOj3PdmyJh471gNGysAk6LZz06eqxXPLfqLFKr28kEvMJQwfXN6rm62zdMF/BQd9GF5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzbR2seu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73712952e1cso3006629b3a.1
        for <netfilter-devel@vger.kernel.org>; Wed, 28 May 2025 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748418646; x=1749023446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWV6HVRm0m/HsD72wqBm0OrtNI0dw1oUGgqRFTohOJc=;
        b=EzbR2seuKRbSEfmFMtUAcs+NtAikZ5PUBaPb7Y9EL5NaGRfokKbww8puo2AvMNUouP
         bsFqSUfgV8oaM+MKg1y3wWYQ51MNJqnZkc5/9DyhEzmvwKZCAzp6oqQTtiNK9ba/gG0O
         LBtzKctlYt2kgVHjNbrUYDfZHPc8yvY0WT7P79d5O5FSDdYiw9Zalw/oSSOxEWKqmn6+
         6IvjUOos1RI0caiuduqjrvbh0tTLyF/P5RI8lZR7IdVkuqM08iaY+cZFYJKwNrTg7LRc
         nHk1Lh3wV2Dv+kD6Wg2/4XgD0IKZcY3jqmn+VuPw/MsSBXtt+4LEdoOMGria+C6g0qUd
         cW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748418646; x=1749023446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWV6HVRm0m/HsD72wqBm0OrtNI0dw1oUGgqRFTohOJc=;
        b=d9jQZBhEFiUA05q5fO3wvRd/FV92MM236BSonkOMsd0YYhhcJnusxVZzgWTzV6VnaE
         bRNRSj1EpQTCXlL4wGPY4Fr+mPjZdo3bfnVVKtx0hOOP0Kl3/FbAYlVv7iX9APyUuMRy
         zbFYSb0jGZsc1VRRWPkJe4qDzVjJ++DZBGNBKLVSkxLDxUQjzQBuA4F2bB+3LAMcEdx3
         BnghRLuY8dZLd8X+R1cu6bwy4MDbrWgXxWG50rI4UApD82B0lS1Tt1aQRDoNOozKq3di
         73lTsDR/QNliCQb20BnHZSl03ay0bhiduoNcpLEaL6jJym6gJ08qa0ZGIVcufaPrqDMQ
         XuPA==
X-Gm-Message-State: AOJu0Yw15jJ2sp/9y4jQnzZhfmjnQFJD9XtlaPY/mMe9hVmkE7Q/Rh90
	Eui8Jw3/bUvjYcAs5qb+c48wYxnRE8TjOTT2cmAJC13rmdXZ3na3P/DMO/KulFaG
X-Gm-Gg: ASbGncuIdARElEFiT45fjLN57NA71gIxm2In2Mbx48tLTPqBxQSsLoP5lvbyXiJWa6N
	jVZs32viYLcsD6esAcgropK/nEbd2444wMNJz4jzCHqDZGu4zO3kT36HiTYm32iJZmlzASJ3ahJ
	KqXA8bB7NJYijNJpYRhfx4ZVNaR0d1Rv6Br2DL+JA2BDYuzeYaLgDzUIdfSqXbaljtI0ZqXzeLF
	dtst8Ix0tpiBau2vaNd0GUONmm6V0MjVvN4Si7hwTdLYjm+pWtKV4OYun4SVjfkGSA8YZnBZAcI
	lDMaW5NB+lsK5L3dxzJPNMkZERIUTMp/UiTzm7kQLbTlRJDu4t9oVF81R/c6+LUCWo8sa5ohn3u
	bmlKQL972Uv3962fdIwjVg1ezbQ==
X-Google-Smtp-Source: AGHT+IHOY4uKnaLFCgrxWu3BtxB2vj4T186rvujc5XUaeJIuwhg/4AVyPxLUOBOsD1x1RZT0vTkhUg==
X-Received: by 2002:a05:6a21:4a4c:b0:1f3:2e85:c052 with SMTP id adf61e73a8af0-2188c3b0d71mr27690152637.35.1748418645314;
        Wed, 28 May 2025 00:50:45 -0700 (PDT)
Received: from localhost.localdomain ([173.211.127.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2d99e1d328sm614305a12.24.2025.05.28.00.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 00:50:44 -0700 (PDT)
From: Elie Khalil <eliekh05@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: eliekh05 <eliekh05@gmail.com>
Subject: [PATCH] f
Date: Wed, 28 May 2025 10:50:35 +0300
Message-ID: <20250528075035.66393-1-eliekh05@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: eliekh05 <eliekh05@gmail.com>

---
 include/uapi/linux/netfilter/xt_CONNMARK.h    |  40 +-
 include/uapi/linux/netfilter/xt_DSCP.h        |  27 +-
 include/uapi/linux/netfilter/xt_MARK.h        |  17 +-
 include/uapi/linux/netfilter/xt_RATEEST.h     |  38 +-
 include/uapi/linux/netfilter/xt_TCPMSS.h      |  13 +-
 include/uapi/linux/netfilter_ipv4/ipt_ECN.h   |  40 +-
 include/uapi/linux/netfilter_ipv4/ipt_TTL.h   |  14 +-
 include/uapi/linux/netfilter_ipv6/ip6t_HL.h   |  14 +-
 net/netfilter/xt_DSCP.c                       | 149 +++----
 net/netfilter/xt_HL.c                         | 164 +++-----
 net/netfilter/xt_RATEEST.c                    | 303 +++++---------
 net/netfilter/xt_TCPMSS.c                     | 378 ++++--------------
 ...Z6.0+pooncelock+poonceLock+pombonce.litmus |  12 +-
 13 files changed, 402 insertions(+), 807 deletions(-)

diff --git a/include/uapi/linux/netfilter/xt_CONNMARK.h b/include/uapi/linux/netfilter/xt_CONNMARK.h
index 36cc956ead1a..41b578ccd03b 100644
--- a/include/uapi/linux/netfilter/xt_CONNMARK.h
+++ b/include/uapi/linux/netfilter/xt_CONNMARK.h
@@ -1,7 +1,37 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _XT_CONNMARK_H_target
-#define _XT_CONNMARK_H_target
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* Copyright (C) 2002,2004 MARA Systems AB <https://www.marasystems.com>
+ * by Henrik Nordstrom <hno@marasystems.com>
+ */
 
-#include <linux/netfilter/xt_connmark.h>
+#ifndef _XT_CONNMARK_H
+#define _XT_CONNMARK_H
 
-#endif /*_XT_CONNMARK_H_target*/
+#include <linux/types.h>
+
+enum {
+	XT_CONNMARK_SET = 0,
+	XT_CONNMARK_SAVE,
+	XT_CONNMARK_RESTORE
+};
+
+enum {
+	D_SHIFT_LEFT = 0,
+	D_SHIFT_RIGHT,
+};
+
+struct xt_connmark_tginfo1 {
+	__u32 ctmark, ctmask, nfmask;
+	__u8 mode;
+};
+
+struct xt_connmark_tginfo2 {
+	__u32 ctmark, ctmask, nfmask;
+	__u8 shift_dir, shift_bits, mode;
+};
+
+struct xt_connmark_mtinfo1 {
+	__u32 mark, mask;
+	__u8 invert;
+};
+
+#endif /*_XT_CONNMARK_H*/
diff --git a/include/uapi/linux/netfilter/xt_DSCP.h b/include/uapi/linux/netfilter/xt_DSCP.h
index 223d635e8b6f..7594e4df8587 100644
--- a/include/uapi/linux/netfilter/xt_DSCP.h
+++ b/include/uapi/linux/netfilter/xt_DSCP.h
@@ -1,27 +1,32 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* x_tables module for setting the IPv4/IPv6 DSCP field
+/* x_tables module for matching the IPv4/IPv6 DSCP field
  *
  * (C) 2002 Harald Welte <laforge@gnumonks.org>
- * based on ipt_FTOS.c (C) 2000 by Matthew G. Marsh <mgm@paktronix.com>
  * This software is distributed under GNU GPL v2, 1991
  *
  * See RFC2474 for a description of the DSCP field within the IP Header.
  *
- * xt_DSCP.h,v 1.7 2002/03/14 12:03:13 laforge Exp
+ * xt_dscp.h,v 1.3 2002/08/05 19:00:21 laforge Exp
 */
-#ifndef _XT_DSCP_TARGET_H
-#define _XT_DSCP_TARGET_H
-#include <linux/netfilter/xt_dscp.h>
+#ifndef _XT_DSCP_H
+#define _XT_DSCP_H
+
 #include <linux/types.h>
 
-/* target info */
-struct xt_DSCP_info {
+#define XT_DSCP_MASK	0xfc	/* 11111100 */
+#define XT_DSCP_SHIFT	2
+#define XT_DSCP_MAX	0x3f	/* 00111111 */
+
+/* match info */
+struct xt_dscp_info {
 	__u8 dscp;
+	__u8 invert;
 };
 
-struct xt_tos_target_info {
-	__u8 tos_value;
+struct xt_tos_match_info {
 	__u8 tos_mask;
+	__u8 tos_value;
+	__u8 invert;
 };
 
-#endif /* _XT_DSCP_TARGET_H */
+#endif /* _XT_DSCP_H */
diff --git a/include/uapi/linux/netfilter/xt_MARK.h b/include/uapi/linux/netfilter/xt_MARK.h
index f1fe2b4be933..9d0526ced8f0 100644
--- a/include/uapi/linux/netfilter/xt_MARK.h
+++ b/include/uapi/linux/netfilter/xt_MARK.h
@@ -1,7 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _XT_MARK_H_target
-#define _XT_MARK_H_target
+#ifndef _XT_MARK_H
+#define _XT_MARK_H
 
-#include <linux/netfilter/xt_mark.h>
+#include <linux/types.h>
 
-#endif /*_XT_MARK_H_target */
+struct xt_mark_tginfo2 {
+	__u32 mark, mask;
+};
+
+struct xt_mark_mtinfo1 {
+	__u32 mark, mask;
+	__u8 invert;
+};
+
+#endif /*_XT_MARK_H*/
diff --git a/include/uapi/linux/netfilter/xt_RATEEST.h b/include/uapi/linux/netfilter/xt_RATEEST.h
index 2b87a71e6266..52a37bdc1837 100644
--- a/include/uapi/linux/netfilter/xt_RATEEST.h
+++ b/include/uapi/linux/netfilter/xt_RATEEST.h
@@ -1,17 +1,39 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _XT_RATEEST_TARGET_H
-#define _XT_RATEEST_TARGET_H
+#ifndef _XT_RATEEST_MATCH_H
+#define _XT_RATEEST_MATCH_H
 
 #include <linux/types.h>
 #include <linux/if.h>
 
-struct xt_rateest_target_info {
-	char			name[IFNAMSIZ];
-	__s8			interval;
-	__u8		ewma_log;
+enum xt_rateest_match_flags {
+	XT_RATEEST_MATCH_INVERT	= 1<<0,
+	XT_RATEEST_MATCH_ABS	= 1<<1,
+	XT_RATEEST_MATCH_REL	= 1<<2,
+	XT_RATEEST_MATCH_DELTA	= 1<<3,
+	XT_RATEEST_MATCH_BPS	= 1<<4,
+	XT_RATEEST_MATCH_PPS	= 1<<5,
+};
+
+enum xt_rateest_match_mode {
+	XT_RATEEST_MATCH_NONE,
+	XT_RATEEST_MATCH_EQ,
+	XT_RATEEST_MATCH_LT,
+	XT_RATEEST_MATCH_GT,
+};
+
+struct xt_rateest_match_info {
+	char			name1[IFNAMSIZ];
+	char			name2[IFNAMSIZ];
+	__u16		flags;
+	__u16		mode;
+	__u32		bps1;
+	__u32		pps1;
+	__u32		bps2;
+	__u32		pps2;
 
 	/* Used internally by the kernel */
-	struct xt_rateest	*est __attribute__((aligned(8)));
+	struct xt_rateest	*est1 __attribute__((aligned(8)));
+	struct xt_rateest	*est2 __attribute__((aligned(8)));
 };
 
-#endif /* _XT_RATEEST_TARGET_H */
+#endif /* _XT_RATEEST_MATCH_H */
diff --git a/include/uapi/linux/netfilter/xt_TCPMSS.h b/include/uapi/linux/netfilter/xt_TCPMSS.h
index 65ea6c9dab4b..2268f58b4dec 100644
--- a/include/uapi/linux/netfilter/xt_TCPMSS.h
+++ b/include/uapi/linux/netfilter/xt_TCPMSS.h
@@ -1,13 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _XT_TCPMSS_H
-#define _XT_TCPMSS_H
+#ifndef _XT_TCPMSS_MATCH_H
+#define _XT_TCPMSS_MATCH_H
 
 #include <linux/types.h>
 
-struct xt_tcpmss_info {
-	__u16 mss;
+struct xt_tcpmss_match_info {
+    __u16 mss_min, mss_max;
+    __u8 invert;
 };
 
-#define XT_TCPMSS_CLAMP_PMTU 0xffff
-
-#endif /* _XT_TCPMSS_H */
+#endif /*_XT_TCPMSS_MATCH_H*/
diff --git a/include/uapi/linux/netfilter_ipv4/ipt_ECN.h b/include/uapi/linux/netfilter_ipv4/ipt_ECN.h
index e3630fd045b8..8121bec47026 100644
--- a/include/uapi/linux/netfilter_ipv4/ipt_ECN.h
+++ b/include/uapi/linux/netfilter_ipv4/ipt_ECN.h
@@ -1,34 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* Header file for iptables ipt_ECN target
- *
- * (C) 2002 by Harald Welte <laforge@gnumonks.org>
- *
- * This software is distributed under GNU GPL v2, 1991
- * 
- * ipt_ECN.h,v 1.3 2002/05/29 12:17:40 laforge Exp
-*/
-#ifndef _IPT_ECN_TARGET_H
-#define _IPT_ECN_TARGET_H
+#ifndef _IPT_ECN_H
+#define _IPT_ECN_H
 
-#include <linux/types.h>
-#include <linux/netfilter/xt_DSCP.h>
+#include <linux/netfilter/xt_ecn.h>
+#define ipt_ecn_info xt_ecn_info
 
-#define IPT_ECN_IP_MASK	(~XT_DSCP_MASK)
-
-#define IPT_ECN_OP_SET_IP	0x01	/* set ECN bits of IPv4 header */
-#define IPT_ECN_OP_SET_ECE	0x10	/* set ECE bit of TCP header */
-#define IPT_ECN_OP_SET_CWR	0x20	/* set CWR bit of TCP header */
-
-#define IPT_ECN_OP_MASK		0xce
-
-struct ipt_ECN_info {
-	__u8 operation;	/* bitset of operations */
-	__u8 ip_ect;	/* ECT codepoint of IPv4 header, pre-shifted */
-	union {
-		struct {
-			__u8 ece:1, cwr:1; /* TCP ECT bits */
-		} tcp;
-	} proto;
+enum {
+	IPT_ECN_IP_MASK       = XT_ECN_IP_MASK,
+	IPT_ECN_OP_MATCH_IP   = XT_ECN_OP_MATCH_IP,
+	IPT_ECN_OP_MATCH_ECE  = XT_ECN_OP_MATCH_ECE,
+	IPT_ECN_OP_MATCH_CWR  = XT_ECN_OP_MATCH_CWR,
+	IPT_ECN_OP_MATCH_MASK = XT_ECN_OP_MATCH_MASK,
 };
 
-#endif /* _IPT_ECN_TARGET_H */
+#endif /* IPT_ECN_H */
diff --git a/include/uapi/linux/netfilter_ipv4/ipt_TTL.h b/include/uapi/linux/netfilter_ipv4/ipt_TTL.h
index 57d2fc67a943..ad0226a8629b 100644
--- a/include/uapi/linux/netfilter_ipv4/ipt_TTL.h
+++ b/include/uapi/linux/netfilter_ipv4/ipt_TTL.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* TTL modification module for IP tables
- * (C) 2000 by Harald Welte <laforge@netfilter.org> */
+/* IP tables module for matching the value of the TTL
+ * (C) 2000 by Harald Welte <laforge@gnumonks.org> */
 
 #ifndef _IPT_TTL_H
 #define _IPT_TTL_H
@@ -8,14 +8,14 @@
 #include <linux/types.h>
 
 enum {
-	IPT_TTL_SET = 0,
-	IPT_TTL_INC,
-	IPT_TTL_DEC
+	IPT_TTL_EQ = 0,		/* equals */
+	IPT_TTL_NE,		/* not equals */
+	IPT_TTL_LT,		/* less than */
+	IPT_TTL_GT,		/* greater than */
 };
 
-#define IPT_TTL_MAXMODE	IPT_TTL_DEC
 
-struct ipt_TTL_info {
+struct ipt_ttl_info {
 	__u8	mode;
 	__u8	ttl;
 };
diff --git a/include/uapi/linux/netfilter_ipv6/ip6t_HL.h b/include/uapi/linux/netfilter_ipv6/ip6t_HL.h
index eaed56a287b4..6b62f9418eb2 100644
--- a/include/uapi/linux/netfilter_ipv6/ip6t_HL.h
+++ b/include/uapi/linux/netfilter_ipv6/ip6t_HL.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/* Hop Limit modification module for ip6tables
+/* ip6tables module for matching the Hop Limit value
  * Maciej Soltysiak <solt@dns.toxicfilms.tv>
- * Based on HW's TTL module */
+ * Based on HW's ttl module */
 
 #ifndef _IP6T_HL_H
 #define _IP6T_HL_H
@@ -9,14 +9,14 @@
 #include <linux/types.h>
 
 enum {
-	IP6T_HL_SET = 0,
-	IP6T_HL_INC,
-	IP6T_HL_DEC
+	IP6T_HL_EQ = 0,		/* equals */
+	IP6T_HL_NE,		/* not equals */
+	IP6T_HL_LT,		/* less than */
+	IP6T_HL_GT,		/* greater than */
 };
 
-#define IP6T_HL_MAXMODE	IP6T_HL_DEC
 
-struct ip6t_HL_info {
+struct ip6t_hl_info {
 	__u8	mode;
 	__u8	hop_limit;
 };
diff --git a/net/netfilter/xt_DSCP.c b/net/netfilter/xt_DSCP.c
index cfa44515ab72..fb0169a8f9bb 100644
--- a/net/netfilter/xt_DSCP.c
+++ b/net/netfilter/xt_DSCP.c
@@ -1,11 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* x_tables module for setting the IPv4/IPv6 DSCP field, Version 1.8
+/* IP tables module for matching the value of the IPv4/IPv6 DSCP field
  *
  * (C) 2002 by Harald Welte <laforge@netfilter.org>
- * based on ipt_FTOS.c (C) 2000 by Matthew G. Marsh <mgm@paktronix.com>
- *
- * See RFC2474 for a description of the DSCP field within the IP Header.
-*/
+ */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/skbuff.h>
@@ -14,148 +11,100 @@
 #include <net/dsfield.h>
 
 #include <linux/netfilter/x_tables.h>
-#include <linux/netfilter/xt_DSCP.h>
+#include <linux/netfilter/xt_dscp.h>
 
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
-MODULE_DESCRIPTION("Xtables: DSCP/TOS field modification");
+MODULE_DESCRIPTION("Xtables: DSCP/TOS field match");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("ipt_DSCP");
-MODULE_ALIAS("ip6t_DSCP");
-MODULE_ALIAS("ipt_TOS");
-MODULE_ALIAS("ip6t_TOS");
-
-#define XT_DSCP_ECN_MASK	3u
+MODULE_ALIAS("ipt_dscp");
+MODULE_ALIAS("ip6t_dscp");
+MODULE_ALIAS("ipt_tos");
+MODULE_ALIAS("ip6t_tos");
 
-static unsigned int
-dscp_tg(struct sk_buff *skb, const struct xt_action_param *par)
+static bool
+dscp_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
-	const struct xt_DSCP_info *dinfo = par->targinfo;
+	const struct xt_dscp_info *info = par->matchinfo;
 	u_int8_t dscp = ipv4_get_dsfield(ip_hdr(skb)) >> XT_DSCP_SHIFT;
 
-	if (dscp != dinfo->dscp) {
-		if (skb_ensure_writable(skb, sizeof(struct iphdr)))
-			return NF_DROP;
-
-		ipv4_change_dsfield(ip_hdr(skb), XT_DSCP_ECN_MASK,
-				    dinfo->dscp << XT_DSCP_SHIFT);
-
-	}
-	return XT_CONTINUE;
+	return (dscp == info->dscp) ^ !!info->invert;
 }
 
-static unsigned int
-dscp_tg6(struct sk_buff *skb, const struct xt_action_param *par)
+static bool
+dscp_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 {
-	const struct xt_DSCP_info *dinfo = par->targinfo;
+	const struct xt_dscp_info *info = par->matchinfo;
 	u_int8_t dscp = ipv6_get_dsfield(ipv6_hdr(skb)) >> XT_DSCP_SHIFT;
 
-	if (dscp != dinfo->dscp) {
-		if (skb_ensure_writable(skb, sizeof(struct ipv6hdr)))
-			return NF_DROP;
-
-		ipv6_change_dsfield(ipv6_hdr(skb), XT_DSCP_ECN_MASK,
-				    dinfo->dscp << XT_DSCP_SHIFT);
-	}
-	return XT_CONTINUE;
+	return (dscp == info->dscp) ^ !!info->invert;
 }
 
-static int dscp_tg_check(const struct xt_tgchk_param *par)
+static int dscp_mt_check(const struct xt_mtchk_param *par)
 {
-	const struct xt_DSCP_info *info = par->targinfo;
+	const struct xt_dscp_info *info = par->matchinfo;
 
 	if (info->dscp > XT_DSCP_MAX)
 		return -EDOM;
-	return 0;
-}
 
-static unsigned int
-tos_tg(struct sk_buff *skb, const struct xt_action_param *par)
-{
-	const struct xt_tos_target_info *info = par->targinfo;
-	struct iphdr *iph = ip_hdr(skb);
-	u_int8_t orig, nv;
-
-	orig = ipv4_get_dsfield(iph);
-	nv   = (orig & ~info->tos_mask) ^ info->tos_value;
-
-	if (orig != nv) {
-		if (skb_ensure_writable(skb, sizeof(struct iphdr)))
-			return NF_DROP;
-		iph = ip_hdr(skb);
-		ipv4_change_dsfield(iph, 0, nv);
-	}
-
-	return XT_CONTINUE;
+	return 0;
 }
 
-static unsigned int
-tos_tg6(struct sk_buff *skb, const struct xt_action_param *par)
+static bool tos_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
-	const struct xt_tos_target_info *info = par->targinfo;
-	struct ipv6hdr *iph = ipv6_hdr(skb);
-	u_int8_t orig, nv;
-
-	orig = ipv6_get_dsfield(iph);
-	nv   = (orig & ~info->tos_mask) ^ info->tos_value;
-
-	if (orig != nv) {
-		if (skb_ensure_writable(skb, sizeof(struct iphdr)))
-			return NF_DROP;
-		iph = ipv6_hdr(skb);
-		ipv6_change_dsfield(iph, 0, nv);
-	}
-
-	return XT_CONTINUE;
+	const struct xt_tos_match_info *info = par->matchinfo;
+
+	if (xt_family(par) == NFPROTO_IPV4)
+		return ((ip_hdr(skb)->tos & info->tos_mask) ==
+		       info->tos_value) ^ !!info->invert;
+	else
+		return ((ipv6_get_dsfield(ipv6_hdr(skb)) & info->tos_mask) ==
+		       info->tos_value) ^ !!info->invert;
 }
 
-static struct xt_target dscp_tg_reg[] __read_mostly = {
+static struct xt_match dscp_mt_reg[] __read_mostly = {
 	{
-		.name		= "DSCP",
+		.name		= "dscp",
 		.family		= NFPROTO_IPV4,
-		.checkentry	= dscp_tg_check,
-		.target		= dscp_tg,
-		.targetsize	= sizeof(struct xt_DSCP_info),
-		.table		= "mangle",
+		.checkentry	= dscp_mt_check,
+		.match		= dscp_mt,
+		.matchsize	= sizeof(struct xt_dscp_info),
 		.me		= THIS_MODULE,
 	},
 	{
-		.name		= "DSCP",
+		.name		= "dscp",
 		.family		= NFPROTO_IPV6,
-		.checkentry	= dscp_tg_check,
-		.target		= dscp_tg6,
-		.targetsize	= sizeof(struct xt_DSCP_info),
-		.table		= "mangle",
+		.checkentry	= dscp_mt_check,
+		.match		= dscp_mt6,
+		.matchsize	= sizeof(struct xt_dscp_info),
 		.me		= THIS_MODULE,
 	},
 	{
-		.name		= "TOS",
+		.name		= "tos",
 		.revision	= 1,
 		.family		= NFPROTO_IPV4,
-		.table		= "mangle",
-		.target		= tos_tg,
-		.targetsize	= sizeof(struct xt_tos_target_info),
+		.match		= tos_mt,
+		.matchsize	= sizeof(struct xt_tos_match_info),
 		.me		= THIS_MODULE,
 	},
 	{
-		.name		= "TOS",
+		.name		= "tos",
 		.revision	= 1,
 		.family		= NFPROTO_IPV6,
-		.table		= "mangle",
-		.target		= tos_tg6,
-		.targetsize	= sizeof(struct xt_tos_target_info),
+		.match		= tos_mt,
+		.matchsize	= sizeof(struct xt_tos_match_info),
 		.me		= THIS_MODULE,
 	},
 };
 
-static int __init dscp_tg_init(void)
+static int __init dscp_mt_init(void)
 {
-	return xt_register_targets(dscp_tg_reg, ARRAY_SIZE(dscp_tg_reg));
+	return xt_register_matches(dscp_mt_reg, ARRAY_SIZE(dscp_mt_reg));
 }
 
-static void __exit dscp_tg_exit(void)
+static void __exit dscp_mt_exit(void)
 {
-	xt_unregister_targets(dscp_tg_reg, ARRAY_SIZE(dscp_tg_reg));
+	xt_unregister_matches(dscp_mt_reg, ARRAY_SIZE(dscp_mt_reg));
 }
 
-module_init(dscp_tg_init);
-module_exit(dscp_tg_exit);
+module_init(dscp_mt_init);
+module_exit(dscp_mt_exit);
diff --git a/net/netfilter/xt_HL.c b/net/netfilter/xt_HL.c
index 7873b834c300..c1a70f8f0441 100644
--- a/net/netfilter/xt_HL.c
+++ b/net/netfilter/xt_HL.c
@@ -1,159 +1,93 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * TTL modification target for IP tables
- * (C) 2000,2005 by Harald Welte <laforge@netfilter.org>
+ * IP tables module for matching the value of the TTL
+ * (C) 2000,2001 by Harald Welte <laforge@netfilter.org>
  *
- * Hop Limit modification target for ip6tables
- * Maciej Soltysiak <solt@dns.toxicfilms.tv>
+ * Hop Limit matching module
+ * (C) 2001-2002 Maciej Soltysiak <solt@dns.toxicfilms.tv>
  */
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <linux/module.h>
-#include <linux/skbuff.h>
+
 #include <linux/ip.h>
 #include <linux/ipv6.h>
-#include <net/checksum.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
 
 #include <linux/netfilter/x_tables.h>
-#include <linux/netfilter_ipv4/ipt_TTL.h>
-#include <linux/netfilter_ipv6/ip6t_HL.h>
+#include <linux/netfilter_ipv4/ipt_ttl.h>
+#include <linux/netfilter_ipv6/ip6t_hl.h>
 
-MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
 MODULE_AUTHOR("Maciej Soltysiak <solt@dns.toxicfilms.tv>");
-MODULE_DESCRIPTION("Xtables: Hoplimit/TTL Limit field modification target");
+MODULE_DESCRIPTION("Xtables: Hoplimit/TTL field match");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("ipt_ttl");
+MODULE_ALIAS("ip6t_hl");
 
-static unsigned int
-ttl_tg(struct sk_buff *skb, const struct xt_action_param *par)
+static bool ttl_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
-	struct iphdr *iph;
-	const struct ipt_TTL_info *info = par->targinfo;
-	int new_ttl;
-
-	if (skb_ensure_writable(skb, sizeof(*iph)))
-		return NF_DROP;
-
-	iph = ip_hdr(skb);
+	const struct ipt_ttl_info *info = par->matchinfo;
+	const u8 ttl = ip_hdr(skb)->ttl;
 
 	switch (info->mode) {
-	case IPT_TTL_SET:
-		new_ttl = info->ttl;
-		break;
-	case IPT_TTL_INC:
-		new_ttl = iph->ttl + info->ttl;
-		if (new_ttl > 255)
-			new_ttl = 255;
-		break;
-	case IPT_TTL_DEC:
-		new_ttl = iph->ttl - info->ttl;
-		if (new_ttl < 0)
-			new_ttl = 0;
-		break;
-	default:
-		new_ttl = iph->ttl;
-		break;
+	case IPT_TTL_EQ:
+		return ttl == info->ttl;
+	case IPT_TTL_NE:
+		return ttl != info->ttl;
+	case IPT_TTL_LT:
+		return ttl < info->ttl;
+	case IPT_TTL_GT:
+		return ttl > info->ttl;
 	}
 
-	if (new_ttl != iph->ttl) {
-		csum_replace2(&iph->check, htons(iph->ttl << 8),
-					   htons(new_ttl << 8));
-		iph->ttl = new_ttl;
-	}
-
-	return XT_CONTINUE;
+	return false;
 }
 
-static unsigned int
-hl_tg6(struct sk_buff *skb, const struct xt_action_param *par)
+static bool hl_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 {
-	struct ipv6hdr *ip6h;
-	const struct ip6t_HL_info *info = par->targinfo;
-	int new_hl;
-
-	if (skb_ensure_writable(skb, sizeof(*ip6h)))
-		return NF_DROP;
-
-	ip6h = ipv6_hdr(skb);
+	const struct ip6t_hl_info *info = par->matchinfo;
+	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 
 	switch (info->mode) {
-	case IP6T_HL_SET:
-		new_hl = info->hop_limit;
-		break;
-	case IP6T_HL_INC:
-		new_hl = ip6h->hop_limit + info->hop_limit;
-		if (new_hl > 255)
-			new_hl = 255;
-		break;
-	case IP6T_HL_DEC:
-		new_hl = ip6h->hop_limit - info->hop_limit;
-		if (new_hl < 0)
-			new_hl = 0;
-		break;
-	default:
-		new_hl = ip6h->hop_limit;
-		break;
+	case IP6T_HL_EQ:
+		return ip6h->hop_limit == info->hop_limit;
+	case IP6T_HL_NE:
+		return ip6h->hop_limit != info->hop_limit;
+	case IP6T_HL_LT:
+		return ip6h->hop_limit < info->hop_limit;
+	case IP6T_HL_GT:
+		return ip6h->hop_limit > info->hop_limit;
 	}
 
-	ip6h->hop_limit = new_hl;
-
-	return XT_CONTINUE;
-}
-
-static int ttl_tg_check(const struct xt_tgchk_param *par)
-{
-	const struct ipt_TTL_info *info = par->targinfo;
-
-	if (info->mode > IPT_TTL_MAXMODE)
-		return -EINVAL;
-	if (info->mode != IPT_TTL_SET && info->ttl == 0)
-		return -EINVAL;
-	return 0;
-}
-
-static int hl_tg6_check(const struct xt_tgchk_param *par)
-{
-	const struct ip6t_HL_info *info = par->targinfo;
-
-	if (info->mode > IP6T_HL_MAXMODE)
-		return -EINVAL;
-	if (info->mode != IP6T_HL_SET && info->hop_limit == 0)
-		return -EINVAL;
-	return 0;
+	return false;
 }
 
-static struct xt_target hl_tg_reg[] __read_mostly = {
+static struct xt_match hl_mt_reg[] __read_mostly = {
 	{
-		.name       = "TTL",
+		.name       = "ttl",
 		.revision   = 0,
 		.family     = NFPROTO_IPV4,
-		.target     = ttl_tg,
-		.targetsize = sizeof(struct ipt_TTL_info),
-		.table      = "mangle",
-		.checkentry = ttl_tg_check,
+		.match      = ttl_mt,
+		.matchsize  = sizeof(struct ipt_ttl_info),
 		.me         = THIS_MODULE,
 	},
 	{
-		.name       = "HL",
+		.name       = "hl",
 		.revision   = 0,
 		.family     = NFPROTO_IPV6,
-		.target     = hl_tg6,
-		.targetsize = sizeof(struct ip6t_HL_info),
-		.table      = "mangle",
-		.checkentry = hl_tg6_check,
+		.match      = hl_mt6,
+		.matchsize  = sizeof(struct ip6t_hl_info),
 		.me         = THIS_MODULE,
 	},
 };
 
-static int __init hl_tg_init(void)
+static int __init hl_mt_init(void)
 {
-	return xt_register_targets(hl_tg_reg, ARRAY_SIZE(hl_tg_reg));
+	return xt_register_matches(hl_mt_reg, ARRAY_SIZE(hl_mt_reg));
 }
 
-static void __exit hl_tg_exit(void)
+static void __exit hl_mt_exit(void)
 {
-	xt_unregister_targets(hl_tg_reg, ARRAY_SIZE(hl_tg_reg));
+	xt_unregister_matches(hl_mt_reg, ARRAY_SIZE(hl_mt_reg));
 }
 
-module_init(hl_tg_init);
-module_exit(hl_tg_exit);
-MODULE_ALIAS("ipt_TTL");
-MODULE_ALIAS("ip6t_HL");
+module_init(hl_mt_init);
+module_exit(hl_mt_exit);
diff --git a/net/netfilter/xt_RATEEST.c b/net/netfilter/xt_RATEEST.c
index 4f49cfc27831..72324bd976af 100644
--- a/net/netfilter/xt_RATEEST.c
+++ b/net/netfilter/xt_RATEEST.c
@@ -5,244 +5,149 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/gen_stats.h>
-#include <linux/jhash.h>
-#include <linux/rtnetlink.h>
-#include <linux/random.h>
-#include <linux/slab.h>
-#include <net/gen_stats.h>
-#include <net/netlink.h>
-#include <net/netns/generic.h>
 
 #include <linux/netfilter/x_tables.h>
-#include <linux/netfilter/xt_RATEEST.h>
+#include <linux/netfilter/xt_rateest.h>
 #include <net/netfilter/xt_rateest.h>
 
-#define RATEEST_HSIZE	16
 
-struct xt_rateest_net {
-	struct mutex hash_lock;
-	struct hlist_head hash[RATEEST_HSIZE];
-};
-
-static unsigned int xt_rateest_id;
-
-static unsigned int jhash_rnd __read_mostly;
-
-static unsigned int xt_rateest_hash(const char *name)
-{
-	return jhash(name, sizeof_field(struct xt_rateest, name), jhash_rnd) &
-	       (RATEEST_HSIZE - 1);
-}
-
-static void xt_rateest_hash_insert(struct xt_rateest_net *xn,
-				   struct xt_rateest *est)
+static bool
+xt_rateest_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
-	unsigned int h;
-
-	h = xt_rateest_hash(est->name);
-	hlist_add_head(&est->list, &xn->hash[h]);
-}
+	const struct xt_rateest_match_info *info = par->matchinfo;
+	struct gnet_stats_rate_est64 sample = {0};
+	u_int32_t bps1, bps2, pps1, pps2;
+	bool ret = true;
+
+	gen_estimator_read(&info->est1->rate_est, &sample);
+
+	if (info->flags & XT_RATEEST_MATCH_DELTA) {
+		bps1 = info->bps1 >= sample.bps ? info->bps1 - sample.bps : 0;
+		pps1 = info->pps1 >= sample.pps ? info->pps1 - sample.pps : 0;
+	} else {
+		bps1 = sample.bps;
+		pps1 = sample.pps;
+	}
 
-static struct xt_rateest *__xt_rateest_lookup(struct xt_rateest_net *xn,
-					      const char *name)
-{
-	struct xt_rateest *est;
-	unsigned int h;
-
-	h = xt_rateest_hash(name);
-	hlist_for_each_entry(est, &xn->hash[h], list) {
-		if (strcmp(est->name, name) == 0) {
-			est->refcnt++;
-			return est;
+	if (info->flags & XT_RATEEST_MATCH_ABS) {
+		bps2 = info->bps2;
+		pps2 = info->pps2;
+	} else {
+		gen_estimator_read(&info->est2->rate_est, &sample);
+
+		if (info->flags & XT_RATEEST_MATCH_DELTA) {
+			bps2 = info->bps2 >= sample.bps ? info->bps2 - sample.bps : 0;
+			pps2 = info->pps2 >= sample.pps ? info->pps2 - sample.pps : 0;
+		} else {
+			bps2 = sample.bps;
+			pps2 = sample.pps;
 		}
 	}
 
-	return NULL;
-}
-
-struct xt_rateest *xt_rateest_lookup(struct net *net, const char *name)
-{
-	struct xt_rateest_net *xn = net_generic(net, xt_rateest_id);
-	struct xt_rateest *est;
-
-	mutex_lock(&xn->hash_lock);
-	est = __xt_rateest_lookup(xn, name);
-	mutex_unlock(&xn->hash_lock);
-	return est;
-}
-EXPORT_SYMBOL_GPL(xt_rateest_lookup);
-
-void xt_rateest_put(struct net *net, struct xt_rateest *est)
-{
-	struct xt_rateest_net *xn = net_generic(net, xt_rateest_id);
-
-	mutex_lock(&xn->hash_lock);
-	if (--est->refcnt == 0) {
-		hlist_del(&est->list);
-		gen_kill_estimator(&est->rate_est);
-		/*
-		 * gen_estimator est_timer() might access est->lock or bstats,
-		 * wait a RCU grace period before freeing 'est'
-		 */
-		kfree_rcu(est, rcu);
+	switch (info->mode) {
+	case XT_RATEEST_MATCH_LT:
+		if (info->flags & XT_RATEEST_MATCH_BPS)
+			ret &= bps1 < bps2;
+		if (info->flags & XT_RATEEST_MATCH_PPS)
+			ret &= pps1 < pps2;
+		break;
+	case XT_RATEEST_MATCH_GT:
+		if (info->flags & XT_RATEEST_MATCH_BPS)
+			ret &= bps1 > bps2;
+		if (info->flags & XT_RATEEST_MATCH_PPS)
+			ret &= pps1 > pps2;
+		break;
+	case XT_RATEEST_MATCH_EQ:
+		if (info->flags & XT_RATEEST_MATCH_BPS)
+			ret &= bps1 == bps2;
+		if (info->flags & XT_RATEEST_MATCH_PPS)
+			ret &= pps1 == pps2;
+		break;
 	}
-	mutex_unlock(&xn->hash_lock);
+
+	ret ^= info->flags & XT_RATEEST_MATCH_INVERT ? true : false;
+	return ret;
 }
-EXPORT_SYMBOL_GPL(xt_rateest_put);
 
-static unsigned int
-xt_rateest_tg(struct sk_buff *skb, const struct xt_action_param *par)
+static int xt_rateest_mt_checkentry(const struct xt_mtchk_param *par)
 {
-	const struct xt_rateest_target_info *info = par->targinfo;
-	struct gnet_stats_basic_sync *stats = &info->est->bstats;
+	struct xt_rateest_match_info *info = par->matchinfo;
+	struct xt_rateest *est1, *est2;
+	int ret = -EINVAL;
 
-	spin_lock_bh(&info->est->lock);
-	u64_stats_add(&stats->bytes, skb->len);
-	u64_stats_inc(&stats->packets);
-	spin_unlock_bh(&info->est->lock);
+	if (hweight32(info->flags & (XT_RATEEST_MATCH_ABS |
+				     XT_RATEEST_MATCH_REL)) != 1)
+		goto err1;
 
-	return XT_CONTINUE;
-}
+	if (!(info->flags & (XT_RATEEST_MATCH_BPS | XT_RATEEST_MATCH_PPS)))
+		goto err1;
 
-static int xt_rateest_tg_checkentry(const struct xt_tgchk_param *par)
-{
-	struct xt_rateest_net *xn = net_generic(par->net, xt_rateest_id);
-	struct xt_rateest_target_info *info = par->targinfo;
-	struct xt_rateest *est;
-	struct {
-		struct nlattr		opt;
-		struct gnet_estimator	est;
-	} cfg;
-	int ret;
-
-	if (strnlen(info->name, sizeof(est->name)) >= sizeof(est->name))
-		return -ENAMETOOLONG;
-
-	net_get_random_once(&jhash_rnd, sizeof(jhash_rnd));
-
-	mutex_lock(&xn->hash_lock);
-	est = __xt_rateest_lookup(xn, info->name);
-	if (est) {
-		mutex_unlock(&xn->hash_lock);
-		/*
-		 * If estimator parameters are specified, they must match the
-		 * existing estimator.
-		 */
-		if ((!info->interval && !info->ewma_log) ||
-		    (info->interval != est->params.interval ||
-		     info->ewma_log != est->params.ewma_log)) {
-			xt_rateest_put(par->net, est);
-			return -EINVAL;
-		}
-		info->est = est;
-		return 0;
+	switch (info->mode) {
+	case XT_RATEEST_MATCH_EQ:
+	case XT_RATEEST_MATCH_LT:
+	case XT_RATEEST_MATCH_GT:
+		break;
+	default:
+		goto err1;
 	}
 
-	ret = -ENOMEM;
-	est = kzalloc(sizeof(*est), GFP_KERNEL);
-	if (!est)
+	ret  = -ENOENT;
+	est1 = xt_rateest_lookup(par->net, info->name1);
+	if (!est1)
 		goto err1;
 
-	gnet_stats_basic_sync_init(&est->bstats);
-	strscpy(est->name, info->name, sizeof(est->name));
-	spin_lock_init(&est->lock);
-	est->refcnt		= 1;
-	est->params.interval	= info->interval;
-	est->params.ewma_log	= info->ewma_log;
-
-	cfg.opt.nla_len		= nla_attr_size(sizeof(cfg.est));
-	cfg.opt.nla_type	= TCA_STATS_RATE_EST;
-	cfg.est.interval	= info->interval;
-	cfg.est.ewma_log	= info->ewma_log;
-
-	ret = gen_new_estimator(&est->bstats, NULL, &est->rate_est,
-				&est->lock, NULL, &cfg.opt);
-	if (ret < 0)
-		goto err2;
-
-	info->est = est;
-	xt_rateest_hash_insert(xn, est);
-	mutex_unlock(&xn->hash_lock);
+	est2 = NULL;
+	if (info->flags & XT_RATEEST_MATCH_REL) {
+		est2 = xt_rateest_lookup(par->net, info->name2);
+		if (!est2)
+			goto err2;
+	}
+
+	info->est1 = est1;
+	info->est2 = est2;
 	return 0;
 
 err2:
-	kfree(est);
+	xt_rateest_put(par->net, est1);
 err1:
-	mutex_unlock(&xn->hash_lock);
 	return ret;
 }
 
-static void xt_rateest_tg_destroy(const struct xt_tgdtor_param *par)
+static void xt_rateest_mt_destroy(const struct xt_mtdtor_param *par)
 {
-	struct xt_rateest_target_info *info = par->targinfo;
+	struct xt_rateest_match_info *info = par->matchinfo;
 
-	xt_rateest_put(par->net, info->est);
+	xt_rateest_put(par->net, info->est1);
+	if (info->est2)
+		xt_rateest_put(par->net, info->est2);
 }
 
-static struct xt_target xt_rateest_tg_reg[] __read_mostly = {
-	{
-		.name       = "RATEEST",
-		.revision   = 0,
-		.family     = NFPROTO_IPV4,
-		.target     = xt_rateest_tg,
-		.checkentry = xt_rateest_tg_checkentry,
-		.destroy    = xt_rateest_tg_destroy,
-		.targetsize = sizeof(struct xt_rateest_target_info),
-		.usersize   = offsetof(struct xt_rateest_target_info, est),
-		.me         = THIS_MODULE,
-	},
-#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
-	{
-		.name       = "RATEEST",
-		.revision   = 0,
-		.family     = NFPROTO_IPV6,
-		.target     = xt_rateest_tg,
-		.checkentry = xt_rateest_tg_checkentry,
-		.destroy    = xt_rateest_tg_destroy,
-		.targetsize = sizeof(struct xt_rateest_target_info),
-		.usersize   = offsetof(struct xt_rateest_target_info, est),
-		.me         = THIS_MODULE,
-	},
-#endif
+static struct xt_match xt_rateest_mt_reg __read_mostly = {
+	.name       = "rateest",
+	.revision   = 0,
+	.family     = NFPROTO_UNSPEC,
+	.match      = xt_rateest_mt,
+	.checkentry = xt_rateest_mt_checkentry,
+	.destroy    = xt_rateest_mt_destroy,
+	.matchsize  = sizeof(struct xt_rateest_match_info),
+	.usersize   = offsetof(struct xt_rateest_match_info, est1),
+	.me         = THIS_MODULE,
 };
 
-static __net_init int xt_rateest_net_init(struct net *net)
+static int __init xt_rateest_mt_init(void)
 {
-	struct xt_rateest_net *xn = net_generic(net, xt_rateest_id);
-	int i;
-
-	mutex_init(&xn->hash_lock);
-	for (i = 0; i < ARRAY_SIZE(xn->hash); i++)
-		INIT_HLIST_HEAD(&xn->hash[i]);
-	return 0;
+	return xt_register_match(&xt_rateest_mt_reg);
 }
 
-static struct pernet_operations xt_rateest_net_ops = {
-	.init = xt_rateest_net_init,
-	.id   = &xt_rateest_id,
-	.size = sizeof(struct xt_rateest_net),
-};
-
-static int __init xt_rateest_tg_init(void)
+static void __exit xt_rateest_mt_fini(void)
 {
-	int err = register_pernet_subsys(&xt_rateest_net_ops);
-
-	if (err)
-		return err;
-	return xt_register_targets(xt_rateest_tg_reg, ARRAY_SIZE(xt_rateest_tg_reg));
+	xt_unregister_match(&xt_rateest_mt_reg);
 }
 
-static void __exit xt_rateest_tg_fini(void)
-{
-	xt_unregister_targets(xt_rateest_tg_reg, ARRAY_SIZE(xt_rateest_tg_reg));
-	unregister_pernet_subsys(&xt_rateest_net_ops);
-}
-
-
 MODULE_AUTHOR("Patrick McHardy <kaber@trash.net>");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Xtables: packet rate estimator");
-MODULE_ALIAS("ipt_RATEEST");
-MODULE_ALIAS("ip6t_RATEEST");
-module_init(xt_rateest_tg_init);
-module_exit(xt_rateest_tg_fini);
+MODULE_DESCRIPTION("xtables rate estimator match");
+MODULE_ALIAS("ipt_rateest");
+MODULE_ALIAS("ip6t_rateest");
+module_init(xt_rateest_mt_init);
+module_exit(xt_rateest_mt_fini);
diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
index 116a885adb3c..37704ab01799 100644
--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -1,345 +1,107 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*
- * This is a module which is used for setting the MSS option in TCP packets.
- *
- * Copyright (C) 2000 Marc Boucher <marc@mbsi.ca>
- * Copyright (C) 2007 Patrick McHardy <kaber@trash.net>
+/* Kernel module to match TCP MSS values. */
+
+/* Copyright (C) 2000 Marc Boucher <marc@mbsi.ca>
+ * Portions (C) 2005 by Harald Welte <laforge@netfilter.org>
  */
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/skbuff.h>
-#include <linux/ip.h>
-#include <linux/gfp.h>
-#include <linux/ipv6.h>
-#include <linux/tcp.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/ipv6.h>
-#include <net/route.h>
 #include <net/tcp.h>
 
+#include <linux/netfilter/xt_tcpmss.h>
+#include <linux/netfilter/x_tables.h>
+
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv6/ip6_tables.h>
-#include <linux/netfilter/x_tables.h>
-#include <linux/netfilter/xt_tcpudp.h>
-#include <linux/netfilter/xt_TCPMSS.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Marc Boucher <marc@mbsi.ca>");
-MODULE_DESCRIPTION("Xtables: TCP Maximum Segment Size (MSS) adjustment");
-MODULE_ALIAS("ipt_TCPMSS");
-MODULE_ALIAS("ip6t_TCPMSS");
+MODULE_DESCRIPTION("Xtables: TCP MSS match");
+MODULE_ALIAS("ipt_tcpmss");
+MODULE_ALIAS("ip6t_tcpmss");
 
-static inline unsigned int
-optlen(const u_int8_t *opt, unsigned int offset)
+static bool
+tcpmss_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
-	/* Beware zero-length options: make finite progress */
-	if (opt[offset] <= TCPOPT_NOP || opt[offset+1] == 0)
-		return 1;
-	else
-		return opt[offset+1];
-}
-
-static u_int32_t tcpmss_reverse_mtu(struct net *net,
-				    const struct sk_buff *skb,
-				    unsigned int family)
-{
-	struct flowi fl;
-	struct rtable *rt = NULL;
-	u_int32_t mtu     = ~0U;
-
-	if (family == PF_INET) {
-		struct flowi4 *fl4 = &fl.u.ip4;
-		memset(fl4, 0, sizeof(*fl4));
-		fl4->daddr = ip_hdr(skb)->saddr;
-	} else {
-		struct flowi6 *fl6 = &fl.u.ip6;
-
-		memset(fl6, 0, sizeof(*fl6));
-		fl6->daddr = ipv6_hdr(skb)->saddr;
-	}
-
-	nf_route(net, (struct dst_entry **)&rt, &fl, false, family);
-	if (rt != NULL) {
-		mtu = dst_mtu(&rt->dst);
-		dst_release(&rt->dst);
-	}
-	return mtu;
-}
-
-static int
-tcpmss_mangle_packet(struct sk_buff *skb,
-		     const struct xt_action_param *par,
-		     unsigned int family,
-		     unsigned int tcphoff,
-		     unsigned int minlen)
-{
-	const struct xt_tcpmss_info *info = par->targinfo;
-	struct tcphdr *tcph;
-	int len, tcp_hdrlen;
-	unsigned int i;
-	__be16 oldval;
-	u16 newmss;
-	u8 *opt;
-
-	/* This is a fragment, no TCP header is available */
-	if (par->fragoff != 0)
-		return 0;
-
-	if (skb_ensure_writable(skb, skb->len))
-		return -1;
-
-	len = skb->len - tcphoff;
-	if (len < (int)sizeof(struct tcphdr))
-		return -1;
-
-	tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
-	tcp_hdrlen = tcph->doff * 4;
-
-	if (len < tcp_hdrlen || tcp_hdrlen < sizeof(struct tcphdr))
-		return -1;
-
-	if (info->mss == XT_TCPMSS_CLAMP_PMTU) {
-		struct net *net = xt_net(par);
-		unsigned int in_mtu = tcpmss_reverse_mtu(net, skb, family);
-		unsigned int min_mtu = min(dst_mtu(skb_dst(skb)), in_mtu);
-
-		if (min_mtu <= minlen) {
-			net_err_ratelimited("unknown or invalid path-MTU (%u)\n",
-					    min_mtu);
-			return -1;
-		}
-		newmss = min_mtu - minlen;
-	} else
-		newmss = info->mss;
-
-	opt = (u_int8_t *)tcph;
-	for (i = sizeof(struct tcphdr); i <= tcp_hdrlen - TCPOLEN_MSS; i += optlen(opt, i)) {
-		if (opt[i] == TCPOPT_MSS && opt[i+1] == TCPOLEN_MSS) {
-			u_int16_t oldmss;
-
-			oldmss = (opt[i+2] << 8) | opt[i+3];
-
-			/* Never increase MSS, even when setting it, as
-			 * doing so results in problems for hosts that rely
-			 * on MSS being set correctly.
-			 */
-			if (oldmss <= newmss)
-				return 0;
-
-			opt[i+2] = (newmss & 0xff00) >> 8;
-			opt[i+3] = newmss & 0x00ff;
-
-			inet_proto_csum_replace2(&tcph->check, skb,
-						 htons(oldmss), htons(newmss),
-						 false);
-			return 0;
+	const struct xt_tcpmss_match_info *info = par->matchinfo;
+	const struct tcphdr *th;
+	struct tcphdr _tcph;
+	/* tcp.doff is only 4 bits, ie. max 15 * 4 bytes */
+	const u_int8_t *op;
+	u8 _opt[15 * 4 - sizeof(_tcph)];
+	unsigned int i, optlen;
+
+	/* If we don't have the whole header, drop packet. */
+	th = skb_header_pointer(skb, par->thoff, sizeof(_tcph), &_tcph);
+	if (th == NULL)
+		goto dropit;
+
+	/* Malformed. */
+	if (th->doff*4 < sizeof(*th))
+		goto dropit;
+
+	optlen = th->doff*4 - sizeof(*th);
+	if (!optlen)
+		goto out;
+
+	/* Truncated options. */
+	op = skb_header_pointer(skb, par->thoff + sizeof(*th), optlen, _opt);
+	if (op == NULL)
+		goto dropit;
+
+	for (i = 0; i < optlen; ) {
+		if (op[i] == TCPOPT_MSS
+		    && (optlen - i) >= TCPOLEN_MSS
+		    && op[i+1] == TCPOLEN_MSS) {
+			u_int16_t mssval;
+
+			mssval = (op[i+2] << 8) | op[i+3];
+
+			return (mssval >= info->mss_min &&
+				mssval <= info->mss_max) ^ info->invert;
 		}
+		if (op[i] < 2)
+			i++;
+		else
+			i += op[i+1] ? : 1;
 	}
+out:
+	return info->invert;
 
-	/* There is data after the header so the option can't be added
-	 * without moving it, and doing so may make the SYN packet
-	 * itself too large. Accept the packet unmodified instead.
-	 */
-	if (len > tcp_hdrlen)
-		return 0;
-
-	/* tcph->doff has 4 bits, do not wrap it to 0 */
-	if (tcp_hdrlen >= 15 * 4)
-		return 0;
-
-	/*
-	 * MSS Option not found ?! add it..
-	 */
-	if (skb_tailroom(skb) < TCPOLEN_MSS) {
-		if (pskb_expand_head(skb, 0,
-				     TCPOLEN_MSS - skb_tailroom(skb),
-				     GFP_ATOMIC))
-			return -1;
-		tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
-	}
-
-	skb_put(skb, TCPOLEN_MSS);
-
-	/*
-	 * IPv4: RFC 1122 states "If an MSS option is not received at
-	 * connection setup, TCP MUST assume a default send MSS of 536".
-	 * IPv6: RFC 2460 states IPv6 has a minimum MTU of 1280 and a minimum
-	 * length IPv6 header of 60, ergo the default MSS value is 1220
-	 * Since no MSS was provided, we must use the default values
-	 */
-	if (xt_family(par) == NFPROTO_IPV4)
-		newmss = min(newmss, (u16)536);
-	else
-		newmss = min(newmss, (u16)1220);
-
-	opt = (u_int8_t *)tcph + sizeof(struct tcphdr);
-	memmove(opt + TCPOLEN_MSS, opt, len - sizeof(struct tcphdr));
-
-	inet_proto_csum_replace2(&tcph->check, skb,
-				 htons(len), htons(len + TCPOLEN_MSS), true);
-	opt[0] = TCPOPT_MSS;
-	opt[1] = TCPOLEN_MSS;
-	opt[2] = (newmss & 0xff00) >> 8;
-	opt[3] = newmss & 0x00ff;
-
-	inet_proto_csum_replace4(&tcph->check, skb, 0, *((__be32 *)opt), false);
-
-	oldval = ((__be16 *)tcph)[6];
-	tcph->doff += TCPOLEN_MSS/4;
-	inet_proto_csum_replace2(&tcph->check, skb,
-				 oldval, ((__be16 *)tcph)[6], false);
-	return TCPOLEN_MSS;
-}
-
-static unsigned int
-tcpmss_tg4(struct sk_buff *skb, const struct xt_action_param *par)
-{
-	struct iphdr *iph = ip_hdr(skb);
-	__be16 newlen;
-	int ret;
-
-	ret = tcpmss_mangle_packet(skb, par,
-				   PF_INET,
-				   iph->ihl * 4,
-				   sizeof(*iph) + sizeof(struct tcphdr));
-	if (ret < 0)
-		return NF_DROP;
-	if (ret > 0) {
-		iph = ip_hdr(skb);
-		newlen = htons(ntohs(iph->tot_len) + ret);
-		csum_replace2(&iph->check, iph->tot_len, newlen);
-		iph->tot_len = newlen;
-	}
-	return XT_CONTINUE;
-}
-
-#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
-static unsigned int
-tcpmss_tg6(struct sk_buff *skb, const struct xt_action_param *par)
-{
-	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-	u8 nexthdr;
-	__be16 frag_off, oldlen, newlen;
-	int tcphoff;
-	int ret;
-
-	nexthdr = ipv6h->nexthdr;
-	tcphoff = ipv6_skip_exthdr(skb, sizeof(*ipv6h), &nexthdr, &frag_off);
-	if (tcphoff < 0)
-		return NF_DROP;
-	ret = tcpmss_mangle_packet(skb, par,
-				   PF_INET6,
-				   tcphoff,
-				   sizeof(*ipv6h) + sizeof(struct tcphdr));
-	if (ret < 0)
-		return NF_DROP;
-	if (ret > 0) {
-		ipv6h = ipv6_hdr(skb);
-		oldlen = ipv6h->payload_len;
-		newlen = htons(ntohs(oldlen) + ret);
-		if (skb->ip_summed == CHECKSUM_COMPLETE)
-			skb->csum = csum_add(csum_sub(skb->csum, (__force __wsum)oldlen),
-					     (__force __wsum)newlen);
-		ipv6h->payload_len = newlen;
-	}
-	return XT_CONTINUE;
-}
-#endif
-
-/* Must specify -p tcp --syn */
-static inline bool find_syn_match(const struct xt_entry_match *m)
-{
-	const struct xt_tcp *tcpinfo = (const struct xt_tcp *)m->data;
-
-	if (strcmp(m->u.kernel.match->name, "tcp") == 0 &&
-	    tcpinfo->flg_cmp & TCPHDR_SYN &&
-	    !(tcpinfo->invflags & XT_TCP_INV_FLAGS))
-		return true;
-
+dropit:
+	par->hotdrop = true;
 	return false;
 }
 
-static int tcpmss_tg4_check(const struct xt_tgchk_param *par)
-{
-	const struct xt_tcpmss_info *info = par->targinfo;
-	const struct ipt_entry *e = par->entryinfo;
-	const struct xt_entry_match *ematch;
-
-	if (info->mss == XT_TCPMSS_CLAMP_PMTU &&
-	    (par->hook_mask & ~((1 << NF_INET_FORWARD) |
-			   (1 << NF_INET_LOCAL_OUT) |
-			   (1 << NF_INET_POST_ROUTING))) != 0) {
-		pr_info_ratelimited("path-MTU clamping only supported in FORWARD, OUTPUT and POSTROUTING hooks\n");
-		return -EINVAL;
-	}
-	if (par->nft_compat)
-		return 0;
-
-	xt_ematch_foreach(ematch, e)
-		if (find_syn_match(ematch))
-			return 0;
-	pr_info_ratelimited("Only works on TCP SYN packets\n");
-	return -EINVAL;
-}
-
-#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
-static int tcpmss_tg6_check(const struct xt_tgchk_param *par)
-{
-	const struct xt_tcpmss_info *info = par->targinfo;
-	const struct ip6t_entry *e = par->entryinfo;
-	const struct xt_entry_match *ematch;
-
-	if (info->mss == XT_TCPMSS_CLAMP_PMTU &&
-	    (par->hook_mask & ~((1 << NF_INET_FORWARD) |
-			   (1 << NF_INET_LOCAL_OUT) |
-			   (1 << NF_INET_POST_ROUTING))) != 0) {
-		pr_info_ratelimited("path-MTU clamping only supported in FORWARD, OUTPUT and POSTROUTING hooks\n");
-		return -EINVAL;
-	}
-	if (par->nft_compat)
-		return 0;
-
-	xt_ematch_foreach(ematch, e)
-		if (find_syn_match(ematch))
-			return 0;
-	pr_info_ratelimited("Only works on TCP SYN packets\n");
-	return -EINVAL;
-}
-#endif
-
-static struct xt_target tcpmss_tg_reg[] __read_mostly = {
+static struct xt_match tcpmss_mt_reg[] __read_mostly = {
 	{
+		.name		= "tcpmss",
 		.family		= NFPROTO_IPV4,
-		.name		= "TCPMSS",
-		.checkentry	= tcpmss_tg4_check,
-		.target		= tcpmss_tg4,
-		.targetsize	= sizeof(struct xt_tcpmss_info),
+		.match		= tcpmss_mt,
+		.matchsize	= sizeof(struct xt_tcpmss_match_info),
 		.proto		= IPPROTO_TCP,
 		.me		= THIS_MODULE,
 	},
-#if IS_ENABLED(CONFIG_IP6_NF_IPTABLES)
 	{
+		.name		= "tcpmss",
 		.family		= NFPROTO_IPV6,
-		.name		= "TCPMSS",
-		.checkentry	= tcpmss_tg6_check,
-		.target		= tcpmss_tg6,
-		.targetsize	= sizeof(struct xt_tcpmss_info),
+		.match		= tcpmss_mt,
+		.matchsize	= sizeof(struct xt_tcpmss_match_info),
 		.proto		= IPPROTO_TCP,
 		.me		= THIS_MODULE,
 	},
-#endif
 };
 
-static int __init tcpmss_tg_init(void)
+static int __init tcpmss_mt_init(void)
 {
-	return xt_register_targets(tcpmss_tg_reg, ARRAY_SIZE(tcpmss_tg_reg));
+	return xt_register_matches(tcpmss_mt_reg, ARRAY_SIZE(tcpmss_mt_reg));
 }
 
-static void __exit tcpmss_tg_exit(void)
+static void __exit tcpmss_mt_exit(void)
 {
-	xt_unregister_targets(tcpmss_tg_reg, ARRAY_SIZE(tcpmss_tg_reg));
+	xt_unregister_matches(tcpmss_mt_reg, ARRAY_SIZE(tcpmss_mt_reg));
 }
 
-module_init(tcpmss_tg_init);
-module_exit(tcpmss_tg_exit);
+module_init(tcpmss_mt_init);
+module_exit(tcpmss_mt_exit);
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
index 415248fb6699..10a2aa04cd07 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
@@ -1,12 +1,11 @@
-C Z6.0+pooncelock+poonceLock+pombonce
+C Z6.0+pooncelock+pooncelock+pombonce
 
 (*
- * Result: Never
+ * Result: Sometimes
  *
- * This litmus test demonstrates how smp_mb__after_spinlock() may be
- * used to ensure that accesses in different critical sections for a
- * given lock running on different CPUs are nevertheless seen in order
- * by CPUs not holding that lock.
+ * This example demonstrates that a pair of accesses made by different
+ * processes each while holding a given lock will not necessarily be
+ * seen as ordered by a third process not holding that lock.
  *)
 
 {}
@@ -24,7 +23,6 @@ P1(int *y, int *z, spinlock_t *mylock)
 	int r0;
 
 	spin_lock(mylock);
-	smp_mb__after_spinlock();
 	r0 = READ_ONCE(*y);
 	WRITE_ONCE(*z, 1);
 	spin_unlock(mylock);
-- 
2.49.0


