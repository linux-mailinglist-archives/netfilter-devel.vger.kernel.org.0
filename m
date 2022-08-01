Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135FE586C5C
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Aug 2022 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiHAN5H (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Aug 2022 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiHAN5H (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:57:07 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFE6175
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Aug 2022 06:57:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oIVuq-0000iB-NL; Mon, 01 Aug 2022 15:57:04 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH nft v2 6/8] netlink_delinearize: also postprocess OP_AND in set element context
Date:   Mon,  1 Aug 2022 15:56:31 +0200
Message-Id: <20220801135633.5317-7-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801135633.5317-1-fw@strlen.de>
References: <20220801135633.5317-1-fw@strlen.de>
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

Pablo reports:
add rule netdev nt y update @macset { vlan id timeout 5s }

listing still shows the raw expression:
 update @macset { @ll,112,16 & 0xfff timeout 5s }

so also cover the 'set element' case.

Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: new.

 include/netlink.h                                  |  4 +++-
 src/netlink_delinearize.c                          |  2 ++
 .../sets/dumps/0070stacked_l2_headers.nft          | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/netlink.h b/include/netlink.h
index 71c888fa0b40..63d07edf419e 100644
--- a/include/netlink.h
+++ b/include/netlink.h
@@ -44,8 +44,10 @@ struct netlink_parse_ctx {
 
 
 #define RULE_PP_IN_CONCATENATION	(1 << 0)
+#define RULE_PP_IN_SET_ELEM		(1 << 1)
 
-#define RULE_PP_REMOVE_OP_AND		(RULE_PP_IN_CONCATENATION)
+#define RULE_PP_REMOVE_OP_AND		(RULE_PP_IN_CONCATENATION | \
+					 RULE_PP_IN_SET_ELEM)
 
 struct rule_pp_ctx {
 	struct proto_ctx	pctx;
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 8851043bf277..0da6cc78f94f 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2661,7 +2661,9 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
 		expr_postprocess(ctx, &expr->prefix);
 		break;
 	case EXPR_SET_ELEM:
+		ctx->flags |= RULE_PP_IN_SET_ELEM;
 		expr_postprocess(ctx, &expr->key);
+		ctx->flags &= ~RULE_PP_IN_SET_ELEM;
 		break;
 	case EXPR_EXTHDR:
 		exthdr_dependency_kill(&ctx->pdctx, expr, ctx->pctx.family);
diff --git a/tests/shell/testcases/sets/dumps/0070stacked_l2_headers.nft b/tests/shell/testcases/sets/dumps/0070stacked_l2_headers.nft
index ef254b96879e..0057e9c62e4d 100644
--- a/tests/shell/testcases/sets/dumps/0070stacked_l2_headers.nft
+++ b/tests/shell/testcases/sets/dumps/0070stacked_l2_headers.nft
@@ -1,14 +1,28 @@
 table netdev nt {
+	set vlanidset {
+		typeof vlan id
+		size 1024
+		flags dynamic,timeout
+	}
+
 	set macset {
 		typeof ether saddr . vlan id
 		size 1024
 		flags dynamic,timeout
 	}
 
+	set ipset {
+		typeof vlan id . ip saddr
+		size 1024
+		flags dynamic,timeout
+	}
+
 	chain nc {
 		update @macset { ether saddr . vlan id timeout 5s } counter packets 0 bytes 0
 		ether saddr . vlan id @macset
 		vlan pcp 1
 		ether saddr 0a:0b:0c:0d:0e:0f vlan id 42
+		update @vlanidset { vlan id timeout 5s } counter packets 0 bytes 0
+		update @ipset { vlan id . ip saddr timeout 5s } counter packets 0 bytes 0
 	}
 }
-- 
2.35.1

