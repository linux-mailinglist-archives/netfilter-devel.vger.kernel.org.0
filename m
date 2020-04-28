Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7579C1BC101
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2020 16:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgD1OSC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Apr 2020 10:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgD1OSC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:18:02 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F84C03C1AB
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 07:18:02 -0700 (PDT)
Received: from localhost ([::1]:38938 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jTR3g-0001dz-H4; Tue, 28 Apr 2020 16:18:00 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests: shell: Add test for nfbz#1391
Date:   Tue, 28 Apr 2020 16:17:51 +0200
Message-Id: <20200428141751.7707-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Problem is fixed since commit c550c81fd373e ("nft: cache: Fix
nft_release_cache() under stress"), looks like another case of
use-after-free.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../tests/shell/testcases/ipt-restore/0013-test-mode_0     | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100755 iptables/tests/shell/testcases/ipt-restore/0013-test-mode_0

diff --git a/iptables/tests/shell/testcases/ipt-restore/0013-test-mode_0 b/iptables/tests/shell/testcases/ipt-restore/0013-test-mode_0
new file mode 100755
index 0000000000000..65c3b9a184b3e
--- /dev/null
+++ b/iptables/tests/shell/testcases/ipt-restore/0013-test-mode_0
@@ -0,0 +1,7 @@
+#!/bin/bash
+
+set -e
+
+# segfault with --test reported in nfbz#1391
+
+printf '%s\nCOMMIT\n' '*nat' '*raw' '*filter' | $XT_MULTI iptables-restore --test
-- 
2.25.1

