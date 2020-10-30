Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347142A0ECB
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Oct 2020 20:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgJ3TjG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 30 Oct 2020 15:39:06 -0400
Received: from correo.us.es ([193.147.175.20]:37482 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgJ3Til (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:38:41 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 893BA1BFA87
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Oct 2020 20:38:39 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7B530DA704
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Oct 2020 20:38:39 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 70FF4DA73F; Fri, 30 Oct 2020 20:38:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 36C4EDA78A
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Oct 2020 20:38:37 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 30 Oct 2020 20:38:37 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 2173A42EF42B
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Oct 2020 20:38:37 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: exercise validate with nft -c
Date:   Fri, 30 Oct 2020 20:38:34 +0100
Message-Id: <20201030193834.26945-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Using oif in fib from prerouting is not support, make sure -c reports an
error.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/nft-f/0023check_1 | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100755 tests/shell/testcases/nft-f/0023check_1

diff --git a/tests/shell/testcases/nft-f/0023check_1 b/tests/shell/testcases/nft-f/0023check_1
new file mode 100755
index 000000000000..42793b6ec68c
--- /dev/null
+++ b/tests/shell/testcases/nft-f/0023check_1
@@ -0,0 +1,12 @@
+#!/bin/bash
+
+RULESET="table ip foo {
+	chain bar {
+		type filter hook prerouting priority 0;
+	}
+}"
+
+$NFT -f - <<< "$RULESET"
+
+$NFT -c add rule foo bar fib saddr . oif type local && exit 1
+exit 0
-- 
2.20.1

