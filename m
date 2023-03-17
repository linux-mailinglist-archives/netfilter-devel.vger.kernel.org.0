Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150A26BE615
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Mar 2023 10:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCQJ6q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Mar 2023 05:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCQJ6p (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:58:45 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E70B21DBB1
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Mar 2023 02:58:42 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 9/9] tests: shell: add test-cases for ct and packet mark payload expressions
Date:   Fri, 17 Mar 2023 10:58:33 +0100
Message-Id: <20230317095833.1225401-10-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230317095833.1225401-1-pablo@netfilter.org>
References: <20230317095833.1225401-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

Add new test-cases to verify that defining a rule that sets the ct or
packet mark to a value derived from a payload works correctly.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/bitwise/0040mark_binop_2        | 11 +++++++++++
 tests/shell/testcases/bitwise/0040mark_binop_3        | 11 +++++++++++
 tests/shell/testcases/bitwise/0040mark_binop_4        | 11 +++++++++++
 tests/shell/testcases/bitwise/0040mark_binop_5        | 11 +++++++++++
 tests/shell/testcases/bitwise/0040mark_binop_6        | 11 +++++++++++
 tests/shell/testcases/bitwise/0040mark_binop_7        | 11 +++++++++++
 tests/shell/testcases/bitwise/0040mark_binop_8        | 11 +++++++++++
 tests/shell/testcases/bitwise/0040mark_binop_9        | 11 +++++++++++
 .../testcases/bitwise/dumps/0040mark_binop_2.nft      |  6 ++++++
 .../testcases/bitwise/dumps/0040mark_binop_3.nft      |  6 ++++++
 .../testcases/bitwise/dumps/0040mark_binop_4.nft      |  6 ++++++
 .../testcases/bitwise/dumps/0040mark_binop_5.nft      |  6 ++++++
 .../testcases/bitwise/dumps/0040mark_binop_6.nft      |  6 ++++++
 .../testcases/bitwise/dumps/0040mark_binop_7.nft      |  6 ++++++
 .../testcases/bitwise/dumps/0040mark_binop_8.nft      |  6 ++++++
 .../testcases/bitwise/dumps/0040mark_binop_9.nft      |  6 ++++++
 16 files changed, 136 insertions(+)
 create mode 100755 tests/shell/testcases/bitwise/0040mark_binop_2
 create mode 100755 tests/shell/testcases/bitwise/0040mark_binop_3
 create mode 100755 tests/shell/testcases/bitwise/0040mark_binop_4
 create mode 100755 tests/shell/testcases/bitwise/0040mark_binop_5
 create mode 100755 tests/shell/testcases/bitwise/0040mark_binop_6
 create mode 100755 tests/shell/testcases/bitwise/0040mark_binop_7
 create mode 100755 tests/shell/testcases/bitwise/0040mark_binop_8
 create mode 100755 tests/shell/testcases/bitwise/0040mark_binop_9
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_2.nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_3.nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_4.nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_5.nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_6.nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_7.nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_8.nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_9.nft

