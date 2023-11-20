Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E27F13D3
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Nov 2023 13:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjKTMzu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Nov 2023 07:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjKTMzt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:55:49 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1F510C
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Nov 2023 04:55:45 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1r53oV-0005rw-Bb; Mon, 20 Nov 2023 13:55:43 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] tests: shell: skip ct expectation test if feature is missing
Date:   Mon, 20 Nov 2023 13:55:36 +0100
Message-ID: <20231120125538.19463-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 tests/shell/testcases/nft-f/0018ct_expectation_obj_0 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/shell/testcases/nft-f/0018ct_expectation_obj_0 b/tests/shell/testcases/nft-f/0018ct_expectation_obj_0
index 4f9872f63130..b288457c726e 100755
--- a/tests/shell/testcases/nft-f/0018ct_expectation_obj_0
+++ b/tests/shell/testcases/nft-f/0018ct_expectation_obj_0
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# NFT_TEST_REQUIRES(NFT_TEST_HAVE_ctexpect)
+
 EXPECTED='table ip filter {
 	ct expectation ctexpect{
 		protocol tcp
-- 
2.41.0

