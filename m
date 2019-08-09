Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0377987A74
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Aug 2019 14:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406518AbfHIMtY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Aug 2019 08:49:24 -0400
Received: from correo.us.es ([193.147.175.20]:35242 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfHIMtY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:49:24 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A4168F2681
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Aug 2019 14:49:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 94815DA704
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Aug 2019 14:49:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8A261DA730; Fri,  9 Aug 2019 14:49:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 66CBEDA704
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Aug 2019 14:49:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 09 Aug 2019 14:49:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (149.103.108.93.rev.vodafone.pt [93.108.103.149])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id D71534265A2F
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Aug 2019 14:49:18 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2] tests: shell: use-after-free from abort path
Date:   Fri,  9 Aug 2019 14:49:14 +0200
Message-Id: <20190809124914.2005-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Rule that fails to be added while holding a bound set triggers
user-after-free from the abort path.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: This one reproduces the crash here.

 tests/shell/testcases/transactions/0050rule_1 | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 tests/shell/testcases/transactions/0050rule_1

diff --git a/tests/shell/testcases/transactions/0050rule_1 b/tests/shell/testcases/transactions/0050rule_1
new file mode 100755
index 000000000000..89e5f42fc9f4
--- /dev/null
+++ b/tests/shell/testcases/transactions/0050rule_1
@@ -0,0 +1,19 @@
+#!/bin/bash
+
+set -e
+
+RULESET="table inet filter {
+	flowtable ftable {
+		hook ingress priority 0; devices = { eno1, eno0, x };
+	}
+
+chain forward {
+	type filter hook forward priority 0; policy drop;
+
+	ip protocol { tcp, udp } ct mark and 1 == 1 counter flow add @ftable
+	ip6 nexthdr { tcp, udp } ct mark and 2 == 2 counter flow add @ftable
+	ct mark and 30 == 30 ct state established,related log prefix \"nftables accept: \" level info accept
+	}
+}"
+
+$NFT -f - <<< "$RULESET" >/dev/null || exit 0
-- 
2.11.0

