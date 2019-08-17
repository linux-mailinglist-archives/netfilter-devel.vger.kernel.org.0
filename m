Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F7091033
	for <lists+netfilter-devel@lfdr.de>; Sat, 17 Aug 2019 13:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfHQLSE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 17 Aug 2019 07:18:04 -0400
Received: from vxsys-smtpclusterma-05.srv.cat ([46.16.61.54]:60317 "EHLO
        vxsys-smtpclusterma-05.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725784AbfHQLSE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 17 Aug 2019 07:18:04 -0400
Received: from localhost.localdomain (static-79-171-230-77.ipcom.comunitel.net [77.230.171.79])
        by vxsys-smtpclusterma-05.srv.cat (Postfix) with ESMTPA id 7078424283
        for <netfilter-devel@vger.kernel.org>; Sat, 17 Aug 2019 13:18:00 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH v5 1/2] netfilter: Introduce new 64-bit helper functions
Date:   Sat, 17 Aug 2019 13:17:52 +0200
Message-Id: <20190817111753.8756-1-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Introduce new helper functions to load/store 64-bit values
onto/from registers:

 - nft_reg_store64
 - nft_reg_load64

This commit also re-orders all these helpers from smallest
to largest target bit size.

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 include/net/netfilter/nf_tables.h | 25 ++++++++++++++++++-------
 net/netfilter/nft_byteorder.c     |  9 +++++----
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 9b624566b82d..298cf4528635 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -2,6 +2,7 @@
 #ifndef _NET_NF_TABLES_H
 #define _NET_NF_TABLES_H
 
+#include <asm/unaligned.h>
 #include <linux/list.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nfnetlink.h>
@@ -100,23 +101,28 @@ struct nft_regs {
 	};
 };
 
-/* Store/load an u16 or u8 integer to/from the u32 data register.
+/* Store/load an u8, u16 or u64 integer to/from the u32 data register.
  *
  * Note, when using concatenations, register allocation happens at 32-bit
  * level. So for store instruction, pad the rest part with zero to avoid
  * garbage values.
  */
 
-static inline void nft_reg_store16(u32 *dreg, u16 val)
+static inline void nft_reg_store8(u32 *dreg, u8 val)
 {
 	*dreg = 0;
-	*(u16 *)dreg = val;
+	*(u8 *)dreg = val;
 }
 
-static inline void nft_reg_store8(u32 *dreg, u8 val)
+static inline u8 nft_reg_load8(u32 *sreg)
+{
+	return *(u8 *)sreg;
+}
+
+static inline void nft_reg_store16(u32 *dreg, u16 val)
 {
 	*dreg = 0;
-	*(u8 *)dreg = val;
+	*(u16 *)dreg = val;
 }
 
 static inline u16 nft_reg_load16(u32 *sreg)
@@ -124,9 +130,14 @@ static inline u16 nft_reg_load16(u32 *sreg)
 	return *(u16 *)sreg;
 }
 
-static inline u8 nft_reg_load8(u32 *sreg)
+static inline void nft_reg_store64(u32 *dreg, u64 val)
 {
-	return *(u8 *)sreg;
+	put_unaligned(val, (u64 *)dreg);
+}
+
+static inline u64 nft_reg_load64(u32 *sreg)
+{
+	return get_unaligned((u64 *)sreg);
 }
 
 static inline void nft_data_copy(u32 *dst, const struct nft_data *src,
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index e06318428ea0..12bed3f7bbc6 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -43,14 +43,15 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 8; i++) {
-				src64 = get_unaligned((u64 *)&src[i]);
-				put_unaligned_be64(src64, &dst[i]);
+				src64 = nft_reg_load64(&src[i]);
+				nft_reg_store64(&dst[i], be64_to_cpu(src64));
 			}
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 8; i++) {
-				src64 = get_unaligned_be64(&src[i]);
-				put_unaligned(src64, (u64 *)&dst[i]);
+				src64 = (__force __u64)
+					cpu_to_be64(nft_reg_load64(&src[i]));
+				nft_reg_store64(&dst[i], src64);
 			}
 			break;
 		}
-- 
2.17.1

