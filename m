Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1135266B7
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 May 2022 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378196AbiEMQDW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 May 2022 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381602AbiEMQDV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 May 2022 12:03:21 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F67EB87
        for <netfilter-devel@vger.kernel.org>; Fri, 13 May 2022 09:03:20 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] netlink_delinearize: release last register on exit
Date:   Fri, 13 May 2022 18:03:16 +0200
Message-Id: <20220513160316.792537-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

netlink_release_registers() does not release the expression in the last
32-bit register.

struct netlink_parse_ctx {
	...
        struct expr             *registers[MAX_REGS + 1];

This array is MAX_REGS + 1 (verdict register + 16 32-bit registers).

Fixes: 371c3a0bc3c2 ("netlink_delinearize: release expressions in context registers")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/netlink_delinearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index a1b00dee209a..068c3bba1159 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -100,7 +100,7 @@ static void netlink_release_registers(struct netlink_parse_ctx *ctx)
 {
 	int i;
 
-	for (i = 0; i < MAX_REGS; i++)
+	for (i = 0; i <= MAX_REGS; i++)
 		expr_free(ctx->registers[i]);
 }
 
-- 
2.30.2

