Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F941782B3F
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Aug 2023 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjHUONL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Aug 2023 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjHUONL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:13:11 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB30BE8
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Aug 2023 07:13:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qY5eN-0003WE-Fd; Mon, 21 Aug 2023 16:12:59 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] parser: permit gc-interval in map declarations
Date:   Mon, 21 Aug 2023 16:12:52 +0200
Message-ID: <20230821141254.32514-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
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

Maps support timeouts, so allow to set the gc interval as well.

Fixes: 949cc39eb93f ("parser: support of maps with timeout")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/parser_bison.y | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 5637829332ce..7b8eac9577ef 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -2237,6 +2237,11 @@ map_block		:	/* empty */	{ $$ = $<set>-1; }
 				$1->timeout = $3;
 				$$ = $1;
 			}
+			|	map_block	GC_INTERVAL	time_spec	stmt_separator
+			{
+				$1->gc_int = $3;
+				$$ = $1;
+			}
 			|	map_block	TYPE
 						data_type_expr	COLON	map_block_data_interval data_type_expr
 						stmt_separator	close_scope_type
-- 
2.41.0

