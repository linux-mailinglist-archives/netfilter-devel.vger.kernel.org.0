Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722D06F5035
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 May 2023 08:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjECGdD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 May 2023 02:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECGdC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 May 2023 02:33:02 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B28ED3C3F;
        Tue,  2 May 2023 23:32:56 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net 2/3] selftests: netfilter: fix libmnl pkg-config usage
Date:   Wed,  3 May 2023 08:32:49 +0200
Message-Id: <20230503063250.13700-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230503063250.13700-1-pablo@netfilter.org>
References: <20230503063250.13700-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

1. Don't hard-code pkg-config
2. Remove distro-specific default for CFLAGS
3. Use pkg-config for LDLIBS

Fixes: a50a88f026fb ("selftests: netfilter: fix a build error on openSUSE")
Suggested-by: Jan Engelhardt <jengelh@inai.de>
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tools/testing/selftests/netfilter/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index 4504ee07be08..3686bfa6c58d 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -8,8 +8,11 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
 	conntrack_vrf.sh nft_synproxy.sh rpath.sh
 
-CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
-LDLIBS = -lmnl
+HOSTPKG_CONFIG := pkg-config
+
+CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
+LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
+
 TEST_GEN_FILES =  nf-queue connect_close
 
 include ../lib.mk
-- 
2.30.2

