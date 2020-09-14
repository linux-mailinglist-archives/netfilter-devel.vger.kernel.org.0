Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FE269612
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Sep 2020 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgINUIz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Sep 2020 16:08:55 -0400
Received: from correo.us.es ([193.147.175.20]:55420 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgINUIy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:08:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BF5A94A7064
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Sep 2020 22:08:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AF835DA78A
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Sep 2020 22:08:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A503BDA730; Mon, 14 Sep 2020 22:08:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 86624DA78A
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Sep 2020 22:08:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 14 Sep 2020 22:08:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 6D0884301DE0
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Sep 2020 22:08:50 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: py: flush log file output before running each command
Date:   Mon, 14 Sep 2020 22:08:44 +0200
Message-Id: <20200914200846.31726-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If nft crashes or hits an assertion, the last command run shows in the
/tmp/nftables-test.log file.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/py/nft-test.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/py/nft-test.py b/tests/py/nft-test.py
index df97ed8eefb7..e7b5e01efcb9 100755
--- a/tests/py/nft-test.py
+++ b/tests/py/nft-test.py
@@ -1022,6 +1022,8 @@ def execute_cmd(cmd, filename, lineno, stdout_log=False, debug=False):
     if debug_option:
         print(cmd)
 
+    log_file.flush()
+
     if debug:
         debug_old = nftables.get_debug()
         nftables.set_debug(debug)
-- 
2.20.1

