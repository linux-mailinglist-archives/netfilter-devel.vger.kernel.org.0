Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D305879B3
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Aug 2022 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbiHBJMi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Aug 2022 05:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiHBJL6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:11:58 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C02A11EEC7
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Aug 2022 02:11:47 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2] parser_json: fix device parsing in netdev family
Date:   Tue,  2 Aug 2022 11:11:42 +0200
Message-Id: <20220802091142.164272-1-pablo@netfilter.org>
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

json_unpack() function is not designed to take a pre-allocated buffer.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1612
Fixes: 3fdc7541fba0 ("src: add multidevice support for netdev chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: skip initialization and add test.

 src/parser_json.c                 |  3 +--
 tests/shell/testcases/json/netdev | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100755 tests/shell/testcases/json/netdev

diff --git a/src/parser_json.c b/src/parser_json.c
index fb401009a499..9e93927a9a2b 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -2780,8 +2780,7 @@ static struct cmd *json_parse_cmd_add_chain(struct json_ctx *ctx, json_t *root,
 	struct handle h = {
 		.table.location = *int_loc,
 	};
-	const char *family = "", *policy = "", *type, *hookstr;
-	const char name[IFNAMSIZ];
+	const char *family = "", *policy = "", *type, *hookstr, *name;
 	struct chain *chain;
 	int prio;
 
diff --git a/tests/shell/testcases/json/netdev b/tests/shell/testcases/json/netdev
new file mode 100755
index 000000000000..2cbc7e1f266c
--- /dev/null
+++ b/tests/shell/testcases/json/netdev
@@ -0,0 +1,17 @@
+#!/bin/bash
+
+ip link add d0 type dummy || {
+        echo "Skipping, no dummy interface available"
+        exit 0
+}
+trap "ip link del d0" EXIT
+
+$NFT flush ruleset
+$NFT add table inet test
+$NFT add chain inet test c
+
+$NFT flush ruleset
+
+RULESET='{"nftables":[{"flush":{"ruleset":null}},{"add":{"table":{"family":"netdev","name":"test_table"}}},{"add":{"chain":{"family":"netdev","table":"test_table","name":"test_chain","type":"filter","hook":"ingress","prio":0,"dev":"d0","policy":"accept"}}}]}'
+
+$NFT -j -f - <<< $RULESET
-- 
2.30.2

