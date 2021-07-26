Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1543D5AF8
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jul 2021 16:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhGZN0L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Jul 2021 09:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZN0K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:26:10 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EB0C061757
        for <netfilter-devel@vger.kernel.org>; Mon, 26 Jul 2021 07:06:39 -0700 (PDT)
Received: from localhost ([::1]:59640 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1m81Fa-0002Wk-PP; Mon, 26 Jul 2021 16:06:34 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] tests: shell: Fix bogus testsuite failure with 100Hz
Date:   Mon, 26 Jul 2021 16:06:24 +0200
Message-Id: <20210726140624.5757-1-phil@nwl.cc>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On kernels with CONFIG_HZ=100, clock granularity does not allow tracking
timeouts in single digit ms range. Change sets/0031set_timeout_size_0 to
not expose this detail.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/shell/testcases/sets/0031set_timeout_size_0 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/shell/testcases/sets/0031set_timeout_size_0 b/tests/shell/testcases/sets/0031set_timeout_size_0
index 9edd5f6ffdea6..796640d64670a 100755
--- a/tests/shell/testcases/sets/0031set_timeout_size_0
+++ b/tests/shell/testcases/sets/0031set_timeout_size_0
@@ -3,10 +3,10 @@
 RULESET="add table x
 add set x y { type ipv4_addr; size 128; timeout 30s; flags dynamic; }
 add chain x test
-add rule x test set update ip saddr timeout 1d2h3m4s8ms @y
+add rule x test set update ip saddr timeout 1d2h3m4s10ms @y
 add rule x test set update ip daddr timeout 100ms @y"
 
 set -e
 $NFT -f - <<< "$RULESET"
-$NFT list chain x test | grep -q 'update @y { ip saddr timeout 1d2h3m4s8ms }'
+$NFT list chain x test | grep -q 'update @y { ip saddr timeout 1d2h3m4s10ms }'
 $NFT list chain x test | grep -q 'update @y { ip daddr timeout 100ms }'
-- 
2.32.0

