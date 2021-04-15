Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB74360A4D
	for <lists+netfilter-devel@lfdr.de>; Thu, 15 Apr 2021 15:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhDONOE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 15 Apr 2021 09:14:04 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57878 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbhDONOB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:14:01 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id BC0B663E81
        for <netfilter-devel@vger.kernel.org>; Thu, 15 Apr 2021 15:13:10 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 08/10] cache: move struct nft_cache declaration to cache.h
Date:   Thu, 15 Apr 2021 15:13:28 +0200
Message-Id: <20210415131330.6692-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415131330.6692-1-pablo@netfilter.org>
References: <20210415131330.6692-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Move struct nft_cache declaration to include/cache.h.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/cache.h    | 9 +++++++++
 include/nftables.h | 8 +-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/cache.h b/include/cache.h
index d3be4c8a8693..cab8a6bcca05 100644
--- a/include/cache.h
+++ b/include/cache.h
@@ -1,6 +1,15 @@
 #ifndef _NFT_CACHE_H_
 #define _NFT_CACHE_H_
 
+#include <string.h>
+
+struct nft_cache {
+	uint32_t		genid;
+	struct list_head	list;
+	uint32_t		seqnum;
+	uint32_t		flags;
+};
+
 enum cache_level_bits {
 	NFT_CACHE_TABLE_BIT	= (1 << 0),
 	NFT_CACHE_CHAIN_BIT	= (1 << 1),
diff --git a/include/nftables.h b/include/nftables.h
index 9095ff3d0b79..f239fcf0e1f4 100644
--- a/include/nftables.h
+++ b/include/nftables.h
@@ -5,6 +5,7 @@
 #include <stdarg.h>
 #include <limits.h>
 #include <utils.h>
+#include <cache.h>
 #include <nftables/libnftables.h>
 
 struct cookie {
@@ -95,13 +96,6 @@ static inline bool nft_output_terse(const struct output_ctx *octx)
 	return octx->flags & NFT_CTX_OUTPUT_TERSE;
 }
 
-struct nft_cache {
-	uint32_t		genid;
-	struct list_head	list;
-	uint32_t		seqnum;
-	uint32_t		flags;
-};
-
 struct mnl_socket;
 struct parser_state;
 struct scope;
-- 
2.20.1

