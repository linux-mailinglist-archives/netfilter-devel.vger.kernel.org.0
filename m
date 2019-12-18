Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E613124562
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 12:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLRLKr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 06:10:47 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:36074 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbfLRLKr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:10:47 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ihXE5-0007Eo-Lm; Wed, 18 Dec 2019 12:10:45 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Martin Willi <martin@strongswan.org>
Subject: [PATCH libnftnl] expr: meta: add slave device matching
Date:   Wed, 18 Dec 2019 12:10:40 +0100
Message-Id: <20191218111041.14764-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Cc: Martin Willi <martin@strongswan.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/linux/netfilter/nf_tables.h | 4 ++++
 src/expr/meta.c                     | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index bb9b049310df..e237ecbdcd8a 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -805,6 +805,8 @@ enum nft_exthdr_attributes {
  * @NFT_META_TIME_NS: time since epoch (in nanoseconds)
  * @NFT_META_TIME_DAY: day of week (from 0 = Sunday to 6 = Saturday)
  * @NFT_META_TIME_HOUR: hour of day (in seconds)
+ * @NFT_META_SDIF: slave device interface index
+ * @NFT_META_SDIFNAME: slave device interface name
  */
 enum nft_meta_keys {
 	NFT_META_LEN,
@@ -840,6 +842,8 @@ enum nft_meta_keys {
 	NFT_META_TIME_NS,
 	NFT_META_TIME_DAY,
 	NFT_META_TIME_HOUR,
+	NFT_META_SDIF,
+	NFT_META_SDIFNAME,
 };
 
 /**
diff --git a/src/expr/meta.c b/src/expr/meta.c
index 979019831f2b..6ed8ee5645c4 100644
--- a/src/expr/meta.c
+++ b/src/expr/meta.c
@@ -22,7 +22,7 @@
 #include <libnftnl/rule.h>
 
 #ifndef NFT_META_MAX
-#define NFT_META_MAX (NFT_META_TIME_HOUR + 1)
+#define NFT_META_MAX (NFT_META_SDIFNAME + 1)
 #endif
 
 struct nftnl_expr_meta {
@@ -166,6 +166,8 @@ static const char *meta_key2str_array[NFT_META_MAX] = {
 	[NFT_META_TIME_NS]	= "time",
 	[NFT_META_TIME_DAY]	= "day",
 	[NFT_META_TIME_HOUR]	= "hour",
+	[NFT_META_SDIF]		= "sdif",
+	[NFT_META_SDIFNAME]	= "sdifname",
 };
 
 static const char *meta_key2str(uint8_t key)
-- 
2.24.1

