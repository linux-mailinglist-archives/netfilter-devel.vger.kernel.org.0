Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C26FD9B7
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 May 2023 10:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbjEJIld (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 May 2023 04:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjEJIl2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 May 2023 04:41:28 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3A9530DA;
        Wed, 10 May 2023 01:41:21 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net 5/7] selftests: nft_flowtable.sh: wait for specific nc pids
Date:   Wed, 10 May 2023 10:33:11 +0200
Message-Id: <20230510083313.152961-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230510083313.152961-1-pablo@netfilter.org>
References: <20230510083313.152961-1-pablo@netfilter.org>
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

From: Boris Sukholitko <boris.sukholitko@broadcom.com>

Doing wait with no parameters may interfere with some of the tests
having their own background processes.

Although no such test is currently present, the cleanup is useful
to rely on the nft_flowtable.sh for local development (e.g. running
background tcpdump command during the tests).

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tools/testing/selftests/netfilter/nft_flowtable.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/netfilter/nft_flowtable.sh b/tools/testing/selftests/netfilter/nft_flowtable.sh
index 3cf20e9bd3a6..92bc308bf168 100755
--- a/tools/testing/selftests/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/netfilter/nft_flowtable.sh
@@ -296,7 +296,8 @@ test_tcp_forwarding_ip()
 		kill $cpid
 	fi
 
-	wait
+	wait $lpid
+	wait $cpid
 
 	if ! check_transfer "$nsin" "$ns2out" "ns1 -> ns2"; then
 		lret=1
-- 
2.30.2

