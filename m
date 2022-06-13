Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66120549C1A
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jun 2022 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbiFMSsF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Jun 2022 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344348AbiFMSr5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:47:57 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70AC3DA615
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Jun 2022 08:06:25 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: runtime set element automerge
Date:   Mon, 13 Jun 2022 17:06:20 +0200
Message-Id: <20220613150620.28474-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a test to cover runtime set element automerge.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/sets/automerge_0 | 64 ++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100755 tests/shell/testcases/sets/automerge_0

diff --git a/tests/shell/testcases/sets/automerge_0 b/tests/shell/testcases/sets/automerge_0
new file mode 100755
index 000000000000..c9fb609571fa
--- /dev/null
+++ b/tests/shell/testcases/sets/automerge_0
@@ -0,0 +1,64 @@
+#!/bin/bash
+
+set -e
+
+RULESET="table inet x {
+	set y {
+		type inet_service
+		flags interval
+		auto-merge
+	}
+}"
+
+$NFT -f - <<< $RULESET
+
+tmpfile=$(mktemp)
+echo -n "add element inet x y { " > $tmpfile
+for ((i=0;i<65535;i+=2))
+do
+	echo -n "$i, " >> $tmpfile
+	if [ $i -eq 65534 ]
+	then
+		echo -n "$i" >> $tmpfile
+	fi
+done
+echo "}" >> $tmpfile
+
+$NFT -f $tmpfile
+
+tmpfile2=$(mktemp)
+for ((i=1;i<65535;i+=2))
+do
+	echo "$i" >> $tmpfile2
+done
+
+tmpfile3=$(mktemp)
+shuf $tmpfile2 > $tmpfile3
+i=0
+cat $tmpfile3 | while read line && [ $i -lt 10 ]
+do
+	$NFT add element inet x y { $line }
+	i=$((i+1))
+done
+
+for ((i=0;i<10;i++))
+do
+	from=$(($RANDOM%65535))
+	to=$(($from+100))
+	$NFT add element inet x y { $from-$to }
+	if [ $? -ne 0 ]
+	then
+		echo "failed to add $from-$to"
+		exit 1
+	fi
+	$NFT get element inet x y { $from-$to }
+	if [ $? -ne 0 ]
+	then
+		echo "failed to get $from-$to"
+		exit 1
+	fi
+done
+
+rm -f $tmpfile
+rm -f $tmpfile2
+rm -f $tmpfile3
-- 
2.30.2

