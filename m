Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB9FDF3AC
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Oct 2019 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfJUQ4N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Oct 2019 12:56:13 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51726 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfJUQ4N (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:56:13 -0400
Received: from localhost ([::1]:36584 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iMayZ-0008G9-Oy; Mon, 21 Oct 2019 18:56:11 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] main: Fix for misleading error with negative chain priority
Date:   Mon, 21 Oct 2019 18:56:03 +0200
Message-Id: <20191021165603.32467-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

getopt_long() would try to parse the negative priority as an option and
return -1 as it is not known:

| # nft add chain x y { type filter hook input priority -30\; }
| nft: invalid option -- '3'

Fix this by prefixing optstring with a plus character. This instructs
getopt_long() to not collate arguments but just stop after the first
non-option, leaving the rest for manual handling. In fact, this is just
what nft desires: mixing options with nft syntax leads to confusive
command lines anyway.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/main.c                                           | 2 +-
 tests/shell/testcases/chains/0039negative_priority_0 | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100755 tests/shell/testcases/chains/0039negative_priority_0

diff --git a/src/main.c b/src/main.c
index f77d8a820a028..577850e54f68c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -45,7 +45,7 @@ enum opt_vals {
 	OPT_NUMERIC_TIME	= 't',
 	OPT_INVALID		= '?',
 };
-#define OPTSTRING	"hvcf:iI:jvnsNaeSupypt"
+#define OPTSTRING	"+hvcf:iI:jvnsNaeSupypt"
 
 static const struct option options[] = {
 	{
diff --git a/tests/shell/testcases/chains/0039negative_priority_0 b/tests/shell/testcases/chains/0039negative_priority_0
new file mode 100755
index 0000000000000..ba17b8cc19eda
--- /dev/null
+++ b/tests/shell/testcases/chains/0039negative_priority_0
@@ -0,0 +1,8 @@
+#!/bin/bash
+
+# Test parsing of negative priority values
+
+set -e
+
+$NFT add table t
+$NFT add chain t c { type filter hook input priority -30\; }
-- 
2.23.0

