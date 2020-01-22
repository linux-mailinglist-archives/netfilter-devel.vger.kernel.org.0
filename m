Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6243D145E59
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jan 2020 23:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAVWFe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Jan 2020 17:05:34 -0500
Received: from correo.us.es ([193.147.175.20]:40476 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVWFe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:05:34 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7ADC415C112
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jan 2020 23:05:32 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6C79FDA70F
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jan 2020 23:05:32 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 62346DA70E; Wed, 22 Jan 2020 23:05:32 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4B103DA705
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jan 2020 23:05:30 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 22 Jan 2020 23:05:30 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 2E75342EF9E0
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jan 2020 23:05:30 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] tests: shell: set lookup and set update
Date:   Wed, 22 Jan 2020 23:05:25 +0100
Message-Id: <20200122220526.260796-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

A simple test to cover set lookup and update in one rule.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/sets/0042update_set_0 | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tests/shell/testcases/sets/0042update_set_0

diff --git a/tests/shell/testcases/sets/0042update_set_0 b/tests/shell/testcases/sets/0042update_set_0
new file mode 100755
index 000000000000..a8e9e05f0f2e
--- /dev/null
+++ b/tests/shell/testcases/sets/0042update_set_0
@@ -0,0 +1,21 @@
+#!/bin/bash
+
+set -e
+
+RULESET="table ip t {
+        set set1 {
+                type ether_addr
+        }
+
+        set set2 {
+                type ether_addr
+                size 65535
+                flags dynamic
+        }
+
+        chain c {
+                ether daddr @set1 add @set2 { ether daddr counter }
+        }
+}"
+
+$NFT -f - <<< "$RULESET" || { echo "can't apply basic ruleset"; exit 1; }
-- 
2.11.0

