Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1491045
	for <lists+netfilter-devel@lfdr.de>; Sat, 17 Aug 2019 13:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfHQLc4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 17 Aug 2019 07:32:56 -0400
Received: from vxsys-smtpclusterma-05.srv.cat ([46.16.61.54]:56091 "EHLO
        vxsys-smtpclusterma-05.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbfHQLc4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 17 Aug 2019 07:32:56 -0400
Received: from localhost.localdomain (static-79-171-230-77.ipcom.comunitel.net [77.230.171.79])
        by vxsys-smtpclusterma-05.srv.cat (Postfix) with ESMTPA id B3B7723759
        for <netfilter-devel@vger.kernel.org>; Sat, 17 Aug 2019 13:32:53 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl v2 1/2] expr: meta: Make NFT_META_TIME_{NS,DAY,HOUR} known
Date:   Sat, 17 Aug 2019 13:32:47 +0200
Message-Id: <20190817113248.9832-1-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 include/linux/netfilter/nf_tables.h | 6 ++++++
 src/expr/meta.c                     | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index 03fd1b7..0222d08 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -799,6 +799,9 @@ enum nft_exthdr_attributes {
  * @NFT_META_OIFKIND: packet output interface kind name (dev->rtnl_link_ops->kind)
  * @NFT_META_BRI_IIFPVID: packet input bridge port pvid
  * @NFT_META_BRI_IIFVPROTO: packet input bridge vlan proto
+ * @NFT_META_TIME_NS: time since epoch (in nanoseconds)
+ * @NFT_META_TIME_DAY: day of week (from 0 = Sunday to 6 = Saturday)
+ * @NFT_META_TIME_HOUR: hour of day (in seconds)
  */
 enum nft_meta_keys {
 	NFT_META_LEN,
@@ -831,6 +834,9 @@ enum nft_meta_keys {
 	NFT_META_OIFKIND,
 	NFT_META_BRI_IIFPVID,
 	NFT_META_BRI_IIFVPROTO,
+	NFT_META_TIME_NS,
+	NFT_META_TIME_DAY,
+	NFT_META_TIME_HOUR,
 };
 
 /**
diff --git a/src/expr/meta.c b/src/expr/meta.c
index 73f6efa..9790198 100644
--- a/src/expr/meta.c
+++ b/src/expr/meta.c
@@ -22,7 +22,7 @@
 #include <libnftnl/rule.h>
 
 #ifndef NFT_META_MAX
-#define NFT_META_MAX (NFT_META_BRI_IIFVPROTO + 1)
+#define NFT_META_MAX (NFT_META_TIME_HOUR + 1)
 #endif
 
 struct nftnl_expr_meta {
@@ -163,6 +163,9 @@ static const char *meta_key2str_array[NFT_META_MAX] = {
 	[NFT_META_OIFKIND]	= "oifkind",
 	[NFT_META_BRI_IIFPVID]	 = "bri_iifpvid",
 	[NFT_META_BRI_IIFVPROTO] = "bri_iifvproto",
+	[NFT_META_TIME_NS]	= "time",
+	[NFT_META_TIME_DAY]	= "day",
+	[NFT_META_TIME_HOUR]	= "hour",
 };
 
 static const char *meta_key2str(uint8_t key)
-- 
2.17.1

