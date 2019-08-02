Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177627ED72
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Aug 2019 09:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfHBH3h (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Aug 2019 03:29:37 -0400
Received: from vxsys-smtpclusterma-03.srv.cat ([46.16.60.198]:36209 "EHLO
        vxsys-smtpclusterma-03.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730790AbfHBH3g (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:29:36 -0400
Received: from bubu.das-nano.com (242.red-83-48-67.staticip.rima-tde.net [83.48.67.242])
        by vxsys-smtpclusterma-03.srv.cat (Postfix) with ESMTPA id BF9B224330
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Aug 2019 09:29:33 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH] meta: Introduce new conditions 'time', 'day' and 'hour'
Date:   Fri,  2 Aug 2019 09:29:23 +0200
Message-Id: <20190802072923.21578-1-a@juaristi.eus>
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
index 1bf4346..0a6bc7f 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -794,6 +794,9 @@ enum nft_exthdr_attributes {
  * @NFT_META_SECPATH: boolean, secpath_exists (!!skb->sp)
  * @NFT_META_IIFKIND: packet input interface kind name (dev->rtnl_link_ops->kind)
  * @NFT_META_OIFKIND: packet output interface kind name (dev->rtnl_link_ops->kind)
+ * @NFT_META_TIME: a UNIX timestamp
+ * @NFT_META_TIME_DAY: day of week
+ * @NFT_META_TIME_HOUR: hour of day
  */
 enum nft_meta_keys {
 	NFT_META_LEN,
@@ -824,6 +827,9 @@ enum nft_meta_keys {
 	NFT_META_SECPATH,
 	NFT_META_IIFKIND,
 	NFT_META_OIFKIND,
+	NFT_META_TIME,
+	NFT_META_TIME_DAY,
+	NFT_META_TIME_HOUR,
 };
 
 /**
diff --git a/src/expr/meta.c b/src/expr/meta.c
index f1984f6..c2ac72e 100644
--- a/src/expr/meta.c
+++ b/src/expr/meta.c
@@ -22,7 +22,7 @@
 #include <libnftnl/rule.h>
 
 #ifndef NFT_META_MAX
-#define NFT_META_MAX (NFT_META_OIFKIND + 1)
+#define NFT_META_MAX (NFT_META_TIME_HOUR + 1)
 #endif
 
 struct nftnl_expr_meta {
@@ -161,6 +161,9 @@ static const char *meta_key2str_array[NFT_META_MAX] = {
 	[NFT_META_SECPATH]	= "secpath",
 	[NFT_META_IIFKIND]	= "iifkind",
 	[NFT_META_OIFKIND]	= "oifkind",
+	[NFT_META_TIME]		= "time",
+	[NFT_META_TIME_DAY]	= "day",
+	[NFT_META_TIME_HOUR]	= "hour",
 };
 
 static const char *meta_key2str(uint8_t key)
-- 
2.17.1

