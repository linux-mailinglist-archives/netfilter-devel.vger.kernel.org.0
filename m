Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D78CC52
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHNHMO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 03:12:14 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:41334 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfHNHMO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:12:14 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 8A36B4191E;
        Wed, 14 Aug 2019 15:12:07 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl] expr: meta: Make NFT_META_BRI_IIF{VPROTO,PVID} known
Date:   Wed, 14 Aug 2019 15:12:07 +0800
Message-Id: <1565766727-25830-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVIT0xLS0tKSUlLTEtISllXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6Qyo*Vjg#ITkPKhQTHkwo
        FCgwFB5VSlVKTk1OTE1NTElMTElKVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpPTU03Bg++
X-HM-Tid: 0a6c8ef837b82086kuqy8a36b4191e
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This makes debug output to support bri_iifvproto/pvid.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 src/expr/meta.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/expr/meta.c b/src/expr/meta.c
index f1984f6..73f6efa 100644
--- a/src/expr/meta.c
+++ b/src/expr/meta.c
@@ -22,7 +22,7 @@
 #include <libnftnl/rule.h>
 
 #ifndef NFT_META_MAX
-#define NFT_META_MAX (NFT_META_OIFKIND + 1)
+#define NFT_META_MAX (NFT_META_BRI_IIFVPROTO + 1)
 #endif
 
 struct nftnl_expr_meta {
@@ -161,6 +161,8 @@ static const char *meta_key2str_array[NFT_META_MAX] = {
 	[NFT_META_SECPATH]	= "secpath",
 	[NFT_META_IIFKIND]	= "iifkind",
 	[NFT_META_OIFKIND]	= "oifkind",
+	[NFT_META_BRI_IIFPVID]	 = "bri_iifpvid",
+	[NFT_META_BRI_IIFVPROTO] = "bri_iifvproto",
 };
 
 static const char *meta_key2str(uint8_t key)
-- 
2.15.1

