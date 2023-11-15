Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE077EC0B9
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Nov 2023 11:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjKOKbb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Nov 2023 05:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjKOKba (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:31:30 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B982210F
        for <netfilter-devel@vger.kernel.org>; Wed, 15 Nov 2023 02:31:27 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 5/4] tests: shell: skip sets/sets_with_ifnames if no pipapo backend is available
Date:   Wed, 15 Nov 2023 11:31:23 +0100
Message-Id: <20231115103123.178743-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Skip this test by now for older kernels until someone detaches the tests
that require the pipapo set backend.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
bonus patch on "more tests/shell updates to run on 5.4 kernels" series

 tests/shell/testcases/sets/sets_with_ifnames | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/shell/testcases/sets/sets_with_ifnames b/tests/shell/testcases/sets/sets_with_ifnames
index 9531c8566631..a4bc5072938e 100755
--- a/tests/shell/testcases/sets/sets_with_ifnames
+++ b/tests/shell/testcases/sets/sets_with_ifnames
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_pipapo)
+
 dumpfile=$(dirname $0)/dumps/$(basename $0).nft
 
 [ -z "$NFT" ] && exit 111
-- 
2.30.2

