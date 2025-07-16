Return-Path: <netfilter-devel+bounces-7911-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1686B075EA
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Jul 2025 14:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8C83A3853
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Jul 2025 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898732F5330;
	Wed, 16 Jul 2025 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="OBelgb64"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6B32F5314
	for <netfilter-devel@vger.kernel.org>; Wed, 16 Jul 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669631; cv=none; b=YinAIRrlVTl0JcAbL/ppOeTByHN+p6r5XHFJLpDTt3FijVsCVo481P43tTPe7A/pX2ujn/gNVGdQNWwWwvoNmjgne4LxpgYVj0z9aywGqTk0U+Az7NoIPvvvn04F7tXd9R/bd1ICnTd63yYcgdcwUumfpNObJP/SAAwjuf9udng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669631; c=relaxed/simple;
	bh=/POxvzE7ekkcmKwFzXLyu6swkD/pFuO5Xw18XJERNzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK/ZjLEAx4FE4uUfagSva93/uaJaGW/y8yHRhOXRUpls2zd84Z8pWUXnpp7L4lHD7INgfkYdpOrhQHNkxvZhdBYm2XgnN1OE6tj1cfPNWv9fG2h+4lJ0Xq9pzT3TD4YRC3QwY7Fjnjd/v80UVf8OS/Mx9qPg3yqjMiQB3jfIgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=OBelgb64; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ar38TXeXFP3/Kd65anADIPvlA8btPJXyQSQiGki5TFg=; b=OBelgb648xdF+ZywZYaZCOW4ks
	U6N58eI9R17oRd9XJFDIRSRqNxu6lW/lQ/ADGwKTYYT4N4lqX8BKkMZBChRhjN7fcAwp3vKZU3Int
	9RqdTzrpcwMhlBFpdy/XGLEheumSGBGAKS5VM3jEFDDII7ZNqtA4ltsH93ZvbR58fsQ9j27iEiV5h
	S6nouSB6qCEtq1EtVY23csxKtP7XaEybVLW8mbikqB4Hf2kgVO+02SbhWTbuwnahc+Mr3tAg1qLop
	vCDNLcl6hM8Hz87LlNnGyDjz71s9fzERcKPlJ+vWUMbk6hnEreTYNQBPqQe8TaID4KCvMmGCvqBJy
	l9+1YHcQ==;
Authentication-Results: mail.nwl.cc;
	iprev=pass (localhost) smtp.remote-ip=::1
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1uc1Qx-0000000044P-3L0g;
	Wed, 16 Jul 2025 14:40:27 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Subject: [nft PATCH v3 4/4] tests: shell: Test ifname-based hooks
Date: Wed, 16 Jul 2025 14:40:20 +0200
Message-ID: <20250716124020.5447-5-phil@nwl.cc>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716124020.5447-1-phil@nwl.cc>
References: <20250716124020.5447-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assert that:
- Non-matching interface specs are accepted
- Existing interfaces are hooked into upon flowtable/chain creation
- A new device matching the spec is hooked into immediately
- No stale hooks remain in 'nft list hooks' output
- Wildcard hooks basically work

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../features/list_hooks_flowtable_info.sh     |  7 +++
 .../netdev_chain_name_based_hook_0.json-nft   | 34 ++++++++++++++
 .../dumps/netdev_chain_name_based_hook_0.nft  |  5 +++
 .../chains/netdev_chain_name_based_hook_0     | 44 ++++++++++++++++++
 .../testcases/flowtable/0016name_based_hook_0 | 45 +++++++++++++++++++
 .../dumps/0016name_based_hook_0.json-nft      | 32 +++++++++++++
 .../flowtable/dumps/0016name_based_hook_0.nft |  6 +++
 7 files changed, 173 insertions(+)
 create mode 100755 tests/shell/features/list_hooks_flowtable_info.sh
 create mode 100644 tests/shell/testcases/chains/dumps/netdev_chain_name_based_hook_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/netdev_chain_name_based_hook_0.nft
 create mode 100755 tests/shell/testcases/chains/netdev_chain_name_based_hook_0
 create mode 100755 tests/shell/testcases/flowtable/0016name_based_hook_0
 create mode 100644 tests/shell/testcases/flowtable/dumps/0016name_based_hook_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0016name_based_hook_0.nft

