Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3043A62B
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Oct 2021 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhJYVxG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Oct 2021 17:53:06 -0400
Received: from mail.netfilter.org ([217.70.188.207]:43556 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhJYVxC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:53:02 -0400
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0C29763F31
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Oct 2021 23:48:52 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/4] cache: always set on NFT_CACHE_REFRESH for listing
Date:   Mon, 25 Oct 2021 23:50:30 +0200
Message-Id: <20211025215032.1073625-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025215032.1073625-1-pablo@netfilter.org>
References: <20211025215032.1073625-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This flag forces a refresh of the cache on list commands, several
object types are missing this flag.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cache.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/cache.c b/src/cache.c
index c602f93a3ec6..3cbf99e8e124 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -136,7 +136,7 @@ static unsigned int evaluate_cache_list(struct nft_ctx *nft, struct cmd *cmd,
 		if (filter && cmd->handle.table.name)
 			filter->table = cmd->handle.table.name;
 
-		flags |= NFT_CACHE_FULL | NFT_CACHE_REFRESH;
+		flags |= NFT_CACHE_FULL;
 		break;
 	case CMD_OBJ_SET:
 	case CMD_OBJ_MAP:
@@ -145,9 +145,9 @@ static unsigned int evaluate_cache_list(struct nft_ctx *nft, struct cmd *cmd,
 			filter->set = cmd->handle.set.name;
 		}
 		if (nft_output_terse(&nft->output))
-			flags |= (NFT_CACHE_FULL & ~NFT_CACHE_SETELEM) | NFT_CACHE_REFRESH;
+			flags |= (NFT_CACHE_FULL & ~NFT_CACHE_SETELEM);
 		else
-			flags |= NFT_CACHE_FULL | NFT_CACHE_REFRESH;
+			flags |= NFT_CACHE_FULL;
 		break;
 	case CMD_OBJ_CHAINS:
 		flags |= NFT_CACHE_TABLE | NFT_CACHE_CHAIN;
@@ -161,13 +161,14 @@ static unsigned int evaluate_cache_list(struct nft_ctx *nft, struct cmd *cmd,
 		break;
 	case CMD_OBJ_RULESET:
 		if (nft_output_terse(&nft->output))
-			flags |= (NFT_CACHE_FULL & ~NFT_CACHE_SETELEM) | NFT_CACHE_REFRESH;
+			flags |= (NFT_CACHE_FULL & ~NFT_CACHE_SETELEM);
 		else
-			flags |= NFT_CACHE_FULL | NFT_CACHE_REFRESH;
+			flags |= NFT_CACHE_FULL;
 	default:
-		flags |= NFT_CACHE_FULL | NFT_CACHE_REFRESH;
+		flags |= NFT_CACHE_FULL;
 		break;
 	}
+	flags |= NFT_CACHE_REFRESH;
 
 	return flags;
 }
-- 
2.30.2

