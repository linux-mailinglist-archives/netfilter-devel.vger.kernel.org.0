Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7E878B4
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Aug 2019 13:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406536AbfHILeX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Aug 2019 07:34:23 -0400
Received: from correo.us.es ([193.147.175.20]:49810 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfHILeX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:34:23 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 35E2EC2B04
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Aug 2019 13:34:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 26459D1929
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Aug 2019 13:34:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1BC2A1FFC9; Fri,  9 Aug 2019 13:34:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 21ABD461
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Aug 2019 13:34:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 09 Aug 2019 13:34:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (149.103.108.93.rev.vodafone.pt [93.108.103.149])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 8EF824102CB4
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Aug 2019 13:34:18 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] tests: shell: use-after-free from abort path
Date:   Fri,  9 Aug 2019 13:34:07 +0200
Message-Id: <20190809113407.2442-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190809113407.2442-1-pablo@netfilter.org>
References: <20190809113407.2442-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Rule that fails to be added while holding a bound set triggers
user-after-free from the abort path.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/transactions/0050rule_1 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 tests/shell/testcases/transactions/0050rule_1

diff --git a/tests/shell/testcases/transactions/0050rule_1 b/tests/shell/testcases/transactions/0050rule_1
new file mode 100755
index 000000000000..7c487e2e4710
--- /dev/null
+++ b/tests/shell/testcases/transactions/0050rule_1
@@ -0,0 +1,17 @@
+#!/bin/bash
+
+RULESET="table inet filter {
+	flowtable ft {
+		hook ingress priority 0; devices = { x, y, z };
+	}
+
+chain forward {
+	type filter hook forward priority 0; policy drop;
+
+	ip protocol { tcp, udp } counter flow add @ft
+	ip6 nexthdr { tcp, udp } counter flow add @ft
+	counter
+	}
+}"
+
+$NFT -f - <<< "$RULESET" >/dev/null
-- 
2.11.0

