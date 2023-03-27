Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEAB6CA83B
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Mar 2023 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjC0Ou6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Mar 2023 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjC0Ou4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:50:56 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36728FE
        for <netfilter-devel@vger.kernel.org>; Mon, 27 Mar 2023 07:50:50 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] intervals: use expression location when translating to intervals
Date:   Mon, 27 Mar 2023 16:50:45 +0200
Message-Id: <20230327145045.33797-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Otherwise, internal location reports:

 # nft -f ruleset.nft
 internal:0:0-0: Error: Could not process rule: File exists

after this patch:

 # nft -f ruleset.nft
 ruleset.nft:402:1-16: Error: Could not process rule: File exists
 1.2.3.0/30,
 ^^^^^^^^^^^

Fixes: 81e36530fcac ("src: replace interval segment tree overlap and automerge")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/intervals.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/intervals.c b/src/intervals.c
index 95e25cf09662..d79c52c58710 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -709,9 +709,9 @@ int set_to_intervals(const struct set *set, struct expr *init, bool add)
 			if (set->key->byteorder == BYTEORDER_HOST_ENDIAN)
 				mpz_switch_byteorder(expr->value, set->key->len / BITS_PER_BYTE);
 
-			newelem = set_elem_expr_alloc(&internal_location, expr);
+			newelem = set_elem_expr_alloc(&expr->location, expr);
 			if (i->etype == EXPR_MAPPING) {
-				newelem = mapping_expr_alloc(&internal_location,
+				newelem = mapping_expr_alloc(&expr->location,
 							     newelem,
 							     expr_get(i->right));
 			}
-- 
2.30.2

