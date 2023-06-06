Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82B6724981
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Jun 2023 18:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbjFFQrw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Jun 2023 12:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237642AbjFFQru (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:47:50 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF0CD10C2
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Jun 2023 09:47:49 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: out-of-bound check in chain blob
Date:   Tue,  6 Jun 2023 18:47:46 +0200
Message-Id: <20230606164746.2319-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add current size of rule expressions to the boundary check.

Fixes: 2c865a8a28a1 ("netfilter: nf_tables: add rule blob layout")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 36de86136e9d..69e21a656029 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9005,7 +9005,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 				continue;
 			}
 
-			if (WARN_ON_ONCE(data + expr->ops->size > data_boundary))
+			if (WARN_ON_ONCE(data + size + expr->ops->size > data_boundary))
 				return -ENOMEM;
 
 			memcpy(data + size, expr, expr->ops->size);
-- 
2.30.2

