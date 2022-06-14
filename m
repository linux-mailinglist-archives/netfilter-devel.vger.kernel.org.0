Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B4854B698
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jun 2022 18:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiFNQpV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Jun 2022 12:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbiFNQpK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:45:10 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B3419037
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Jun 2022 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FfK0amTgHF0IQ+RJHUL0zTKQZuV2qtpNUH7PpFtUQ8g=; b=HyWVP6fghOgLPtKLLTrtUKOwfO
        d7lcozTE3QKKpa/DfGsf0ScI0VMb6Co1eIcd4Ve4VH5bvxf5zrza20WNrDiJyjg4tEj4Kl8O41Z/c
        N6dc+INCRgR/FIpT5r5nzoi8VkXKgPYUQJF2o6XIPGjazFPVMdK/xUA4AO/XEQ9n3UmuyFgipuvEv
        777Qbhrg058C8QpXauORF2nlSPAJyX8fNYzCqfabXqiwDc7PILAmPQZ5c3IIZhhoYeoytao7cNth4
        1wQAc59h8GkVbg1hDa6g3oIpv32PImHeVUFMlVxoeTrdJ/rjvkps2LEq6HoRKgFYlXTLDNU33FDhN
        AfXrYzdw==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1o19f8-0008Af-0y; Tue, 14 Jun 2022 18:45:06 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [iptables PATCH] nft: Exit if nftnl_alloc_expr fails
Date:   Tue, 14 Jun 2022 18:44:57 +0200
Message-Id: <20220614164457.4592-1-phil@nwl.cc>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In some code-paths, 'reg' pointer remaining unallocated is used later so
at least minimal error checking is necessary. Given that a call to
nftnl_alloc_expr() should never fail with sane argument, complain and
exit if it happens.

Fixes: 7e38890c6b4fb ("nft: prepare for dynamic register allocation")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 27e95c1ae4f38..d603e7c9d663b 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -40,15 +40,25 @@ extern struct nft_family_ops nft_family_ops_ipv6;
 extern struct nft_family_ops nft_family_ops_arp;
 extern struct nft_family_ops nft_family_ops_bridge;
 
+static struct nftnl_expr *nftnl_expr_alloc_or_die(const char *name)
+{
+	struct nftnl_expr *expr = nftnl_expr_alloc(name);
+
+	if (expr)
+		return expr;
+
+
+	xtables_error(RESOURCE_PROBLEM,
+		      "Failed to allocate nftnl expression '%s'", name);
+}
+
 void add_meta(struct nft_handle *h, struct nftnl_rule *r, uint32_t key,
 	      uint8_t *dreg)
 {
 	struct nftnl_expr *expr;
 	uint8_t reg;
 
-	expr = nftnl_expr_alloc("meta");
-	if (expr == NULL)
-		return;
+	expr = nftnl_expr_alloc_or_die("meta");
 
 	reg = NFT_REG_1;
 	nftnl_expr_set_u32(expr, NFTNL_EXPR_META_KEY, key);
@@ -64,9 +74,7 @@ void add_payload(struct nft_handle *h, struct nftnl_rule *r,
 	struct nftnl_expr *expr;
 	uint8_t reg;
 
-	expr = nftnl_expr_alloc("payload");
-	if (expr == NULL)
-		return;
+	expr = nftnl_expr_alloc_or_die("payload");
 
 	reg = NFT_REG_1;
 	nftnl_expr_set_u32(expr, NFTNL_EXPR_PAYLOAD_BASE, base);
@@ -85,9 +93,7 @@ void add_bitwise_u16(struct nft_handle *h, struct nftnl_rule *r,
 	struct nftnl_expr *expr;
 	uint8_t reg;
 
-	expr = nftnl_expr_alloc("bitwise");
-	if (expr == NULL)
-		return;
+	expr = nftnl_expr_alloc_or_die("bitwise");
 
 	reg = NFT_REG_1;
 	nftnl_expr_set_u32(expr, NFTNL_EXPR_BITWISE_SREG, sreg);
@@ -107,9 +113,7 @@ void add_bitwise(struct nft_handle *h, struct nftnl_rule *r,
 	uint32_t xor[4] = { 0 };
 	uint8_t reg = *dreg;
 
-	expr = nftnl_expr_alloc("bitwise");
-	if (expr == NULL)
-		return;
+	expr = nftnl_expr_alloc_or_die("bitwise");
 
 	nftnl_expr_set_u32(expr, NFTNL_EXPR_BITWISE_SREG, sreg);
 	nftnl_expr_set_u32(expr, NFTNL_EXPR_BITWISE_DREG, reg);
@@ -126,9 +130,7 @@ void add_cmp_ptr(struct nftnl_rule *r, uint32_t op, void *data, size_t len,
 {
 	struct nftnl_expr *expr;
 
-	expr = nftnl_expr_alloc("cmp");
-	if (expr == NULL)
-		return;
+	expr = nftnl_expr_alloc_or_die("cmp");
 
 	nftnl_expr_set_u32(expr, NFTNL_EXPR_CMP_SREG, sreg);
 	nftnl_expr_set_u32(expr, NFTNL_EXPR_CMP_OP, op);
-- 
2.34.1

