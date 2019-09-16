Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA05B3F47
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Sep 2019 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfIPQur (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Sep 2019 12:50:47 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51190 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbfIPQur (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:50:47 -0400
Received: from localhost ([::1]:36048 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i9uD8-0003p6-85; Mon, 16 Sep 2019 18:50:46 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 02/14] tests/shell: Speed up ipt-restore/0004-restore-race_0
Date:   Mon, 16 Sep 2019 18:49:48 +0200
Message-Id: <20190916165000.18217-3-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916165000.18217-1-phil@nwl.cc>
References: <20190916165000.18217-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This test tended to cause quite excessive load on my system, sometimes
taking longer than all other tests combined. Even with the reduced
numbers, it still fails reliably after reverting commit 58d7de0181f61
("xtables: handle concurrent ruleset modifications").

Fixes: 4000b4cf2ea38 ("tests: add test script for race-free restore")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../tests/shell/testcases/ipt-restore/0004-restore-race_0     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0 b/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0
index a92d18dcee058..96a5e66d0ab81 100755
--- a/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0
+++ b/iptables/tests/shell/testcases/ipt-restore/0004-restore-race_0
@@ -24,7 +24,7 @@ clean_tempfile()
 
 trap clean_tempfile EXIT
 
-ENTRY_NUM=$((RANDOM%100))
+ENTRY_NUM=$((RANDOM%10))
 UCHAIN_NUM=$((RANDOM%10))
 
 get_target()
@@ -87,7 +87,7 @@ fi
 
 case "$XT_MULTI" in
 */xtables-nft-multi)
-	attempts=$((RANDOM%200))
+	attempts=$((RANDOM%10))
 	attempts=$((attempts+1))
 	;;
 *)
-- 
2.23.0

