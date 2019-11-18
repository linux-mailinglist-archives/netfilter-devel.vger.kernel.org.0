Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77E510078F
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Nov 2019 15:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKROlA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Nov 2019 09:41:00 -0500
Received: from correo.us.es ([193.147.175.20]:50752 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbfKROk7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:40:59 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B337B11ADC5
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Nov 2019 15:40:55 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A56FADA801
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Nov 2019 15:40:55 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 14C59A7EC5; Mon, 18 Nov 2019 15:40:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EF9D7B8001;
        Mon, 18 Nov 2019 15:40:51 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 18 Nov 2019 15:40:51 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id C0C3F42EE38E;
        Mon, 18 Nov 2019 15:40:51 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft] tests: shell: set reference from variable definition
Date:   Mon, 18 Nov 2019 15:40:50 +0100
Message-Id: <20191118144050.116043-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Allow to define variable using set reference, eg.

	define x = @z

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/nft-f/0022variables_0 | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tests/shell/testcases/nft-f/0022variables_0

diff --git a/tests/shell/testcases/nft-f/0022variables_0 b/tests/shell/testcases/nft-f/0022variables_0
new file mode 100755
index 000000000000..ee17a6272aa3
--- /dev/null
+++ b/tests/shell/testcases/nft-f/0022variables_0
@@ -0,0 +1,21 @@
+#!/bin/bash
+
+set -e
+
+RULESET="define test1 = @y
+
+table ip x {
+	set y {
+		type ipv4_addr
+		flags dynamic,timeout
+	}
+
+	chain z {
+		type filter hook input priority filter; policy accept;
+		add \$test1 { ip saddr }
+		update \$test1 { ip saddr timeout 30s }
+		ip saddr \$test1
+	}
+}"
+
+$NFT -f - <<< "$RULESET"
-- 
2.11.0

