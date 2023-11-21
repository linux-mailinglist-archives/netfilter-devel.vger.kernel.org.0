Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE87F2B80
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Nov 2023 12:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjKULLb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Nov 2023 06:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjKULLa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:11:30 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE76E122
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Nov 2023 03:11:23 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: quote reference to array to iterate over empty string
Date:   Tue, 21 Nov 2023 12:11:17 +0100
Message-Id: <20231121111117.17042-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch restores coverage for non-interval set backend.

Use "${FLAGS[@]}" in loop, otherwise empty string is skipped in the
iteration. This snippet:

  FLAGS=("")
  available_flags FLAGS "single"

  for flags in "${FLAGS[@]}" ; do
          echo $flags
  done

... now shows the empty string:

  # bash test.sh

  interval

Fixes: ed927baa4fd8 ("tests: shell: skip pipapo set backend in transactions/30s-stress")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/transactions/30s-stress | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/shell/testcases/transactions/30s-stress b/tests/shell/testcases/transactions/30s-stress
index ef3e1d3e3e4b..e92b922660b8 100755
--- a/tests/shell/testcases/transactions/30s-stress
+++ b/tests/shell/testcases/transactions/30s-stress
@@ -324,7 +324,7 @@ random_elem()
 
 			FLAGS=("")
 			available_flags FLAGS $key
-			for flags in ${FLAGS[@]} ; do
+			for flags in "${FLAGS[@]}" ; do
 				cnt=$((cnt+1))
 				if [ $f -ne fkr ] ;then
 					f=$((f+1))
-- 
2.30.2

