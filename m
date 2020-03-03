Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E4B1773AD
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2020 11:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgCCKOf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Mar 2020 05:14:35 -0500
Received: from kadath.azazel.net ([81.187.231.250]:41968 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgCCKOf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BCmPEkKBUQMBBtRreV3JD+YolS+EJLadKnRq8WJCRRU=; b=D7Znfw0U6ZEl8TbLKexaMVyaCB
        6qBtj1diB6dCuip1G+VEY93zlEHkAw4yCJYhQsulxr6R9pcH/ku7aALYstYtjiXLKySfiMb5CKhUn
        wIQYwfq3YPrhPnzqprrdfS67/4nJPqaYxfJIu6SvAun0IN+cJbjiSSjj3N16hiQXgDEq6bnIhE+ID
        iM8WB8G1MdrJ/bAokWfhXCnJ4rhTsy8RMt0bhU4/h2HWNM8lkHe2+gleSnqLtwyi/DwtlHr2oeSFi
        7/l8RuSHBOAvuUCH7CHW9XamWZHBixZt+/ZJUNq4n9U0xZxhMNNNn74o4h2PILMhQon4MsTHf1V/b
        TlxDiJYQ==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j94AR-00081M-HQ; Tue, 03 Mar 2020 09:48:47 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v3 17/18] tests: shell: add variable binop RHS tests.
Date:   Tue,  3 Mar 2020 09:48:43 +0000
Message-Id: <20200303094844.26694-18-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303094844.26694-1-jeremy@azazel.net>
References: <20200303094844.26694-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add some tests to validate setting payload fields and marks with
statement arguments that include binops with variable RHS operands.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 tests/shell/testcases/chains/0040mark_shift_2         | 11 +++++++++++
 tests/shell/testcases/chains/0041payload_variable_0   | 11 +++++++++++
 tests/shell/testcases/chains/0041payload_variable_1   | 11 +++++++++++
 tests/shell/testcases/chains/0041payload_variable_2   | 11 +++++++++++
 tests/shell/testcases/chains/0041payload_variable_3   | 11 +++++++++++
 .../shell/testcases/chains/dumps/0040mark_shift_2.nft |  6 ++++++
 .../testcases/chains/dumps/0041payload_variable_0.nft |  6 ++++++
 .../testcases/chains/dumps/0041payload_variable_1.nft |  6 ++++++
 .../testcases/chains/dumps/0041payload_variable_2.nft |  6 ++++++
 .../testcases/chains/dumps/0041payload_variable_3.nft |  6 ++++++
 10 files changed, 85 insertions(+)
 create mode 100755 tests/shell/testcases/chains/0040mark_shift_2
 create mode 100755 tests/shell/testcases/chains/0041payload_variable_0
 create mode 100755 tests/shell/testcases/chains/0041payload_variable_1
 create mode 100755 tests/shell/testcases/chains/0041payload_variable_2
 create mode 100755 tests/shell/testcases/chains/0041payload_variable_3
 create mode 100644 tests/shell/testcases/chains/dumps/0040mark_shift_2.nft
 create mode 100644 tests/shell/testcases/chains/dumps/0041payload_variable_0.nft
 create mode 100644 tests/shell/testcases/chains/dumps/0041payload_variable_1.nft
 create mode 100644 tests/shell/testcases/chains/dumps/0041payload_variable_2.nft
 create mode 100644 tests/shell/testcases/chains/dumps/0041payload_variable_3.nft

diff --git a/tests/shell/testcases/chains/0040mark_shift_2 b/tests/shell/testcases/chains/0040mark_shift_2
new file mode 100755
index 000000000000..2ff3418bdd3f
--- /dev/null
+++ b/tests/shell/testcases/chains/0040mark_shift_2
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook input priority mangle; }
+  add rule t c ct mark set ct mark and 0xffff0000 or meta mark and 0xffff
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/chains/0041payload_variable_0 b/tests/shell/testcases/chains/0041payload_variable_0
new file mode 100755
index 000000000000..c9819ff4ab88
--- /dev/null
+++ b/tests/shell/testcases/chains/0041payload_variable_0
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook output priority mangle; }
+  add rule ip t c tcp dport set tcp dport
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/chains/0041payload_variable_1 b/tests/shell/testcases/chains/0041payload_variable_1
new file mode 100755
index 000000000000..e9b1e1dde515
--- /dev/null
+++ b/tests/shell/testcases/chains/0041payload_variable_1
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook output priority mangle; }
+  add rule ip t c tcp dport set tcp dport lshift 1
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/chains/0041payload_variable_2 b/tests/shell/testcases/chains/0041payload_variable_2
new file mode 100755
index 000000000000..5a458ef5d525
--- /dev/null
+++ b/tests/shell/testcases/chains/0041payload_variable_2
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook output priority mangle; }
+  add rule ip t c ip dscp set ip dscp
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/chains/0041payload_variable_3 b/tests/shell/testcases/chains/0041payload_variable_3
new file mode 100755
index 000000000000..0375399c3d0f
--- /dev/null
+++ b/tests/shell/testcases/chains/0041payload_variable_3
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook output priority mangle; }
+  add rule ip t c ip dscp set ip dscp or 0x3
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/chains/dumps/0040mark_shift_2.nft b/tests/shell/testcases/chains/dumps/0040mark_shift_2.nft
new file mode 100644
index 000000000000..14f2d1685706
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/0040mark_shift_2.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook input priority mangle; policy accept;
+		ct mark set ct mark & 0xffff0000 | meta mark & 0x0000ffff
+	}
+}
diff --git a/tests/shell/testcases/chains/dumps/0041payload_variable_0.nft b/tests/shell/testcases/chains/dumps/0041payload_variable_0.nft
new file mode 100644
index 000000000000..731949e6b355
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/0041payload_variable_0.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook output priority mangle; policy accept;
+		tcp dport set tcp dport
+	}
+}
diff --git a/tests/shell/testcases/chains/dumps/0041payload_variable_1.nft b/tests/shell/testcases/chains/dumps/0041payload_variable_1.nft
new file mode 100644
index 000000000000..2cd87a4dc8e1
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/0041payload_variable_1.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook output priority mangle; policy accept;
+		tcp dport set tcp dport << 1
+	}
+}
diff --git a/tests/shell/testcases/chains/dumps/0041payload_variable_2.nft b/tests/shell/testcases/chains/dumps/0041payload_variable_2.nft
new file mode 100644
index 000000000000..d1e7adb92c4c
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/0041payload_variable_2.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook output priority mangle; policy accept;
+		ip dscp set ip dscp
+	}
+}
diff --git a/tests/shell/testcases/chains/dumps/0041payload_variable_3.nft b/tests/shell/testcases/chains/dumps/0041payload_variable_3.nft
new file mode 100644
index 000000000000..52b3a833175a
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/0041payload_variable_3.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook output priority mangle; policy accept;
+		ip dscp set ip dscp | 0x03
+	}
+}
-- 
2.25.1

