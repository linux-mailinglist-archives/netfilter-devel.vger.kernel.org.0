Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1150D56E
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 Apr 2022 23:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiDXV71 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 24 Apr 2022 17:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiDXV70 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 24 Apr 2022 17:59:26 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DFE6393E1
        for <netfilter-devel@vger.kernel.org>; Sun, 24 Apr 2022 14:56:25 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH iptables 6/7] nft: split gen_payload() to allocate register and initialize expression
Date:   Sun, 24 Apr 2022 23:56:12 +0200
Message-Id: <20220424215613.106165-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220424215613.106165-1-pablo@netfilter.org>
References: <20220424215613.106165-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add __gen_payload(), in preparation for the dynamic register allocation.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/nft.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index bdfef0244b38..07653ee1a3d6 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1090,20 +1090,30 @@ static struct nftnl_set *add_anon_set(struct nft_handle *h, const char *table,
 }
 
 static struct nftnl_expr *
-gen_payload(struct nft_handle *h, uint32_t base, uint32_t offset, uint32_t len,
-	    uint8_t *dreg)
+__gen_payload(uint32_t base, uint32_t offset, uint32_t len, uint8_t reg)
 {
 	struct nftnl_expr *e = nftnl_expr_alloc("payload");
-	uint8_t reg;
 
 	if (!e)
 		return NULL;
 
-	reg = NFT_REG_1;
 	nftnl_expr_set_u32(e, NFTNL_EXPR_PAYLOAD_BASE, base);
 	nftnl_expr_set_u32(e, NFTNL_EXPR_PAYLOAD_OFFSET, offset);
 	nftnl_expr_set_u32(e, NFTNL_EXPR_PAYLOAD_LEN, len);
 	nftnl_expr_set_u32(e, NFTNL_EXPR_PAYLOAD_DREG, reg);
+
+	return e;
+}
+
+static struct nftnl_expr *
+gen_payload(struct nft_handle *h, uint32_t base, uint32_t offset, uint32_t len,
+	    uint8_t *dreg)
+{
+	struct nftnl_expr *e;
+	uint8_t reg;
+
+	reg = NFT_REG_1;
+	e = __gen_payload(base, offset, len, reg);
 	*dreg = reg;
 
 	return e;
-- 
2.30.2

