Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD72938AFC0
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 May 2021 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbhETNQJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 May 2021 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbhETNQI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 May 2021 09:16:08 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A3C061574
        for <netfilter-devel@vger.kernel.org>; Thu, 20 May 2021 06:14:46 -0700 (PDT)
Received: from localhost ([::1]:59894 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1ljiVf-0000uv-6x; Thu, 20 May 2021 15:14:43 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] expr_postprocess: Avoid an unintended fall through
Date:   Thu, 20 May 2021 15:14:34 +0200
Message-Id: <20210520131434.18344-1-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Parsing a range expression, the switch case fell through to prefix
expression case, thereby recursing once more for expr->left. This seems
not to have caused harm, but is certainly not intended.

Fixes: ee4391d0ac1e7 ("nat: transform range to prefix expression when possible")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/netlink_delinearize.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 75869d330ef4d..a71d06d7fe12f 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -2450,6 +2450,7 @@ static void expr_postprocess(struct rule_pp_ctx *ctx, struct expr **exprp)
 	case EXPR_RANGE:
 		expr_postprocess(ctx, &expr->left);
 		expr_postprocess(ctx, &expr->right);
+		break;
 	case EXPR_PREFIX:
 		expr_postprocess(ctx, &expr->prefix);
 		break;
-- 
2.31.1

