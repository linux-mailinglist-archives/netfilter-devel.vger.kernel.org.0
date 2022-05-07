Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C082051EA5C
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 May 2022 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbiEGVd4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 May 2022 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiEGVdz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 May 2022 17:33:55 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DC7CBC32
        for <netfilter-devel@vger.kernel.org>; Sat,  7 May 2022 14:30:07 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] intervals: deletion should adjust range not yet in the kernel
Date:   Sat,  7 May 2022 23:30:02 +0200
Message-Id: <20220507213002.15209-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Do not remove the range if it does not exists yet in the kernel, adjust it
instead.  Uncovered by use-after-free error.

==276702==ERROR: AddressSanitizer: heap-use-after-free on address 0x60d00190663c at pc 0x7ff310ab526f bp 0x7fffeb76f750 sp 0x7fffeb76f748 READ of size 4 at 0x60d00190663c thread T0
    #0 0x7ff310ab526e in __adjust_elem_right .../nftables/src/intervals.c:300
    #1 0x7ff310ab59a7 in adjust_elem_right .../nftables/src/intervals.c:311
    #2 0x7ff310ab6daf in setelem_adjust .../nftables/src/intervals.c:354
    #3 0x7ff310ab783a in setelem_delete .../nftables/src/intervals.c:411
    #4 0x7ff310ab80e6 in __set_delete .../nftables/src/intervals.c:451

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/intervals.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/intervals.c b/src/intervals.c
index 85ec59eda36a..e61adc769c41 100644
--- a/src/intervals.c
+++ b/src/intervals.c
@@ -270,9 +270,6 @@ static void remove_elem(struct expr *prev, struct set *set, struct expr *purge)
 	if (prev->flags & EXPR_F_KERNEL) {
 		clone = expr_clone(prev);
 		list_move_tail(&clone->list, &purge->expressions);
-	} else {
-		list_del(&prev->list);
-		expr_free(prev);
 	}
 }
 
-- 
2.30.2

