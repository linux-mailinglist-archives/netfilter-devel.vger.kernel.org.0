Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56925392F6
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 19:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfFGRVg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 13:21:36 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35930 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729829AbfFGRVg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:21:36 -0400
Received: from localhost ([::1]:49020 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hZIYY-0006tW-W7; Fri, 07 Jun 2019 19:21:35 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: [nft PATCH v6 1/5] cache: Fix evaluation for rules with index reference
Date:   Fri,  7 Jun 2019 19:21:17 +0200
Message-Id: <20190607172121.21752-2-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607172121.21752-1-phil@nwl.cc>
References: <20190607172121.21752-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

After parsing input, rule location data (index or handle) is contained
in cmd->handle, not yet in cmd->rule->handle.

Fixes: 7df42800cf89e ("src: single cache_update() call to build cache before evaluation")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/cache.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/cache.c b/src/cache.c
index 2a0f04d12e259..532ef425906ad 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -24,13 +24,7 @@ static unsigned int evaluate_cache_add(struct cmd *cmd)
 		completeness = cmd->op;
 		break;
 	case CMD_OBJ_RULE:
-		/* XXX index is set to zero unless this handle_merge() call is
-		 * invoked, this handle_merge() call is done from the
-		 * evaluation, which is too late.
-		 */
-		handle_merge(&cmd->rule->handle, &cmd->handle);
-
-		if (cmd->rule->handle.index.id)
+		if (cmd->handle.index.id)
 			completeness = CMD_LIST;
 		break;
 	default:
-- 
2.21.0

