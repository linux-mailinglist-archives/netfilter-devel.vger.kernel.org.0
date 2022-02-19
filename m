Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9174BC8B8
	for <lists+netfilter-devel@lfdr.de>; Sat, 19 Feb 2022 14:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiBSNj3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 19 Feb 2022 08:39:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiBSNj2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 19 Feb 2022 08:39:28 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656FF132954
        for <netfilter-devel@vger.kernel.org>; Sat, 19 Feb 2022 05:39:09 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nLPx5-0007aB-V1; Sat, 19 Feb 2022 14:39:07 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH libnftnl] exthdr: tcp option reset support
Date:   Sat, 19 Feb 2022 14:39:04 +0100
Message-Id: <20220219133904.13465-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
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

Adds print debug support for tcp reset feature.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/expr/exthdr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/expr/exthdr.c b/src/expr/exthdr.c
index 1b813b1e47c4..625dd5d3d0a4 100644
--- a/src/expr/exthdr.c
+++ b/src/expr/exthdr.c
@@ -247,10 +247,15 @@ nftnl_expr_exthdr_snprintf(char *buf, size_t len,
 				exthdr->offset,
 				exthdr->flags & NFT_EXTHDR_F_PRESENT ? " present" : "",
 				exthdr->dreg);
-	else
+	else if (e->flags & (1 << NFTNL_EXPR_EXTHDR_SREG))
 		return snprintf(buf, len, "write%s reg %u => %ub @ %u + %u ",
 				op2str(exthdr->op), exthdr->sreg, exthdr->len, exthdr->type,
 				exthdr->offset);
+	else if (exthdr->op == NFT_EXTHDR_OP_TCPOPT && exthdr->len == 0)
+		return snprintf(buf, len, "reset tcpopt %u ", exthdr->type);
+	else
+		return snprintf(buf, len, "op %u len %u type %u offset %u ",
+				exthdr->op, exthdr->len, exthdr->type, exthdr->offset);
 
 }
 
-- 
2.35.1

