Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E916D6575
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Apr 2023 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjDDOev (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Apr 2023 10:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjDDOeq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:34:46 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D67C4268C
        for <netfilter-devel@vger.kernel.org>; Tue,  4 Apr 2023 07:34:45 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 3/4] netlink_delinearize: do not reset protocol context for nat protocol expression
Date:   Tue,  4 Apr 2023 16:34:36 +0200
Message-Id: <20230404143437.133493-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230404143437.133493-1-pablo@netfilter.org>
References: <20230404143437.133493-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch reverts 403b46ada490 ("netlink_delinearize: kill dependency
before eval of 'redirect' stmt"). Since ("evaluate: bogus missing
transport protocol"), this workaround is not required anymore.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/netlink_delinearize.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index fd166eb15c01..935a6667a1c7 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -3375,10 +3375,8 @@ static void rule_parse_postprocess(struct netlink_parse_ctx *ctx, struct rule *r
 		case STMT_NAT:
 			if (stmt->nat.addr != NULL)
 				expr_postprocess(&rctx, &stmt->nat.addr);
-			if (stmt->nat.proto != NULL) {
-				payload_dependency_reset(&dl->pdctx);
+			if (stmt->nat.proto != NULL)
 				expr_postprocess(&rctx, &stmt->nat.proto);
-			}
 			break;
 		case STMT_TPROXY:
 			if (stmt->tproxy.addr)
-- 
2.30.2

