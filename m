Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1BF7F060E
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Nov 2023 13:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjKSMGM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Nov 2023 07:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSMGL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Nov 2023 07:06:11 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A7D8
        for <netfilter-devel@vger.kernel.org>; Sun, 19 Nov 2023 04:06:06 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1r4gYu-0007x1-84; Sun, 19 Nov 2023 13:06:04 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Tino Reichardt <milky-netfilter@mcmilk.de>
Subject: [PATCH nft] evaluate: fix rule replacement with anon sets
Date:   Sun, 19 Nov 2023 13:05:55 +0100
Message-ID: <20231119120600.347213-1-fw@strlen.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft replace rule t c handle 3 'jhash ip protocol . ip saddr mod 170 vmap { 0-94 : goto wan1, 95-169 : goto wan2, 170-269 }"'
BUG: unhandled op 2
nft: src/evaluate.c:1748: interval_set_eval: Assertion `0' failed.

Fixes: 81e36530fcac ("src: replace interval segment tree overlap and automerge")
Reported-by: Tino Reichardt <milky-netfilter@mcmilk.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index d1ec6ec4a74d..13b6a603de22 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1729,6 +1729,7 @@ static int interval_set_eval(struct eval_ctx *ctx, struct set *set,
 	switch (ctx->cmd->op) {
 	case CMD_CREATE:
 	case CMD_ADD:
+	case CMD_REPLACE:
 	case CMD_INSERT:
 		if (set->automerge) {
 			ret = set_automerge(ctx->msgs, ctx->cmd, set, init,
-- 
2.42.0

