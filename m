Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E490C97620
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfHUJ06 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 05:26:58 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:43790 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfHUJ06 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:26:58 -0400
Received: from localhost ([::1]:56880 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i0MtM-00056W-LN; Wed, 21 Aug 2019 11:26:56 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 02/14] nft: Get rid of NFT_COMPAT_EXPR_MAX define
Date:   Wed, 21 Aug 2019 11:25:50 +0200
Message-Id: <20190821092602.16292-3-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821092602.16292-1-phil@nwl.cc>
References: <20190821092602.16292-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead simply use ARRAY_SIZE() macro to not overstep supported_exprs
array.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index ae3740be6bed5..458dededaca29 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -3332,9 +3332,7 @@ uint32_t nft_invflags2cmp(uint32_t invflags, uint32_t flag)
 	return NFT_CMP_EQ;
 }
 
-#define NFT_COMPAT_EXPR_MAX     8
-
-static const char *supported_exprs[NFT_COMPAT_EXPR_MAX] = {
+static const char *supported_exprs[] = {
 	"match",
 	"target",
 	"payload",
@@ -3351,7 +3349,7 @@ static int nft_is_expr_compatible(struct nftnl_expr *expr, void *data)
 	const char *name = nftnl_expr_get_str(expr, NFTNL_EXPR_NAME);
 	int i;
 
-	for (i = 0; i < NFT_COMPAT_EXPR_MAX; i++) {
+	for (i = 0; i < ARRAY_SIZE(supported_exprs); i++) {
 		if (strcmp(supported_exprs[i], name) == 0)
 			return 0;
 	}
-- 
2.22.0

