Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1A7F32C6
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Nov 2023 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjKUPyA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Nov 2023 10:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjKUPx7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:53:59 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AFEE185
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Nov 2023 07:53:48 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: flush connlimit sets
Date:   Tue, 21 Nov 2023 16:53:43 +0100
Message-Id: <20231121155343.393407-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Restored elements via set declaration are removed almost inmediately by
GC, this is causing spurious failures in test runs.

Flush sets to ensure dump is always consistent. Still, cover that
restoring a set with connlimit elements do not.

Fixes: 95d348d55a9e ("tests: shell: extend connlimit test")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/sets/0062set_connlimit_0           | 3 +++
 tests/shell/testcases/sets/dumps/0062set_connlimit_0.nft | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/shell/testcases/sets/0062set_connlimit_0 b/tests/shell/testcases/sets/0062set_connlimit_0
index 48d589fe68cc..dab1da061795 100755
--- a/tests/shell/testcases/sets/0062set_connlimit_0
+++ b/tests/shell/testcases/sets/0062set_connlimit_0
@@ -24,3 +24,6 @@ RULESET="table ip x {
 }"
 
 $NFT -f - <<< $RULESET
+
+$NFT flush set ip x est-connlimit
+$NFT flush set ip x new-connlimit
diff --git a/tests/shell/testcases/sets/dumps/0062set_connlimit_0.nft b/tests/shell/testcases/sets/dumps/0062set_connlimit_0.nft
index 080d675c3ac7..13bbb953d8c2 100644
--- a/tests/shell/testcases/sets/dumps/0062set_connlimit_0.nft
+++ b/tests/shell/testcases/sets/dumps/0062set_connlimit_0.nft
@@ -3,7 +3,6 @@ table ip x {
 		type ipv4_addr
 		size 65535
 		flags dynamic
-		elements = { 84.245.120.167 ct count over 20 }
 	}
 
 	set new-connlimit {
@@ -11,6 +10,5 @@ table ip x {
 		size 65535
 		flags dynamic
 		ct count over 20
-		elements = { 84.245.120.167 ct count over 20 }
 	}
 }
-- 
2.30.2

