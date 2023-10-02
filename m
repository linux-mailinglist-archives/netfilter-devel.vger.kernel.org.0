Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EFF7B4EA7
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Oct 2023 11:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbjJBJF2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Oct 2023 05:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjJBJFY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:05:24 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2C3483
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Oct 2023 02:05:21 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nf] netfilter: nf_tables: do not refresh timeout when resetting element
Date:   Mon,  2 Oct 2023 11:05:16 +0200
Message-Id: <20231002090516.3200649-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The dump and reset command should not refresh the timeout, this command
is intended to allow users to list existing stateful objects and reset
them, element expiration should be refresh via transaction instead with
a specific command to achieve this, otherwise this is entering combo
semantics that will be hard to be undone later (eg. a user asking to
retrieve counters but _not_ requiring to refresh expiration).

Fixes: 079cd633219d ("netfilter: nf_tables: Introduce NFT_MSG_GETSETELEM_RESET")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3bb5ea5d4eed..0e375b7a7cad 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5615,9 +5615,6 @@ static int nf_tables_fill_setelem(struct sk_buff *skb,
 				 nf_jiffies64_to_msecs(expires),
 				 NFTA_SET_ELEM_PAD))
 			goto nla_put_failure;
-
-		if (reset)
-			*nft_set_ext_expiration(ext) = now + timeout;
 	}
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_USERDATA)) {
-- 
2.30.2

