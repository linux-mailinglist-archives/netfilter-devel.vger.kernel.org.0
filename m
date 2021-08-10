Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCF43DE9D0
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Aug 2021 11:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhHCJjP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Aug 2021 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhHCJjD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:39:03 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B04C0617A5
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Aug 2021 02:37:59 -0700 (PDT)
Received: from localhost ([::1]:58044 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mAqs2-0003sI-2c; Tue, 03 Aug 2021 11:37:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] tests/shell: Assert non-verbose mode is silent
Date:   Tue,  3 Aug 2021 11:37:49 +0200
Message-Id: <20210803093749.23493-1-phil@nwl.cc>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Unexpected output from iptables commands might mess up error-checking in
scripts for instance, so do a quick test of the most common commands.

Note: Test adds two rules to make sure flush command operates on a
non-empty chain.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../shell/testcases/iptables/0002-verbose-output_0    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/iptables/tests/shell/testcases/iptables/0002-verbose-output_0 b/iptables/tests/shell/testcases/iptables/0002-verbose-output_0
index b1ef91f61f481..5d2af4c8d2ab2 100755
--- a/iptables/tests/shell/testcases/iptables/0002-verbose-output_0
+++ b/iptables/tests/shell/testcases/iptables/0002-verbose-output_0
@@ -54,3 +54,14 @@ diff -u <(echo "Flushing chain \`foobar'") <($XT_MULTI iptables -v -F foobar)
 diff -u <(echo "Zeroing chain \`foobar'") <($XT_MULTI iptables -v -Z foobar)
 
 diff -u <(echo "Deleting chain \`foobar'") <($XT_MULTI iptables -v -X foobar)
+
+# make sure non-verbose mode is silent
+diff -u <(echo -n "") <(
+	$XT_MULTI iptables -N foobar
+	$XT_MULTI iptables -A foobar $RULE1
+	$XT_MULTI iptables -A foobar $RULE2
+	$XT_MULTI iptables -C foobar $RULE1
+	$XT_MULTI iptables -D foobar $RULE2
+	$XT_MULTI iptables -F foobar
+	$XT_MULTI iptables -X foobar
+)
-- 
2.32.0

