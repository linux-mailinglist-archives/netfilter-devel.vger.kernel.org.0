Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A141C649BAF
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Dec 2022 11:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiLLKIr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Dec 2022 05:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiLLKIq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:08:46 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD009FDB
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Dec 2022 02:08:45 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1p4fjn-0000fb-Oq; Mon, 12 Dec 2022 11:08:43 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 3/3] tests: add a test case for map update from packet path with concat
Date:   Mon, 12 Dec 2022 11:04:36 +0100
Message-Id: <20221212100436.84116-4-fw@strlen.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212100436.84116-1-fw@strlen.de>
References: <20221212100436.84116-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

add a second test case for map updates, this time with both
a timeout and a data element that consists of a concatenation.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../maps/dumps/typeof_maps_concat_update_0.nft | 12 ++++++++++++
 .../testcases/maps/typeof_maps_concat_update_0 | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tests/shell/testcases/maps/dumps/typeof_maps_concat_update_0.nft
 create mode 100755 tests/shell/testcases/maps/typeof_maps_concat_update_0

diff --git a/tests/shell/testcases/maps/dumps/typeof_maps_concat_update_0.nft b/tests/shell/testcases/maps/dumps/typeof_maps_concat_update_0.nft
new file mode 100644
index 000000000000..0963668629e5
--- /dev/null
+++ b/tests/shell/testcases/maps/dumps/typeof_maps_concat_update_0.nft
@@ -0,0 +1,12 @@
+table ip foo {
+	map pinned {
+		typeof ip daddr . tcp dport : ip daddr . tcp dport
+		size 65535
+		flags dynamic,timeout
+		timeout 6m
+	}
+
+	chain pr {
+		meta l4proto tcp update @pinned { ip saddr . ct original proto-dst timeout 1m30s : ct original ip daddr . ct reply proto-src }
+	}
+}
diff --git a/tests/shell/testcases/maps/typeof_maps_concat_update_0 b/tests/shell/testcases/maps/typeof_maps_concat_update_0
new file mode 100755
index 000000000000..357594ad55e8
--- /dev/null
+++ b/tests/shell/testcases/maps/typeof_maps_concat_update_0
@@ -0,0 +1,18 @@
+#!/bin/bash
+
+# check update statement does print both concatentations (key and data).
+
+EXPECTED="table ip foo {
+ map pinned {
+	typeof ip daddr . tcp dport : ip daddr . tcp dport
+	size 65535
+	flags dynamic,timeout
+        timeout 6m
+  }
+  chain pr {
+     meta l4proto tcp update @pinned { ip saddr . ct original proto-dst : ct original ip daddr . ct reply proto-src timeout 1m30s }
+  }
+}"
+
+set -e
+$NFT -f - <<< $EXPECTED
-- 
2.38.1

