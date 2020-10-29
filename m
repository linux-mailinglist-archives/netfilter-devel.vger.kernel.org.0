Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A458C29EC47
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Oct 2020 13:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgJ2Mtu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Oct 2020 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2Mtu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:49:50 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046D1C0613CF
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Oct 2020 05:49:50 -0700 (PDT)
Received: from localhost ([::1]:34964 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kY7NE-0006Ux-4V; Thu, 29 Oct 2020 13:49:48 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] tests/shell: Improve fix in sets/0036add_set_element_expiration_0
Date:   Thu, 29 Oct 2020 13:49:51 +0100
Message-Id: <20201029124951.13521-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Explicitly eliminate the newgen message from output instead of just the
last line to make sure no other output is dropped by accident. This also
allows the test to pass in unpatched kernels which do not emit the
newgen message despite NLM_F_ECHO if no netlink listeners are present.

Fixes: 46b54fdcf266d ("Revert "monitor: do not print generation ID with --echo"")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/shell/testcases/sets/0036add_set_element_expiration_0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/shell/testcases/sets/0036add_set_element_expiration_0 b/tests/shell/testcases/sets/0036add_set_element_expiration_0
index 7b2e39a3f0406..3097d077506ca 100755
--- a/tests/shell/testcases/sets/0036add_set_element_expiration_0
+++ b/tests/shell/testcases/sets/0036add_set_element_expiration_0
@@ -6,7 +6,7 @@ RULESET="add table ip x
 add set ip x y { type ipv4_addr; flags dynamic,timeout; } 
 add element ip x y { 1.1.1.1 timeout 30s expires 15s }"
 
-test_output=$($NFT -e -f - <<< "$RULESET" 2>&1 | head -n -1)
+test_output=$($NFT -e -f - <<< "$RULESET" 2>&1 | grep -v '# new generation')
 
 if [ "$test_output" != "$RULESET" ] ; then
 	$DIFF -u <(echo "$test_output") <(echo "$RULESET")
-- 
2.28.0

