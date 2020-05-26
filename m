Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF77919AF18
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Apr 2020 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733147AbgDAPwF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Apr 2020 11:52:05 -0400
Received: from correo.us.es ([193.147.175.20]:42658 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733088AbgDAPwE (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:52:04 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A07472EFEA3
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Apr 2020 17:52:02 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 919E6132C8D
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Apr 2020 17:52:02 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8754F132C89; Wed,  1 Apr 2020 17:52:02 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2EECF132C8F
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Apr 2020 17:52:00 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 01 Apr 2020 17:52:00 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 19C4F4301DE0
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Apr 2020 17:52:00 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: add typeof with concatenations
Date:   Wed,  1 Apr 2020 17:51:57 +0200
Message-Id: <20200401155157.195806-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a test to cover typeof with concatenations.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/sets/0045typeof_sets_0           | 14 ++++++++++++++
 tests/shell/testcases/sets/dumps/0045typeof_sets_0.nft |  7 +++++++
 2 files changed, 21 insertions(+)
 create mode 100755 tests/shell/testcases/sets/0045typeof_sets_0
 create mode 100644 tests/shell/testcases/sets/dumps/0045typeof_sets_0.nft

diff --git a/tests/shell/testcases/sets/0045typeof_sets_0 b/tests/shell/testcases/sets/0045typeof_sets_0
new file mode 100755
index 000000000000..3cf8d0b0c22d
--- /dev/null
+++ b/tests/shell/testcases/sets/0045typeof_sets_0
@@ -0,0 +1,14 @@
+#!/bin/bash
+
+EXPECTED="table ip foo {
+        set whitelist {
+                typeof ip saddr . ip daddr . meta mark
+                elements = { 192.168.10.35 . 192.168.10.11 . 0x00000010,
+                             192.168.10.101 . 192.168.10.12 . 0x00000020,
+		}
+	}
+}
+"
+
+set -e
+$NFT -f - <<< $EXPECTED
diff --git a/tests/shell/testcases/sets/dumps/0045typeof_sets_0.nft b/tests/shell/testcases/sets/dumps/0045typeof_sets_0.nft
new file mode 100644
index 000000000000..68c900a72ac6
--- /dev/null
+++ b/tests/shell/testcases/sets/dumps/0045typeof_sets_0.nft
@@ -0,0 +1,7 @@
+table ip foo {
+	set whitelist {
+		typeof ip saddr . ip daddr . meta mark
+		elements = { 192.168.10.35 . 192.168.10.11 . 0x00000010,
+			     192.168.10.101 . 192.168.10.12 . 0x00000020 }
+	}
+}
-- 
2.11.0

