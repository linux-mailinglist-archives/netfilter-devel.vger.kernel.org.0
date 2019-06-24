Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E781518BD
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Jun 2019 18:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfFXQgK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Jun 2019 12:36:10 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51408 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbfFXQgK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:36:10 -0400
Received: from localhost ([::1]:36266 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hfRwu-00035u-DF; Mon, 24 Jun 2019 18:36:08 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH v2] parser_bison: Accept arbitrary user-defined names by quoting
Date:   Mon, 24 Jun 2019 18:36:08 +0200
Message-Id: <20190624163608.17348-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Parser already allows to quote user-defined strings in some places to
avoid clashing with defined keywords, but not everywhere. Extend this
support further and add a test case for it.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Fix testcase, I forgot to commit adjustments done to it.

Note: This is a reduced variant of "src: Quote user-defined names" sent
      back in January. Discussion was not conclusive regarding whether
      to quote these names on output or not, but I assume allowing for
      users to specify them by adding quotes is a step forward without
      drawbacks.
---
 src/parser_bison.y                            |  3 ++-
 .../shell/testcases/nft-f/0018quoted-names_0  | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100755 tests/shell/testcases/nft-f/0018quoted-names_0

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 670e91f544c75..de8b097a4c222 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -1761,7 +1761,7 @@ flowtable_list_expr	:	flowtable_expr_member
 			|	flowtable_list_expr	COMMA	opt_newline
 			;
 
-flowtable_expr_member	:	STRING
+flowtable_expr_member	:	string
 			{
 				$$ = symbol_expr_alloc(&@$, SYMBOL_VALUE,
 						       current_scope(state),
@@ -1968,6 +1968,7 @@ chain_policy		:	ACCEPT		{ $$ = NF_ACCEPT; }
 			;
 
 identifier		:	STRING
+			|	QUOTED_STRING
 			;
 
 string			:	STRING
diff --git a/tests/shell/testcases/nft-f/0018quoted-names_0 b/tests/shell/testcases/nft-f/0018quoted-names_0
new file mode 100755
index 0000000000000..6526d66b8e8a1
--- /dev/null
+++ b/tests/shell/testcases/nft-f/0018quoted-names_0
@@ -0,0 +1,20 @@
+#!/bin/bash
+
+# Test if keywords are allowed as names if quoted
+
+set -e
+
+RULESET='
+table inet "day" {
+	chain "minute" {}
+	set "hour" { type inet_service; }
+	flowtable "second" { hook ingress priority 0; devices = { "lo" }; }
+	counter "table" { packets 0 bytes 0 }
+	quota "chain" { 10 bytes }
+}'
+
+$NFT -f - <<< "$RULESET"
+
+# XXX: not possible (yet)
+#OUTPUT=$($NFT list ruleset)
+#$NFT -f - <<< "$OUTPUT"
-- 
2.21.0

