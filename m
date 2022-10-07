Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A55D5F7543
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Oct 2022 10:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJGIYm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Oct 2022 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJGIYj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:24:39 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6014EC20
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Oct 2022 01:24:35 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] rule: do not display handle for implicit chain
Date:   Fri,  7 Oct 2022 10:24:30 +0200
Message-Id: <20221007082430.333046-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221007082430.333046-1-pablo@netfilter.org>
References: <20221007082430.333046-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Implicit chain do not allow for incremental updates, do not display rule
handle since kernel refuses to update an implicit chain which is already
bound.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1615
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/rule.c b/src/rule.c
index 1caee58fb762..d1ee6c2ee067 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1058,13 +1058,19 @@ static void chain_print_declaration(const struct chain *chain,
 void chain_rules_print(const struct chain *chain, struct output_ctx *octx,
 		       const char *indent)
 {
+	unsigned int flags = octx->flags;
 	struct rule *rule;
 
+	if (chain->flags & CHAIN_F_BINDING)
+		octx->flags &= ~NFT_CTX_OUTPUT_HANDLE;
+
 	list_for_each_entry(rule, &chain->rules, list) {
 		nft_print(octx, "\t\t%s", indent ? : "");
 		rule_print(rule, octx);
 		nft_print(octx, "\n");
 	}
+
+	octx->flags = flags;
 }
 
 static void chain_print(const struct chain *chain, struct output_ctx *octx)
-- 
2.30.2

