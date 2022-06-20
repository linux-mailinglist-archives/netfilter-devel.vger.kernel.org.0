Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA75512DA
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 10:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbiFTIcj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 04:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239848AbiFTIcb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:32:31 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C7C612A88
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 01:32:30 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 18/18] libnftables: release top level scope
Date:   Mon, 20 Jun 2022 10:32:15 +0200
Message-Id: <20220620083215.1021238-19-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620083215.1021238-1-pablo@netfilter.org>
References: <20220620083215.1021238-1-pablo@netfilter.org>
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

Otherwise bogus variable redefinition are reported via -o/--optimize:

  redefinition.conf:5:8-21: Error: redefinition of symbol 'interface_inet'
  define interface_inet = enp5s0
         ^^^^^^^^^^^^^^

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/libnftables.c                             |  2 ++
 tests/shell/testcases/optimizations/variables | 15 +++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100755 tests/shell/testcases/optimizations/variables

diff --git a/src/libnftables.c b/src/libnftables.c
index aac682b706ff..f2a1ef04e80b 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -708,6 +708,8 @@ err:
 	if (rc)
 		nft_cache_release(&nft->cache);
 
+	scope_release(nft->state->scopes[0]);
+
 	return rc;
 }
 
diff --git a/tests/shell/testcases/optimizations/variables b/tests/shell/testcases/optimizations/variables
new file mode 100755
index 000000000000..fa986065006b
--- /dev/null
+++ b/tests/shell/testcases/optimizations/variables
@@ -0,0 +1,15 @@
+#!/bin/bash
+
+set -e
+
+RULESET="define addrv4_vpnnet = 10.1.0.0/16
+
+table ip nat {
+    chain postrouting {
+        type nat hook postrouting priority 0; policy accept;
+
+        ip saddr \$addrv4_vpnnet counter masquerade fully-random comment \"masquerade ipv4\"
+    }
+}"
+
+$NFT -c -o -f - <<< $RULESET
-- 
2.30.2

