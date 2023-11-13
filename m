Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197567E9D80
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Nov 2023 14:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjKMNpB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Nov 2023 08:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjKMNpA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:45:00 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61A5DD51
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Nov 2023 05:44:57 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] src: expand create commands
Date:   Mon, 13 Nov 2023 14:44:53 +0100
Message-Id: <20231113134453.121975-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

create commands also need to be expanded, otherwise elements are never
evaluated:

 # cat ruleset.nft
 define ip-block-4 = { 1.1.1.1 }
 create set netdev filter ip-block-4-test {
        type ipv4_addr
	flags interval
	auto-merge
	elements = $ip-block-4
 }
 # nft -f ruleset.nft
 BUG: unhandled expression type 0
 nft: src/intervals.c:211: interval_expr_key: Assertion `0' failed.
 Aborted

Same applies to chains in the form of:

 create chain x y {
	counter
 }

which is also accepted by the parser.

Fixes: 56c90a2dd2eb ("evaluate: expand sets and maps before evaluation")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
I will post a v2 includes tests.

 src/libnftables.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/libnftables.c b/src/libnftables.c
index ec902009e002..0dee1bacb0db 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -532,7 +532,8 @@ static int nft_evaluate(struct nft_ctx *nft, struct list_head *msgs,
 		collapsed = true;
 
 	list_for_each_entry(cmd, cmds, list) {
-		if (cmd->op != CMD_ADD)
+		if (cmd->op != CMD_ADD &&
+		    cmd->op != CMD_CREATE)
 			continue;
 
 		nft_cmd_expand(cmd);
-- 
2.30.2

