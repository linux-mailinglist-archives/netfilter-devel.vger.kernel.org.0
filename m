Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F2C1B25EC
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2020 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgDUMZz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Apr 2020 08:25:55 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:44012 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbgDUMZy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:25:54 -0400
Received: from localhost ([::1]:47326 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jQryK-0000KW-AS; Tue, 21 Apr 2020 14:25:52 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 2/3] tests: shell: Extend ipt-restore/0004-restore-race_0
Date:   Tue, 21 Apr 2020 14:25:32 +0200
Message-Id: <20200421122533.29169-2-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200421122533.29169-1-phil@nwl.cc>
References: <20200421122533.29169-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a second table to dump/restore. This triggers failures after
reverting c550c81fd373e ("nft: cache: Fix nft_release_cache() under
stress"), hence acts as a reproducer for the bug fixed by that commit as
well.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../tests/shell/testcases/ipt-restore/0004-restore-race_0    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0 b/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0
index 9fc50615b8926..a7fae41df0e74 100755
--- a/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0
+++ b/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0
@@ -45,8 +45,7 @@ get_target()
 
 make_dummy_rules()
 {
-
-	echo "*filter"
+	echo "*${1:-filter}"
 	echo ":INPUT ACCEPT [0:0]"
 	echo ":FORWARD ACCEPT [0:0]"
 	echo ":OUTPUT ACCEPT [0:0]"
@@ -74,7 +73,7 @@ make_dummy_rules()
 tmpfile=$(mktemp) || exit 1
 dumpfile=$(mktemp) || exit 1
 
-make_dummy_rules > $dumpfile
+(make_dummy_rules; make_dummy_rules security) > $dumpfile
 $XT_MULTI iptables-restore -w < $dumpfile
 LINES1=$(wc -l < $dumpfile)
 $XT_MULTI iptables-save | grep -v '^#' > $dumpfile
-- 
2.25.1

