Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF08C31FD84
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Feb 2021 17:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBSQ6T (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Feb 2021 11:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBSQ6S (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:58:18 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F368C061786
        for <netfilter-devel@vger.kernel.org>; Fri, 19 Feb 2021 08:57:37 -0800 (PST)
Received: from localhost ([::1]:33132 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1lD95z-00081W-68; Fri, 19 Feb 2021 17:57:35 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] nft: Fix bitwise expression avoidance detection
Date:   Fri, 19 Feb 2021 17:57:26 +0100
Message-Id: <20210219165726.20986-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Byte-boundary prefix detection was too sloppy: Any data following the
first zero-byte was ignored. Add a follow-up loop making sure there are
no stray bits in the designated host part.

Fixes: 323259001d617 ("nft: Optimize class-based IP prefix matches")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.c                         |  4 +++-
 .../testcases/ip6tables/0004-address-masks_0  | 24 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100755 iptables/tests/shell/testcases/ip6tables/0004-address-masks_0

diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 10553ab26823b..c1664b50f9383 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -166,7 +166,7 @@ void add_addr(struct nftnl_rule *r, enum nft_payload_bases base, int offset,
 {
 	const unsigned char *m = mask;
 	bool bitwise = false;
-	int i;
+	int i, j;
 
 	for (i = 0; i < len; i++) {
 		if (m[i] != 0xff) {
@@ -174,6 +174,8 @@ void add_addr(struct nftnl_rule *r, enum nft_payload_bases base, int offset,
 			break;
 		}
 	}
+	for (j = i + 1; !bitwise && j < len; j++)
+		bitwise = !!m[j];
 
 	if (!bitwise)
 		len = i;
diff --git a/iptables/tests/shell/testcases/ip6tables/0004-address-masks_0 b/iptables/tests/shell/testcases/ip6tables/0004-address-masks_0
new file mode 100755
index 0000000000000..7eb42f08da975
--- /dev/null
+++ b/iptables/tests/shell/testcases/ip6tables/0004-address-masks_0
@@ -0,0 +1,24 @@
+#!/bin/bash
+
+set -e
+
+$XT_MULTI ip6tables-restore <<EOF
+*filter
+-A FORWARD -s feed:babe::/ffff::0
+-A FORWARD -s feed:babe::/ffff:ff00::0
+-A FORWARD -s feed:babe::/ffff:fff0::0
+-A FORWARD -s feed:babe::/ffff:ffff::0
+-A FORWARD -s feed:babe::/0:ffff::0
+-A FORWARD -s feed:c0ff::babe:f00/ffff::ffff:0
+COMMIT
+EOF
+
+EXPECT='-P FORWARD ACCEPT
+-A FORWARD -s feed::/16
+-A FORWARD -s feed:ba00::/24
+-A FORWARD -s feed:bab0::/28
+-A FORWARD -s feed:babe::/32
+-A FORWARD -s 0:babe::/0:ffff::
+-A FORWARD -s feed::babe:0/ffff::ffff:0'
+
+diff -u -Z <(echo -e "$EXPECT") <($XT_MULTI ip6tables -S FORWARD)
-- 
2.28.0

