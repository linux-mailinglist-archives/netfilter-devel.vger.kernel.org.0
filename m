Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3049169B0C
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Feb 2020 01:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgBXADo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 23 Feb 2020 19:03:44 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46002 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgBXADo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:03:44 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1j61Do-0004lH-Gl; Mon, 24 Feb 2020 01:03:40 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     nevola@gmail.com, Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 1/6] tests: add initial nat map test
Date:   Mon, 24 Feb 2020 01:03:19 +0100
Message-Id: <20200224000324.9333-2-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224000324.9333-1-fw@strlen.de>
References: <20200224000324.9333-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Will be extended to cover upcoming
'dnat to ip saddr . tcp dport map { \
  1.2.3.4 . 80 : 5.6.7.8 : 8080,
  2.2.3.4 . 80 : 7.6.7.8 : 1234,
   ...

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../testcases/maps/dumps/nat_addr_port.nft    | 13 +++
 tests/shell/testcases/maps/nat_addr_port      | 83 +++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tests/shell/testcases/maps/dumps/nat_addr_port.nft
 create mode 100755 tests/shell/testcases/maps/nat_addr_port

diff --git a/tests/shell/testcases/maps/dumps/nat_addr_port.nft b/tests/shell/testcases/maps/dumps/nat_addr_port.nft
new file mode 100644
index 000000000000..3ed6812e585f
--- /dev/null
+++ b/tests/shell/testcases/maps/dumps/nat_addr_port.nft
@@ -0,0 +1,13 @@
+table ip ipfoo {
+	map x {
+		type ipv4_addr : ipv4_addr
+	}
+
+	chain c {
+		type nat hook prerouting priority dstnat; policy accept;
+		iifname != "foobar" accept
+		dnat to ip daddr map @x
+		ip saddr 10.1.1.1 dnat to 10.2.3.4
+		ip saddr 10.1.1.2 tcp dport 42 dnat to 10.2.3.4:4242
+	}
+}
diff --git a/tests/shell/testcases/maps/nat_addr_port b/tests/shell/testcases/maps/nat_addr_port
new file mode 100755
index 000000000000..77a2f110aeb9
--- /dev/null
+++ b/tests/shell/testcases/maps/nat_addr_port
@@ -0,0 +1,83 @@
+#!/bin/bash
+
+# skeleton
+$NFT -f /dev/stdin <<EOF || exit 1
+table ip ipfoo {
+	map x {
+		type ipv4_addr : ipv4_addr
+	}
+
+	chain c {
+		type nat hook prerouting priority dstnat; policy accept;
+		meta iifname != "foobar" accept
+		dnat to ip daddr map @x
+		ip saddr 10.1.1.1 dnat to 10.2.3.4
+		ip saddr 10.1.1.2 tcp dport 42 dnat to 10.2.3.4:4242
+	}
+}
+EOF
+
+# should fail: rule has no test for l4 protocol
+$NFT add rule 'ip ipfoo c ip saddr 10.1.1.2 dnat to 10.2.3.4:4242' && exit 1
+
+# should fail: map has wrong family: 4->6
+$NFT add rule 'inet inetfoo c dnat to ip daddr map @x6' && exit 1
+
+# should fail: map has wrong family: 6->4
+$NFT add rule 'inet inetfoo c dnat to ip6 daddr map @x4' && exit 1
+
+# should fail: rule has no test for l4 protocol
+$NFT add rule 'inet inetfoo c ip6 saddr f0:0b::a3 dnat to [1c::3]:42' && exit 1
+
+# should fail: rule has no test for l4 protocol, but map has inet_service
+$NFT add rule 'inet inetfoo c dnat to ip daddr map @y4' && exit 1
+
+# should fail: rule has test for l4 protocol, but map has wrong family: 4->6
+$NFT add rule 'inet inetfoo c meta l4proto tcp dnat to ip daddr map @y6' && exit 1
+
+# should fail: rule has test for l4 protocol, but map has wrong family: 6->4
+$NFT add rule 'inet inetfoo c meta l4proto tcp dnat to ip6 daddr map @y4' && exit 1
+
+# fail: inet_service, but expect ipv4_addr
+$NFT -f /dev/stdin <<EOF && exit 1
+table inet inetfoo {
+	map a {
+		type ipv4_addr : inet_service
+	}
+
+	chain c {
+		type nat hook prerouting priority dstnat; policy accept;
+		meta l4proto tcp dnat ip to ip saddr map @a
+	}
+}
+EOF
+
+# fail: maps to inet_service . inet_service, not addr . service
+$NFT -f /dev/stdin <<EOF && exit 1
+table inet inetfoo {
+	map b {
+		type ipv4_addr : inet_service . inet_service
+	}
+
+	chain c {
+		type nat hook prerouting priority dstnat; policy accept;
+		meta l4proto tcp dnat ip to ip saddr map @a
+	}
+}
+EOF
+
+# fail: only accept exactly two sub-expressions: 'addr . service'
+$NFT -f /dev/stdin <<EOF && exit 1
+table inet inetfoo {
+	map b {
+		type ipv4_addr : inet_addr . inet_service . inet_service
+	}
+
+	chain c {
+		type nat hook prerouting priority dstnat; policy accept;
+		meta l4proto tcp dnat ip to ip saddr map @a
+	}
+}
+EOF
+
+exit 0
-- 
2.24.1

