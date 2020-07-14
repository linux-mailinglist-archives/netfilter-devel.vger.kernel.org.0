Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF4D21F7B6
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2020 18:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgGNQ4K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Jul 2020 12:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgGNQ4K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:56:10 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1974C061755
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Jul 2020 09:56:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1jvODw-0001Lc-M7; Tue, 14 Jul 2020 18:56:08 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 2/2] tests: extend existing dormat test case to catch a kernel bug
Date:   Tue, 14 Jul 2020 18:55:58 +0200
Message-Id: <20200714165558.14733-2-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714165558.14733-1-fw@strlen.de>
References: <20200714165558.14733-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is a test case for the kernel bug fixed by:
  netfilter: nf_tables: fix nat hook table deletion

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/testcases/transactions/0002table_0           | 1 +
 tests/shell/testcases/transactions/dumps/0002table_0.nft | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tests/shell/testcases/transactions/0002table_0 b/tests/shell/testcases/transactions/0002table_0
index 246b10924d19..c5f31a6fb401 100755
--- a/tests/shell/testcases/transactions/0002table_0
+++ b/tests/shell/testcases/transactions/0002table_0
@@ -5,6 +5,7 @@ set -e
 RULESET="add table x
 delete table x
 add table x
+add chain x y { type nat hook prerouting priority 0; policy accept; }
 add table x { flags dormant; }"
 
 $NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/transactions/dumps/0002table_0.nft b/tests/shell/testcases/transactions/dumps/0002table_0.nft
index 6eb70726385f..429cbc348781 100644
--- a/tests/shell/testcases/transactions/dumps/0002table_0.nft
+++ b/tests/shell/testcases/transactions/dumps/0002table_0.nft
@@ -1,3 +1,7 @@
 table ip x {
 	flags dormant
+
+	chain y {
+		type nat hook prerouting priority filter; policy accept;
+	}
 }
-- 
2.26.2

