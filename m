Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B4330E2B3
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Feb 2021 19:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhBCSnT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Feb 2021 13:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhBCSnS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:43:18 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815B6C0613ED
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 10:42:38 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1l7N6r-0005wc-5X; Wed, 03 Feb 2021 19:42:37 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 2/3] tests: add empty dynamic set
Date:   Wed,  3 Feb 2021 19:42:26 +0100
Message-Id: <20210203184227.32208-2-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203184227.32208-1-fw@strlen.de>
References: <20210203184150.32145-1-fw@strlen.de>
 <20210203184227.32208-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft crashes on restore.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/testcases/nft-f/0025empty_dynset_0   | 16 ++++++++++++++++
 .../testcases/nft-f/dumps/0025empty_dynset_0.nft | 12 ++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100755 tests/shell/testcases/nft-f/0025empty_dynset_0
 create mode 100644 tests/shell/testcases/nft-f/dumps/0025empty_dynset_0.nft

diff --git a/tests/shell/testcases/nft-f/0025empty_dynset_0 b/tests/shell/testcases/nft-f/0025empty_dynset_0
new file mode 100755
index 000000000000..796628a7c69a
--- /dev/null
+++ b/tests/shell/testcases/nft-f/0025empty_dynset_0
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+RULESET="table ip foo {
+	        set inflows {
+                type ipv4_addr . inet_service . ifname . ipv4_addr . inet_service
+                flags dynamic
+                elements = { 10.1.0.3 . 39466 . \"veth1\" . 10.3.0.99 . 5201 counter packets 0 bytes 0 }
+        }
+
+        set inflows6 {
+                type ipv6_addr . inet_service . ifname . ipv6_addr . inet_service
+                flags dynamic
+        }
+}"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/nft-f/dumps/0025empty_dynset_0.nft b/tests/shell/testcases/nft-f/dumps/0025empty_dynset_0.nft
new file mode 100644
index 000000000000..559eb49fc2e1
--- /dev/null
+++ b/tests/shell/testcases/nft-f/dumps/0025empty_dynset_0.nft
@@ -0,0 +1,12 @@
+table ip foo {
+	set inflows {
+		type ipv4_addr . inet_service . ifname . ipv4_addr . inet_service
+		flags dynamic
+		elements = { 10.1.0.3 . 39466 . "veth1" . 10.3.0.99 . 5201 counter packets 0 bytes 0 }
+	}
+
+	set inflows6 {
+		type ipv6_addr . inet_service . ifname . ipv6_addr . inet_service
+		flags dynamic
+	}
+}
-- 
2.26.2

