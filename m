Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E256C13E4
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Mar 2023 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCTNrQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Mar 2023 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjCTNrQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:47:16 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6CE271F
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Mar 2023 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=R5Z1iOTQIOYy2mGTOe1jn33jFBYFGlj/1pxOFVtRSMY=; b=Ou2pcCqMdzyB/Z/rRBp99+S25j
        B9d6PWlApPUy3V0k9Awcyqbrz7zGRxAmLMK9rc27Kl1VUtzLNdxqJ1eNDJr5ZX9wj1z5rQv0ICKMA
        CsZT1Q2OOh0DO6POUXV1kckKoocGlD+BdoZVb9CXLUS5k8VKbShCcv0/LXZOE1OWgPiwIPoeb9mb8
        jAHouwvXVoY8xuzeAUuwJn8oefFwOLyJgJKwBQo7+ohx7wIGZzwUxKgq1Cnl4NtFfE8GF/vh8OrsM
        B+xAXrfN1+/AEwF381honnhdA/jUrCwMXg4tzbeHdnzxl+QU+/DlO7V6GDlbmQSs0sVNnCCNC93RV
        gEVJaplw==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1peFqz-0006zb-Gc; Mon, 20 Mar 2023 14:47:13 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 1/2] Reduce signature of do_list_table()
Date:   Mon, 20 Mar 2023 14:46:58 +0100
Message-Id: <20230320134659.13731-1-phil@nwl.cc>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since commit 16fac7d11bdf5 ("src: use cache infrastructure for rule
objects"), the function does not use the passed 'cmd' object anymore.
Remove it to affirm correctness of a follow-up fix and simplification in
do_list_ruleset().

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/rule.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/rule.c b/src/rule.c
index a04063f7faf7d..fadd7670d97a2 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1553,8 +1553,7 @@ static int do_command_delete(struct netlink_ctx *ctx, struct cmd *cmd)
 	}
 }
 
-static int do_list_table(struct netlink_ctx *ctx, struct cmd *cmd,
-			 struct table *table)
+static int do_list_table(struct netlink_ctx *ctx, struct table *table)
 {
 	table_print(table, &ctx->nft->output);
 	return 0;
@@ -2188,7 +2187,7 @@ static int do_list_ruleset(struct netlink_ctx *ctx, struct cmd *cmd)
 		cmd->handle.family = table->handle.family;
 		cmd->handle.table.name = table->handle.table.name;
 
-		if (do_list_table(ctx, cmd, table) < 0)
+		if (do_list_table(ctx, table) < 0)
 			return -1;
 	}
 
@@ -2319,7 +2318,7 @@ static int do_command_list(struct netlink_ctx *ctx, struct cmd *cmd)
 	case CMD_OBJ_TABLE:
 		if (!cmd->handle.table.name)
 			return do_list_tables(ctx, cmd);
-		return do_list_table(ctx, cmd, table);
+		return do_list_table(ctx, table);
 	case CMD_OBJ_CHAIN:
 		return do_list_chain(ctx, cmd, table);
 	case CMD_OBJ_CHAINS:
-- 
2.38.0

