Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76B97B0743
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Sep 2023 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjI0OsN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Sep 2023 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjI0OsL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:48:11 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 384A4F4
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Sep 2023 07:48:10 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: fix spurious errors in sets/0036add_set_element_expiration_0
Date:   Wed, 27 Sep 2023 16:48:03 +0200
Message-Id: <20230927144803.138869-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add seconds as expiration, otherwise 14m59 reports 14m in minute
granularity, this ensures suficient time in a very slow environment with
debugging instrumentation.

Fixes: adf38fd84257 ("tests: shell: use minutes granularity in sets/0036add_set_element_expiration_0")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
I still see this failing occasionally due to timing issues, fix it.

 tests/shell/testcases/sets/0036add_set_element_expiration_0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/shell/testcases/sets/0036add_set_element_expiration_0 b/tests/shell/testcases/sets/0036add_set_element_expiration_0
index 12f10074409f..a50ac91d43a6 100755
--- a/tests/shell/testcases/sets/0036add_set_element_expiration_0
+++ b/tests/shell/testcases/sets/0036add_set_element_expiration_0
@@ -8,7 +8,7 @@ drop_seconds() {
 
 RULESET="add table ip x
 add set ip x y { type ipv4_addr; flags dynamic,timeout; } 
-add element ip x y { 1.1.1.1 timeout 30m expires 15m }"
+add element ip x y { 1.1.1.1 timeout 30m expires 15m59s }"
 
 test_output=$($NFT -e -f - <<< "$RULESET" 2>&1 | grep -v '# new generation' | drop_seconds)
 
-- 
2.30.2

