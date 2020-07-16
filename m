Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71221222A2D
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jul 2020 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgGPRnQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Jul 2020 13:43:16 -0400
Received: from correo.us.es ([193.147.175.20]:39076 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbgGPRnQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:43:16 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0F2B0EF426
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jul 2020 19:43:14 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 004E5DA722
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jul 2020 19:43:14 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E9F50DA72F; Thu, 16 Jul 2020 19:43:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BBFA7DA722
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jul 2020 19:43:11 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 16 Jul 2020 19:43:11 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 9DAFE4265A2F
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jul 2020 19:43:11 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 4/4] tests: shell: remove check for reject from prerouting
Date:   Thu, 16 Jul 2020 19:43:05 +0200
Message-Id: <20200716174305.4114-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200716174305.4114-1-pablo@netfilter.org>
References: <20200716174305.4114-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

It reports a failure with the following kernel patch:

 commit f53b9b0bdc59c0823679f2e3214e0d538f5951b9
 Author: Laura Garcia Liebana <nevola@gmail.com>
 Date:   Sun May 31 22:26:23 2020 +0200

    netfilter: introduce support for reject at prerouting stage

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../shell/testcases/chains/0012reject_in_prerouting_1 | 11 -----------
 1 file changed, 11 deletions(-)
 delete mode 100755 tests/shell/testcases/chains/0012reject_in_prerouting_1

diff --git a/tests/shell/testcases/chains/0012reject_in_prerouting_1 b/tests/shell/testcases/chains/0012reject_in_prerouting_1
deleted file mode 100755
index 0ee86c11055e..000000000000
--- a/tests/shell/testcases/chains/0012reject_in_prerouting_1
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/bash
-
-set -e
-
-$NFT add table t
-$NFT add chain t prerouting {type filter hook prerouting priority 0 \; }
-
-# wrong hook prerouting, only input/forward/output is valid
-$NFT add rule t prerouting reject 2>/dev/null || exit 0
-echo "E: accepted reject in prerouting hook" >&2
-exit 1
-- 
2.20.1

