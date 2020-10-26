Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB62992D3
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Oct 2020 17:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786372AbgJZQs3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Oct 2020 12:48:29 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:57888 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1781100AbgJZQqw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:46:52 -0400
X-Greylist: delayed 1037 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 12:46:51 EDT
Received: from localhost ([::1]:55698 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kX5NF-0006z5-No; Mon, 26 Oct 2020 17:29:33 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests: shell: Improve concurrent noflush restore test a bit
Date:   Mon, 26 Oct 2020 17:29:38 +0100
Message-Id: <20201026162938.18889-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The described issue happens only if chain FOO does not exist at program
start so flush the ruleset after each iteration to make sure this is the
case. Sadly the bug is still not 100% reproducible on my testing VM.

While being at it, add a paragraph describing what exact situation the
test is trying to provoke.

Fixes: dac904bdcd9a1 ("nft: Fix for concurrent noflush restore calls")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../ipt-restore/0016-concurrent-restores_0         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/iptables/tests/shell/testcases/ipt-restore/0016-concurrent-restores_0 b/iptables/tests/shell/testcases/ipt-restore/0016-concurrent-restores_0
index 53ec12fa368af..aa746ab458a3c 100755
--- a/iptables/tests/shell/testcases/ipt-restore/0016-concurrent-restores_0
+++ b/iptables/tests/shell/testcases/ipt-restore/0016-concurrent-restores_0
@@ -1,5 +1,14 @@
 #!/bin/bash
 
+# test for iptables-restore --noflush skipping an explicitly requested chain
+# flush because the chain did not exist when cache was fetched. In order to
+# expect for that chain to appear when refreshing the transaction (due to a
+# concurrent ruleset change), the chain flush job has to be present in batch
+# job list (although disabled at first).
+# The input line requesting chain flush is ':FOO - [0:0]'. RS1 and RS2 contents
+# are crafted to cause EBUSY when deleting the BAR* chains if FOO is not
+# flushed in the same transaction.
+
 set -e
 
 RS="*filter
@@ -45,7 +54,12 @@ RS2="$RS
 COMMIT
 "
 
+NORS="*filter
+COMMIT
+"
+
 for n in $(seq 1 10); do
+	$XT_MULTI iptables-restore <<< "$NORS"
 	$XT_MULTI iptables-restore --noflush -w <<< "$RS1" &
 	$XT_MULTI iptables-restore --noflush -w <<< "$RS2" &
 	wait -n
-- 
2.28.0

