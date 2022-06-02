Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8007853B4A2
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jun 2022 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiFBHyX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Jun 2022 03:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiFBHyW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:54:22 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89DE0296300
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Jun 2022 00:54:20 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] tests: shell: remove leftover modules on cleanup
Date:   Thu,  2 Jun 2022 09:54:16 +0200
Message-Id: <20220602075416.403873-1-pablo@netfilter.org>
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

After ./run-tests.sh no nf_tables modules are left in place.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/run-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/shell/run-tests.sh b/tests/shell/run-tests.sh
index f77d850ef285..33006d2c63fe 100755
--- a/tests/shell/run-tests.sh
+++ b/tests/shell/run-tests.sh
@@ -87,6 +87,7 @@ kernel_cleanup() {
 	nft_fib nft_fib_ipv4 nft_fib_ipv6 nft_fib_inet \
 	nft_hash nft_ct nft_compat nft_rt nft_objref \
 	nft_set_hash nft_set_rbtree nft_set_bitmap \
+	nft_synproxy nft_connlimit \
 	nft_chain_nat \
 	nft_chain_route_ipv4 nft_chain_route_ipv6 \
 	nft_dup_netdev nft_fwd_netdev \
-- 
2.30.2

