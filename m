Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785AB1140DE
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Dec 2019 13:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfLEMfW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Dec 2019 07:35:22 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:60798 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbfLEMfW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Dec 2019 07:35:22 -0500
Received: from localhost ([::1]:45656 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1icqLo-0005LU-5n; Thu, 05 Dec 2019 13:35:20 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nf PATCH] uapi: netfilter: Avoid undefined left-shift in xt_sctp.h
Date:   Thu,  5 Dec 2019 13:35:11 +0100
Message-Id: <20191205123511.23932-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

With 'bytes(__u32)' being 32, a left-shift of 31 may happen which is
undefined for the signed 32-bit value 1. Avoid this by declaring 1 as
unsigned.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/uapi/linux/netfilter/xt_sctp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/netfilter/xt_sctp.h b/include/uapi/linux/netfilter/xt_sctp.h
index 4bc6d1a087816..b4d804a9fccb2 100644
--- a/include/uapi/linux/netfilter/xt_sctp.h
+++ b/include/uapi/linux/netfilter/xt_sctp.h
@@ -41,19 +41,19 @@ struct xt_sctp_info {
 #define SCTP_CHUNKMAP_SET(chunkmap, type) 		\
 	do { 						\
 		(chunkmap)[type / bytes(__u32)] |= 	\
-			1 << (type % bytes(__u32));	\
+			1u << (type % bytes(__u32));	\
 	} while (0)
 
 #define SCTP_CHUNKMAP_CLEAR(chunkmap, type)		 	\
 	do {							\
 		(chunkmap)[type / bytes(__u32)] &= 		\
-			~(1 << (type % bytes(__u32)));	\
+			~(1u << (type % bytes(__u32)));	\
 	} while (0)
 
 #define SCTP_CHUNKMAP_IS_SET(chunkmap, type) 			\
 ({								\
 	((chunkmap)[type / bytes (__u32)] & 		\
-		(1 << (type % bytes (__u32)))) ? 1: 0;	\
+		(1u << (type % bytes (__u32)))) ? 1: 0;	\
 })
 
 #define SCTP_CHUNKMAP_RESET(chunkmap) \
-- 
2.24.0

