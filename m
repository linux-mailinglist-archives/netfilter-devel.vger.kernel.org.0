Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FEC735EA4
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Jun 2023 22:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjFSUnY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Jun 2023 16:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjFSUnX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:43:23 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A93F9
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Jun 2023 13:43:16 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qBLiV-0003qt-JT; Mon, 19 Jun 2023 22:43:15 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 1/6] json: dccp: remove erroneous const qualifier
Date:   Mon, 19 Jun 2023 22:43:01 +0200
Message-Id: <20230619204306.11785-2-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230619204306.11785-1-fw@strlen.de>
References: <20230619204306.11785-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This causes a clang warning:

parser_json.c:767:6: warning: variable 'opt_type' is uninitialized when used here [-Wuninitialized]
if (opt_type < DCCPOPT_TYPE_MIN || opt_type > DCCPOPT_TYPE_MAX) {
            ^~~~~~~~
... because it deduces the object is readonly.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/parser_json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/parser_json.c b/src/parser_json.c
index f1cc39505382..c1e15ee186f5 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -759,7 +759,7 @@ static struct expr *json_parse_sctp_chunk_expr(struct json_ctx *ctx,
 static struct expr *json_parse_dccp_option_expr(struct json_ctx *ctx,
 						const char *type, json_t *root)
 {
-	const int opt_type;
+	int opt_type;
 
 	if (json_unpack_err(ctx, root, "{s:i}", "type", &opt_type))
 		return NULL;
-- 
2.39.3