diff --git a/tests/shell/testcases/bitwise/0040mark_binop_2 b/tests/shell/testcases/bitwise/0040mark_binop_2
new file mode 100755
index 000000000000..94ebe976c987
--- /dev/null
+++ b/tests/shell/testcases/bitwise/0040mark_binop_2
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook output priority filter; }
+  add rule t c ct mark set ip dscp lshift 2 or 0x10
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/bitwise/0040mark_binop_3 b/tests/shell/testcases/bitwise/0040mark_binop_3
new file mode 100755
index 000000000000..b491565ca573
--- /dev/null
+++ b/tests/shell/testcases/bitwise/0040mark_binop_3
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook input priority filter; }
+  add rule t c meta mark set ip dscp lshift 2 or 0x10
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/bitwise/0040mark_binop_4 b/tests/shell/testcases/bitwise/0040mark_binop_4
new file mode 100755
index 000000000000..adc5f25ba930
--- /dev/null
+++ b/tests/shell/testcases/bitwise/0040mark_binop_4
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook output priority filter; }
+  add rule t c ct mark set ip dscp lshift 26 or 0x10
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/bitwise/0040mark_binop_5 b/tests/shell/testcases/bitwise/0040mark_binop_5
new file mode 100755
index 000000000000..286b7b1fc7f9
--- /dev/null
+++ b/tests/shell/testcases/bitwise/0040mark_binop_5
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook input priority filter; }
+  add rule t c meta mark set ip dscp lshift 26 or 0x10
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/bitwise/0040mark_binop_6 b/tests/shell/testcases/bitwise/0040mark_binop_6
new file mode 100755
index 000000000000..9ea82952ef24
--- /dev/null
+++ b/tests/shell/testcases/bitwise/0040mark_binop_6
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table ip6 t
+  add chain ip6 t c { type filter hook output priority filter; }
+  add rule ip6 t c ct mark set ip6 dscp lshift 2 or 0x10
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/bitwise/0040mark_binop_7 b/tests/shell/testcases/bitwise/0040mark_binop_7
new file mode 100755
index 000000000000..ff9cfb55ac3e
--- /dev/null
+++ b/tests/shell/testcases/bitwise/0040mark_binop_7
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table ip6 t
+  add chain ip6 t c { type filter hook input priority filter; }
+  add rule ip6 t c meta mark set ip6 dscp lshift 2 or 0x10
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/bitwise/0040mark_binop_8 b/tests/shell/testcases/bitwise/0040mark_binop_8
new file mode 100755
index 000000000000..b348ee9367df
--- /dev/null
+++ b/tests/shell/testcases/bitwise/0040mark_binop_8
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table ip6 t
+  add chain ip6 t c { type filter hook output priority filter; }
+  add rule ip6 t c ct mark set ip6 dscp lshift 26 or 0x10
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/bitwise/0040mark_binop_9 b/tests/shell/testcases/bitwise/0040mark_binop_9
new file mode 100755
index 000000000000..d19447d42b22
--- /dev/null
+++ b/tests/shell/testcases/bitwise/0040mark_binop_9
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table ip6 t
+  add chain ip6 t c { type filter hook input priority filter; }
+  add rule ip6 t c meta mark set ip6 dscp lshift 26 or 0x10
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/bitwise/dumps/0040mark_binop_2.nft b/tests/shell/testcases/bitwise/dumps/0040mark_binop_2.nft
new file mode 100644
index 000000000000..2b9be36e2a03
--- /dev/null
+++ b/tests/shell/testcases/bitwise/dumps/0040mark_binop_2.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook output priority filter; policy accept;
+		ct mark set ip dscp << 2 | 0x10
+	}
+}
diff --git a/tests/shell/testcases/bitwise/dumps/0040mark_binop_3.nft b/tests/shell/testcases/bitwise/dumps/0040mark_binop_3.nft
new file mode 100644
index 000000000000..8206fec045bc
--- /dev/null
+++ b/tests/shell/testcases/bitwise/dumps/0040mark_binop_3.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook input priority filter; policy accept;
+		meta mark set ip dscp << 2 | 0x10
+	}
+}
diff --git a/tests/shell/testcases/bitwise/dumps/0040mark_binop_4.nft b/tests/shell/testcases/bitwise/dumps/0040mark_binop_4.nft
new file mode 100644
index 000000000000..91d9f5662acb
--- /dev/null
+++ b/tests/shell/testcases/bitwise/dumps/0040mark_binop_4.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook output priority filter; policy accept;
+		ct mark set ip dscp << 26 | 0x10
+	}
+}
diff --git a/tests/shell/testcases/bitwise/dumps/0040mark_binop_5.nft b/tests/shell/testcases/bitwise/dumps/0040mark_binop_5.nft
new file mode 100644
index 000000000000..f2b51eb80674
--- /dev/null
+++ b/tests/shell/testcases/bitwise/dumps/0040mark_binop_5.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook input priority filter; policy accept;
+		meta mark set ip dscp << 26 | 0x10
+	}
+}
diff --git a/tests/shell/testcases/bitwise/dumps/0040mark_binop_6.nft b/tests/shell/testcases/bitwise/dumps/0040mark_binop_6.nft
new file mode 100644
index 000000000000..cf7be90c35e1
--- /dev/null
+++ b/tests/shell/testcases/bitwise/dumps/0040mark_binop_6.nft
@@ -0,0 +1,6 @@
+table ip6 t {
+	chain c {
+		type filter hook output priority filter; policy accept;
+		ct mark set ip6 dscp << 2 | 0x10
+	}
+}
diff --git a/tests/shell/testcases/bitwise/dumps/0040mark_binop_7.nft b/tests/shell/testcases/bitwise/dumps/0040mark_binop_7.nft
new file mode 100644
index 000000000000..a9663e621448
--- /dev/null
+++ b/tests/shell/testcases/bitwise/dumps/0040mark_binop_7.nft
@@ -0,0 +1,6 @@
+table ip6 t {
+	chain c {
+		type filter hook input priority filter; policy accept;
+		meta mark set ip6 dscp << 2 | 0x10
+	}
+}
diff --git a/tests/shell/testcases/bitwise/dumps/0040mark_binop_8.nft b/tests/shell/testcases/bitwise/dumps/0040mark_binop_8.nft
new file mode 100644
index 000000000000..04b866ad6dd5
--- /dev/null
+++ b/tests/shell/testcases/bitwise/dumps/0040mark_binop_8.nft
@@ -0,0 +1,6 @@
+table ip6 t {
+	chain c {
+		type filter hook output priority filter; policy accept;
+		ct mark set ip6 dscp << 26 | 0x10
+	}
+}
diff --git a/tests/shell/testcases/bitwise/dumps/0040mark_binop_9.nft b/tests/shell/testcases/bitwise/dumps/0040mark_binop_9.nft
new file mode 100644
index 000000000000..d4745ea4947e
--- /dev/null
+++ b/tests/shell/testcases/bitwise/dumps/0040mark_binop_9.nft
@@ -0,0 +1,6 @@
+table ip6 t {
+	chain c {
+		type filter hook input priority filter; policy accept;
+		meta mark set ip6 dscp << 26 | 0x10
+	}
+}
-- 
2.30.2

