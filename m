Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814055BE685
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Sep 2022 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiITM5f (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Sep 2022 08:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiITM5d (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:57:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C019DA2
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Sep 2022 05:57:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oacod-0008CJ-IH; Tue, 20 Sep 2022 14:57:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: un-break rule insert with intervals
Date:   Tue, 20 Sep 2022 14:57:26 +0200
Message-Id: <20220920125726.5818-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

'rule inet dscpclassify dscp_match  meta l4proto { udp }  th dport { 3478 }  th sport { 3478-3497, 16384-16387 } goto ct_set_ef'
works with 'nft add', but not 'nft insert', the latter yields: "BUG: unhandled op 4".

Fixes: 81e36530fcac ("src: replace interval segment tree overlap and automerge")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index d9c9ca28a53a..edebd7bcd8ab 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1520,6 +1520,7 @@ static int interval_set_eval(struct eval_ctx *ctx, struct set *set,
 	switch (ctx->cmd->op) {
 	case CMD_CREATE:
 	case CMD_ADD:
+	case CMD_INSERT:
 		if (set->automerge) {
 			ret = set_automerge(ctx->msgs, ctx->cmd, set, init,
 					    ctx->nft->debug_mask);
-- 
2.35.1

