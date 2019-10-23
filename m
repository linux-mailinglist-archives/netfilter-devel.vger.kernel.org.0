Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4239DE195E
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Oct 2019 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfJWLwH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Oct 2019 07:52:07 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:56004 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfJWLwH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:52:07 -0400
Received: from localhost ([::1]:40860 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iNFBN-0003FW-BB; Wed, 23 Oct 2019 13:52:05 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] Revert "main: Fix for misleading error with negative chain priority"
Date:   Wed, 23 Oct 2019 13:51:56 +0200
Message-Id: <20191023115156.9507-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This reverts commit 9fc71bc6b602c8706d1214e0100bcd7638c257e3.

Given that this change breaks typical commands like
'nft list ruleset -a' while on the other hand escaping of semicolons and
(depending on shell) curly braces is still required, decision was made
to not go with this solution.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/main.c                                           | 2 +-
 tests/shell/testcases/chains/0039negative_priority_0 | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)
 delete mode 100755 tests/shell/testcases/chains/0039negative_priority_0

diff --git a/src/main.c b/src/main.c
index 577850e54f68c..f77d8a820a028 100644
--- a/src/main.c
+++ b/src/main.c
@@ -45,7 +45,7 @@ enum opt_vals {
 	OPT_NUMERIC_TIME	= 't',
 	OPT_INVALID		= '?',
 };
-#define OPTSTRING	"+hvcf:iI:jvnsNaeSupypt"
+#define OPTSTRING	"hvcf:iI:jvnsNaeSupypt"
 
 static const struct option options[] = {
 	{
diff --git a/tests/shell/testcases/chains/0039negative_priority_0 b/tests/shell/testcases/chains/0039negative_priority_0
deleted file mode 100755
index ba17b8cc19eda..0000000000000
--- a/tests/shell/testcases/chains/0039negative_priority_0
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/bash
-
-# Test parsing of negative priority values
-
-set -e
-
-$NFT add table t
-$NFT add chain t c { type filter hook input priority -30\; }
-- 
2.23.0

