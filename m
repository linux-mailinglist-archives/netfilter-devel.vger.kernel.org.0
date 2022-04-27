Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62315120EC
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Apr 2022 20:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbiD0Pgu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Apr 2022 11:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiD0Pgt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:36:49 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A10EF338B5
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Apr 2022 08:33:37 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_socket: allow socket expression from prerouting and input only
Date:   Wed, 27 Apr 2022 17:33:33 +0200
Message-Id: <20220427153333.18424-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Just like xt_socket.

Fixes: 554ced0a6e29 ("netfilter: nf_tables: add support for native socket matching")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_socket.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 6d9e8e0a3a7d..963a09fd7174 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -184,6 +184,14 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 					NULL, NFT_DATA_VALUE, len);
 }
 
+static int nft_socket_validate(const struct nft_ctx *ctx,
+			       const struct nft_expr *expr,
+			       const struct nft_data **data)
+{
+	return nft_chain_validate_hooks(ctx->chain, (1 << NF_INET_PRE_ROUTING) |
+						    (1 << NF_INET_LOCAL_IN));
+}
+
 static int nft_socket_dump(struct sk_buff *skb,
 			   const struct nft_expr *expr)
 {
@@ -230,6 +238,7 @@ static const struct nft_expr_ops nft_socket_ops = {
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_socket)),
 	.eval		= nft_socket_eval,
 	.init		= nft_socket_init,
+	.validate	= nft_socket_validate,
 	.dump		= nft_socket_dump,
 	.reduce		= nft_socket_reduce,
 };
-- 
2.30.2

