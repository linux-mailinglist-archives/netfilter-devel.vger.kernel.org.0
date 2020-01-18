Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222651419D2
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 22:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgARVXV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 16:23:21 -0500
Received: from kadath.azazel.net ([81.187.231.250]:55198 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgARVXV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g8sEkvB438QJnh8LEBsCrrA7uH/I53NAAK6yAXymHy0=; b=uSZK9xnC/Ao73KY+SQkJQUE51o
        B7W0hHGgMCcLntf94Gw4EU86mDbW8EtBd5hT2w9RL1IrN5mIFeUnsueWCxbkHGmkvpsb+1xTsoy1e
        awd0lp2kQdCI3uYnn6L8kXMgzu+BZ78GThWnGd8OzvAuXu1z7ui0fWSsUwJ27YXJarO1qM9hrEjgH
        nFslKZ098V4dSMcvC3HImNaMq6ecoDFZfNnZ+vm6bjaFNTN37c9aEI0mYQigfcNZSS0v1G+SLYH9v
        GUTW29XTpnKLLOi71Zl4HrZR8BzYx9aQNY+JOZfsM9xSiDtAyi5/Rf1CvzfUNPLQv0F1ixJ167wzo
        YIp8WcGA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1isvYu-0006Ji-Cz
        for netfilter-devel@vger.kernel.org; Sat, 18 Jan 2020 21:23:20 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 9/9] tests: shell: add bit-shift tests.
Date:   Sat, 18 Jan 2020 21:23:19 +0000
Message-Id: <20200118212319.253112-10-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118212319.253112-1-jeremy@azazel.net>
References: <20200118212319.253112-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a couple of tests for setting the CT mark to a bitwise expression
derived from the packet mark and vice versa.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 tests/shell/testcases/chains/0040mark_shift_0         | 11 +++++++++++
 tests/shell/testcases/chains/0040mark_shift_1         | 11 +++++++++++
 .../shell/testcases/chains/dumps/0040mark_shift_0.nft |  6 ++++++
 .../shell/testcases/chains/dumps/0040mark_shift_1.nft |  6 ++++++
 4 files changed, 34 insertions(+)
 create mode 100755 tests/shell/testcases/chains/0040mark_shift_0
 create mode 100755 tests/shell/testcases/chains/0040mark_shift_1
 create mode 100644 tests/shell/testcases/chains/dumps/0040mark_shift_0.nft
 create mode 100644 tests/shell/testcases/chains/dumps/0040mark_shift_1.nft

diff --git a/tests/shell/testcases/chains/0040mark_shift_0 b/tests/shell/testcases/chains/0040mark_shift_0
new file mode 100755
index 000000000000..b40ee2dd5278
--- /dev/null
+++ b/tests/shell/testcases/chains/0040mark_shift_0
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook output priority mangle; }
+  add rule t c oif lo ct mark set meta mark << 8 | 0x10
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/chains/0040mark_shift_1 b/tests/shell/testcases/chains/0040mark_shift_1
new file mode 100755
index 000000000000..b609f5ef10ad
--- /dev/null
+++ b/tests/shell/testcases/chains/0040mark_shift_1
@@ -0,0 +1,11 @@
+#!/bin/bash
+
+set -e
+
+RULESET="
+  add table t
+  add chain t c { type filter hook input priority mangle; }
+  add rule t c iif lo ct mark & 0xff 0x10 meta mark set ct mark >> 8
+"
+
+$NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/chains/dumps/0040mark_shift_0.nft b/tests/shell/testcases/chains/dumps/0040mark_shift_0.nft
new file mode 100644
index 000000000000..4df4391111c5
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/0040mark_shift_0.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook output priority mangle; policy accept;
+		oif "lo" ct mark set meta mark << 0x00000008 | 0x00000010
+	}
+}
diff --git a/tests/shell/testcases/chains/dumps/0040mark_shift_1.nft b/tests/shell/testcases/chains/dumps/0040mark_shift_1.nft
new file mode 100644
index 000000000000..d4db9622387e
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/0040mark_shift_1.nft
@@ -0,0 +1,6 @@
+table ip t {
+	chain c {
+		type filter hook input priority mangle; policy accept;
+		iif "lo" ct mark & 0x000000ff == 0x00000010 meta mark set ct mark >> 0x00000008
+	}
+}
-- 
2.24.1

