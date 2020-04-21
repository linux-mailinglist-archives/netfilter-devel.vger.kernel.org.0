Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF0B1B25EB
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2020 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgDUMZt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Apr 2020 08:25:49 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:44004 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbgDUMZt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:25:49 -0400
Received: from localhost ([::1]:47318 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jQryF-0000Je-0l; Tue, 21 Apr 2020 14:25:47 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 3/3] tests: shell: Test -F in dump files
Date:   Tue, 21 Apr 2020 14:25:33 +0200
Message-Id: <20200421122533.29169-3-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200421122533.29169-1-phil@nwl.cc>
References: <20200421122533.29169-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

While not really useful, iptables-nft-restore shouldn't segfault either.
This tests the problem described in nfbz#1407.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../tests/shell/testcases/ipt-restore/0012-dash-F_0  | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100755 iptables/tests/shell/testcases/ipt-restore/0012-dash-F_0

diff --git a/iptables/tests/shell/testcases/ipt-restore/0012-dash-F_0 b/iptables/tests/shell/testcases/ipt-restore/0012-dash-F_0
new file mode 100755
index 0000000000000..fd82afa1bc8ce
--- /dev/null
+++ b/iptables/tests/shell/testcases/ipt-restore/0012-dash-F_0
@@ -0,0 +1,12 @@
+#!/bin/bash -e
+
+# make sure -F lines don't cause segfaults
+
+RULESET='*nat
+-F PREROUTING
+-A PREROUTING -j ACCEPT
+-F PREROUTING
+COMMIT'
+
+echo -e "$RULESET" | $XT_MULTI iptables-restore
+echo -e "$RULESET" | $XT_MULTI iptables-restore -n
-- 
2.25.1