diff --git a/tests/shell/features/list_hooks_flowtable_info.sh b/tests/shell/features/list_hooks_flowtable_info.sh
new file mode 100755
index 0000000000000..58bc57e040959
--- /dev/null
+++ b/tests/shell/features/list_hooks_flowtable_info.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+# check for flowtable info in 'list hooks' output
+
+unshare -n bash -c " \
+$NFT \"table inet t { flowtable ft { hook ingress priority 0; devices = { lo }; }; }\"; \
+$NFT list hooks netdev device lo | grep -q flowtable\ inet\ t\ ft"
diff --git a/tests/shell/testcases/chains/dumps/netdev_chain_name_based_hook_0.json-nft b/tests/shell/testcases/chains/dumps/netdev_chain_name_based_hook_0.json-nft
new file mode 100644
index 0000000000000..00706271e96a4
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/netdev_chain_name_based_hook_0.json-nft
@@ -0,0 +1,34 @@
+{
+  "nftables": [
+    {
+      "metainfo": {
+        "version": "VERSION",
+        "release_name": "RELEASE_NAME",
+        "json_schema_version": 1
+      }
+    },
+    {
+      "table": {
+        "family": "netdev",
+        "name": "t",
+        "handle": 0
+      }
+    },
+    {
+      "chain": {
+        "family": "netdev",
+        "table": "t",
+        "name": "c",
+        "handle": 0,
+        "dev": [
+          "foo*",
+          "lo"
+        ],
+        "type": "filter",
+        "hook": "ingress",
+        "prio": 0,
+        "policy": "accept"
+      }
+    }
+  ]
+}
diff --git a/tests/shell/testcases/chains/dumps/netdev_chain_name_based_hook_0.nft b/tests/shell/testcases/chains/dumps/netdev_chain_name_based_hook_0.nft
new file mode 100644
index 0000000000000..ac5acacd12e6d
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/netdev_chain_name_based_hook_0.nft
@@ -0,0 +1,5 @@
+table netdev t {
+	chain c {
+		type filter hook ingress devices = { "foo*", "lo" } priority filter; policy accept;
+	}
+}
diff --git a/tests/shell/testcases/chains/netdev_chain_name_based_hook_0 b/tests/shell/testcases/chains/netdev_chain_name_based_hook_0
new file mode 100755
index 0000000000000..8a8a601784084
--- /dev/null
+++ b/tests/shell/testcases/chains/netdev_chain_name_based_hook_0
@@ -0,0 +1,44 @@
+#!/bin/bash
+
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_ifname_based_hooks)
+
+cspec=' chain netdev t c '
+$NFT add table netdev t
+$NFT add $cspec '{ type filter hook ingress priority 0; devices = { lo, foo* }; }'
+$NFT list hooks netdev device lo | grep -q "$cspec" || {
+	echo "Existing device lo not hooked into chain as expected"
+	exit 1
+}
+
+[[ $($NFT list hooks | grep -c "$cspec") -eq 1 ]] || {
+	echo "Chain hooks into more than just lo"
+	exit 2
+}
+
+ip link add foo1 type dummy
+$NFT list hooks netdev device foo1 | grep -q "$cspec" || {
+	echo "Chain did not hook into new device foo1"
+	exit 3
+}
+[[ $($NFT list hooks | grep -c "$cspec") -eq 2 ]] || {
+	echo "Chain expected to hook into exactly two devices"
+	exit 4
+}
+
+ip link del foo1
+$NFT list hooks netdev device foo1 | grep -q "$cspec" && {
+	echo "Chain still hooks into removed device foo1"
+	exit 5
+}
+[[ $($NFT list hooks | grep -c "$cspec") -eq 1 ]] || {
+	echo "Chain expected to hook into just lo"
+	exit 6
+}
+
+for ((i = 0; i < 100; i++)); do
+	ip link add foo$i type dummy
+done
+[[ $($NFT list hooks | grep -c "$cspec") -eq 101 ]] || {
+	echo "Chain did not hook into all 100 new devices"
+	exit 7
+}
diff --git a/tests/shell/testcases/flowtable/0016name_based_hook_0 b/tests/shell/testcases/flowtable/0016name_based_hook_0
new file mode 100755
index 0000000000000..9a55596027158
--- /dev/null
+++ b/tests/shell/testcases/flowtable/0016name_based_hook_0
@@ -0,0 +1,45 @@
+#!/bin/bash
+
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_ifname_based_hooks)
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_list_hooks_flowtable_info)
+
+ftspec=' flowtable ip t ft '
+$NFT add table t
+$NFT add $ftspec '{ hook ingress priority 0; devices = { lo, foo* }; }'
+$NFT list hooks netdev device lo | grep -q "$ftspec" || {
+	echo "Existing device lo not hooked into flowtable as expected"
+	exit 1
+}
+
+[[ $($NFT list hooks | grep -c "$ftspec") -eq 1 ]] || {
+	echo "Flowtable hooks into more than just lo"
+	exit 2
+}
+
+ip link add foo1 type dummy
+$NFT list hooks netdev device foo1 | grep -q "$ftspec" || {
+	echo "Flowtable did not hook into new device foo1"
+	exit 3
+}
+[[ $($NFT list hooks | grep -c "$ftspec") -eq 2 ]] || {
+	echo "Flowtable expected to hook into exactly two devices"
+	exit 4
+}
+
+ip link del foo1
+$NFT list hooks netdev device foo1 | grep -q "$ftspec" && {
+	echo "Flowtable still hooks into removed device foo1"
+	exit 5
+}
+[[ $($NFT list hooks | grep -c "$ftspec") -eq 1 ]] || {
+	echo "Flowtable expected to hook into just lo"
+	exit 6
+}
+
+for ((i = 0; i < 100; i++)); do
+	ip link add foo$i type dummy
+done
+[[ $($NFT list hooks | grep -c "$ftspec") -eq 101 ]] || {
+	echo "Flowtable did not hook into all 100 new devices"
+	exit 7
+}
diff --git a/tests/shell/testcases/flowtable/dumps/0016name_based_hook_0.json-nft b/tests/shell/testcases/flowtable/dumps/0016name_based_hook_0.json-nft
new file mode 100644
index 0000000000000..93e263323ff95
--- /dev/null
+++ b/tests/shell/testcases/flowtable/dumps/0016name_based_hook_0.json-nft
@@ -0,0 +1,32 @@
+{
+  "nftables": [
+    {
+      "metainfo": {
+        "version": "VERSION",
+        "release_name": "RELEASE_NAME",
+        "json_schema_version": 1
+      }
+    },
+    {
+      "table": {
+        "family": "ip",
+        "name": "t",
+        "handle": 0
+      }
+    },
+    {
+      "flowtable": {
+        "family": "ip",
+        "name": "ft",
+        "table": "t",
+        "handle": 0,
+        "hook": "ingress",
+        "prio": 0,
+        "dev": [
+          "foo*",
+          "lo"
+        ]
+      }
+    }
+  ]
+}
diff --git a/tests/shell/testcases/flowtable/dumps/0016name_based_hook_0.nft b/tests/shell/testcases/flowtable/dumps/0016name_based_hook_0.nft
new file mode 100644
index 0000000000000..b4810664a956f
--- /dev/null
+++ b/tests/shell/testcases/flowtable/dumps/0016name_based_hook_0.nft
@@ -0,0 +1,6 @@
+table ip t {
+	flowtable ft {
+		hook ingress priority filter
+		devices = { "foo*", "lo" }
+	}
+}
-- 
2.49.0


