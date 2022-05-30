Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE83D53867F
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 May 2022 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbiE3RCe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 May 2022 13:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiE3RCe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 May 2022 13:02:34 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5566E5EBC7
        for <netfilter-devel@vger.kernel.org>; Mon, 30 May 2022 10:02:33 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] intervals: fix compilation --with-mini-gmp
Date:   Mon, 30 May 2022 19:02:30 +0200
Message-Id: <20220530170230.183230-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use pr_gmp_debug() instead to compile with minigmp.

intervals.c: In function ‘set_delete’:
intervals.c:489:25: warning: implicit declaration of function ‘gmp_printf’; did you mean ‘gmp_vfprintf’? [-Wimplicit-function-declaration]
  489 |                         gmp_printf("remove: [%Zx-%Zx]\n",
      |                         ^~~~~~~~~~
      |                         gmp_vfprintf

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/intervals.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/intervals.c b/src/intervals.c
index e61adc769c41..bc414d6c8797 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -486,14 +486,14 @@ int set_delete(struct list_head *msgs, struct cmd *cmd, struct set *set,
 
 	if (debug_mask & NFT_DEBUG_SEGTREE) {
 		list_for_each_entry(i, &init->expressions, list)
-			gmp_printf("remove: [%Zx-%Zx]\n",
-				   i->key->left->value, i->key->right->value);
+			pr_gmp_debug("remove: [%Zx-%Zx]\n",
+				     i->key->left->value, i->key->right->value);
 		list_for_each_entry(i, &add->expressions, list)
-			gmp_printf("add: [%Zx-%Zx]\n",
-				   i->key->left->value, i->key->right->value);
+			pr_gmp_debug("add: [%Zx-%Zx]\n",
+				     i->key->left->value, i->key->right->value);
 		list_for_each_entry(i, &existing_set->init->expressions, list)
-			gmp_printf("existing: [%Zx-%Zx]\n",
-				   i->key->left->value, i->key->right->value);
+			pr_gmp_debug("existing: [%Zx-%Zx]\n",
+				     i->key->left->value, i->key->right->value);
 	}
 
 	if (list_empty(&add->expressions)) {
-- 
2.30.2

