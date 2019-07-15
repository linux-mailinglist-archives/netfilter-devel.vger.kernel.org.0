Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D4698B4
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jul 2019 17:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfGOP7N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Jul 2019 11:59:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55112 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbfGOP7N (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:59:13 -0400
Received: from chpebeni.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net [108.15.23.247])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8A55820B7185
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jul 2019 08:59:12 -0700 (PDT)
From:   Chris PeBenito <chpebeni@linux.microsoft.com>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libiptc] libip6tc.h: Add extern "C" wrapping for C++ linking.
Date:   Mon, 15 Jul 2019 11:58:55 -0400
Message-Id: <20190715155855.4415-1-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 include/libiptc/libip6tc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/libiptc/libip6tc.h b/include/libiptc/libip6tc.h
index 9aed80a0..eaf34d65 100644
--- a/include/libiptc/libip6tc.h
+++ b/include/libiptc/libip6tc.h
@@ -12,6 +12,10 @@
 #include <linux/netfilter_ipv6/ip6_tables.h>
 #include <libiptc/xtcshared.h>
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 #define ip6tc_handle xtc_handle
 #define ip6t_chainlabel xt_chainlabel
 
@@ -158,4 +162,8 @@ extern void dump_entries6(struct xtc_handle *const);
 
 extern const struct xtc_ops ip6tc_ops;
 
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
 #endif /* _LIBIP6TC_H */
-- 
2.21.0

