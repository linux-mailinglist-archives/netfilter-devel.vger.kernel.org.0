Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE1958F824
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Aug 2022 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiHKHLG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Aug 2022 03:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHKHLF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:11:05 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58661D90
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Aug 2022 00:11:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oM2LL-0005aM-At; Thu, 11 Aug 2022 09:10:59 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: allow implicit ether -> vlan dep
Date:   Thu, 11 Aug 2022 09:10:55 +0200
Message-Id: <20220811071055.101362-1-fw@strlen.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft add rule inet filter input vlan id 2
Error: conflicting protocols specified: ether vs. vlan

Refresh the current dependency after superseding the dummy
dependency to make this work.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 919c38c5604e..da06ad7e9c7d 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -665,6 +665,7 @@ static int resolve_protocol_conflict(struct eval_ctx *ctx,
 			if (err < 0)
 				return err;
 
+			desc = payload->payload.desc;
 			rule_stmt_insert_at(ctx->rule, nstmt, ctx->stmt);
 		} else {
 			unsigned int i;
-- 
2.37.1

