Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349E600F39
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Oct 2022 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJQMdM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Oct 2022 08:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJQMdM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:33:12 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 770544BA7A
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Oct 2022 05:33:11 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: deletion from interval concatenation
Date:   Mon, 17 Oct 2022 14:33:06 +0200
Message-Id: <20221017123306.791645-1-pablo@netfilter.org>
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

Deleting item from concatenated set stops working at least in 5.15.64.
Add test to cover this use case.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1638
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/sets/concat_interval_0   | 18 ++++++++++++++++++
 .../testcases/sets/dumps/concat_interval_0.nft |  7 +++++++
 2 files changed, 25 insertions(+)
 create mode 100755 tests/shell/testcases/sets/concat_interval_0
 create mode 100644 tests/shell/testcases/sets/dumps/concat_interval_0.nft

diff --git a/tests/shell/testcases/sets/concat_interval_0 b/tests/shell/testcases/sets/concat_interval_0
new file mode 100755
index 000000000000..3812a94d18c8
--- /dev/null
+++ b/tests/shell/testcases/sets/concat_interval_0
@@ -0,0 +1,18 @@
+#!/bin/bash
+
+set -e
+
+RULESET="table ip t {
+	set s {
+		type ipv4_addr . inet_proto . inet_service
+		flags interval
+		counter
+		elements = { 1.0.0.1 . udp . 53 }
+	}
+}"
+
+$NFT -f - <<< $RULESET
+
+$NFT delete element t s { 1.0.0.1 . udp . 53}
+
+exit 0
diff --git a/tests/shell/testcases/sets/dumps/concat_interval_0.nft b/tests/shell/testcases/sets/dumps/concat_interval_0.nft
new file mode 100644
index 000000000000..875ec1d5c6a0
--- /dev/null
+++ b/tests/shell/testcases/sets/dumps/concat_interval_0.nft
@@ -0,0 +1,7 @@
+table ip t {
+	set s {
+		type ipv4_addr . inet_proto . inet_service
+		flags interval
+		counter
+	}
+}
-- 
2.30.2

