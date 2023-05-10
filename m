Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B966FD9BA
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 May 2023 10:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbjEJIlf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 May 2023 04:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjEJIl2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 May 2023 04:41:28 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A36262696;
        Wed, 10 May 2023 01:41:21 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net 6/7] selftests: nft_flowtable.sh: monitor result file sizes
Date:   Wed, 10 May 2023 10:33:12 +0200
Message-Id: <20230510083313.152961-7-pablo@netfilter.org>
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

When running nft_flowtable.sh in VM on a busy server we've found that
the time of the netcat file transfers vary wildly.

Therefore replace hardcoded 3 second sleep with the loop checking for
a change in the file sizes. Once no change in detected we test the results.

Nice side effect is that we shave 1 second sleep in the fast case
(hard-coded 3 second sleep vs two 1 second sleeps).

Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tools/testing/selftests/netfilter/nft_flowtable.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/netfilter/nft_flowtable.sh b/tools/testing/selftests/netfilter/nft_flowtable.sh
index 92bc308bf168..51f986f19fee 100755
--- a/tools/testing/selftests/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/netfilter/nft_flowtable.sh
@@ -286,7 +286,15 @@ test_tcp_forwarding_ip()
 	ip netns exec $nsa nc -w 4 "$dstip" "$dstport" < "$nsin" > "$ns1out" &
 	cpid=$!
 
-	sleep 3
+	sleep 1
+
+	prev="$(ls -l $ns1out $ns2out)"
+	sleep 1
+
+	while [[ "$prev" != "$(ls -l $ns1out $ns2out)" ]]; do
+		sleep 1;
+		prev="$(ls -l $ns1out $ns2out)"
+	done
 
 	if test -d /proc/"$lpid"/; then
 		kill $lpid
-- 
2.30.2

