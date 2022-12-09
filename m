Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400D0648247
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Dec 2022 13:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLIMQz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Dec 2022 07:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIMQu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:16:50 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2107543848
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Dec 2022 04:16:48 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/3] netlink: statify __netlink_gen_data()
Date:   Fri,  9 Dec 2022 13:16:43 +0100
Message-Id: <20221209121645.903831-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/netlink.c b/src/netlink.c
index 2ede25b9ce9d..db92f3506503 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -97,8 +97,8 @@ struct nftnl_expr *alloc_nft_expr(const char *name)
 	return nle;
 }
 
-void __netlink_gen_data(const struct expr *expr,
-			struct nft_data_linearize *data, bool expand);
+static void __netlink_gen_data(const struct expr *expr,
+			       struct nft_data_linearize *data, bool expand);
 
 struct nftnl_set_elem *alloc_nftnl_setelem(const struct expr *set,
 					   const struct expr *expr)
@@ -430,8 +430,8 @@ static void netlink_gen_prefix(const struct expr *expr,
 	nld->len = len;
 }
 
-void __netlink_gen_data(const struct expr *expr,
-			struct nft_data_linearize *data, bool expand)
+static void __netlink_gen_data(const struct expr *expr,
+			       struct nft_data_linearize *data, bool expand)
 {
 	switch (expr->etype) {
 	case EXPR_VALUE:
-- 
2.30.2

