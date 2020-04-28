Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB67E1BBD21
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2020 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD1MKj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Apr 2020 08:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD1MKj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:10:39 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4179EC03C1A9
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 05:10:39 -0700 (PDT)
Received: from localhost ([::1]:38626 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jTP4Q-00085G-2t; Tue, 28 Apr 2020 14:10:38 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 17/18] nft: cache: Optimize caching for flush command
Date:   Tue, 28 Apr 2020 14:10:12 +0200
Message-Id: <20200428121013.24507-18-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200428121013.24507-1-phil@nwl.cc>
References: <20200428121013.24507-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When flushing all chains and verbose mode is not enabled,
nft_rule_flush() uses a shortcut: It doesn't specify a chain name for
NFT_MSG_DELRULE, so the kernel will flush all existing chains without
user space needing to know which they are.

The above allows to avoid a chain cache, but there's a caveat:
nft_xt_builtin_init() will create base chains as it assumes they are
missing and thereby possibly overrides any non-default chain policies.

Solve this by making nft_xt_builtin_init() cache-aware: If a command
doesn't need a chain cache, there's no need to bother with creating any
non-existing builtin chains, either. For the sake of completeness, also
do nothing if cache is not initialized (although that shouldn't happen).

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cmd.c                            |  5 +++-
 iptables/nft.c                                |  6 ++++
 .../testcases/nft-only/0006-policy-override_0 | 29 +++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100755 iptables/tests/shell/testcases/nft-only/0006-policy-override_0

diff --git a/iptables/nft-cmd.c b/iptables/nft-cmd.c
index 64889f5eb6196..3c0c6a34515e4 100644
--- a/iptables/nft-cmd.c
+++ b/iptables/nft-cmd.c
@@ -159,7 +159,10 @@ int nft_cmd_rule_flush(struct nft_handle *h, const char *chain,
 	if (!cmd)
 		return 0;
 
-	nft_cache_level_set(h, NFT_CL_CHAINS, cmd);
+	if (chain || verbose)
+		nft_cache_level_set(h, NFT_CL_CHAINS, cmd);
+	else
+		nft_cache_level_set(h, NFT_CL_TABLES, cmd);
 
 	return 1;
 }
diff --git a/iptables/nft.c b/iptables/nft.c
index 5b255477f27f7..67b8466b50692 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -737,6 +737,9 @@ static int nft_xt_builtin_init(struct nft_handle *h, const char *table)
 {
 	const struct builtin_table *t;
 
+	if (!h->cache_init)
+		return 0;
+
 	t = nft_table_builtin_find(h, table);
 	if (t == NULL)
 		return -1;
@@ -747,6 +750,9 @@ static int nft_xt_builtin_init(struct nft_handle *h, const char *table)
 	if (nft_table_builtin_add(h, t) < 0)
 		return -1;
 
+	if (h->cache_req.level < NFT_CL_CHAINS)
+		return 0;
+
 	nft_chain_builtin_init(h, t);
 
 	h->cache->table[t->type].initialized = true;
diff --git a/iptables/tests/shell/testcases/nft-only/0006-policy-override_0 b/iptables/tests/shell/testcases/nft-only/0006-policy-override_0
new file mode 100755
index 0000000000000..68e2019b83119
--- /dev/null
+++ b/iptables/tests/shell/testcases/nft-only/0006-policy-override_0
@@ -0,0 +1,29 @@
+#!/bin/bash
+
+[[ $XT_MULTI == *xtables-nft-multi ]] || { echo "skip $XT_MULTI"; exit 0; }
+
+# make sure none of the commands invoking nft_xt_builtin_init() override
+# non-default chain policies via needless chain add.
+
+RC=0
+
+do_test() {
+	$XT_MULTI $@
+	$XT_MULTI iptables -S | grep -q -- '-P FORWARD DROP' && return
+
+	echo "command '$@' kills chain policies"
+	$XT_MULTI iptables -P FORWARD DROP
+	RC=1
+}
+
+$XT_MULTI iptables -P FORWARD DROP
+
+do_test iptables -A OUTPUT -j ACCEPT
+do_test iptables -F
+do_test iptables -N foo
+do_test iptables -E foo foo2
+do_test iptables -I OUTPUT -j ACCEPT
+do_test iptables -nL
+do_test iptables -S
+
+exit $RC
-- 
2.25.1

