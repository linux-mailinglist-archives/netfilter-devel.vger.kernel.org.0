Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF7A43D783
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Oct 2021 01:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhJ0Xda (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Oct 2021 19:33:30 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49442 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJ0Xda (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Oct 2021 19:33:30 -0400
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id A411A63F21
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Oct 2021 01:29:14 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] cache: disable NFT_CACHE_SETELEM_BIT on --terse listing only
Date:   Thu, 28 Oct 2021 01:30:57 +0200
Message-Id: <20211027233057.23010-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of NFT_CACHE_SETELEM which also disables set dump.

Fixes: 6bcd0d576a60 ("cache: unset NFT_CACHE_SETELEM with --terse listing")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cache.c b/src/cache.c
index f66b415c038e..0cddd1e1cb48 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -145,7 +145,7 @@ static unsigned int evaluate_cache_list(struct nft_ctx *nft, struct cmd *cmd,
 			filter->set = cmd->handle.set.name;
 		}
 		if (nft_output_terse(&nft->output))
-			flags |= (NFT_CACHE_FULL & ~NFT_CACHE_SETELEM);
+			flags |= (NFT_CACHE_FULL & ~NFT_CACHE_SETELEM_BIT);
 		else if (filter->table && filter->set)
 			flags |= NFT_CACHE_TABLE | NFT_CACHE_SET | NFT_CACHE_SETELEM;
 		else
@@ -163,7 +163,7 @@ static unsigned int evaluate_cache_list(struct nft_ctx *nft, struct cmd *cmd,
 		break;
 	case CMD_OBJ_RULESET:
 		if (nft_output_terse(&nft->output))
-			flags |= (NFT_CACHE_FULL & ~NFT_CACHE_SETELEM);
+			flags |= (NFT_CACHE_FULL & ~NFT_CACHE_SETELEM_BIT);
 		else
 			flags |= NFT_CACHE_FULL;
 		break;
-- 
2.30.2

