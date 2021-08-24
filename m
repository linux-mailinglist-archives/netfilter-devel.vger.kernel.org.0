Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC10E3F5B9C
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Aug 2021 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhHXKFQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Aug 2021 06:05:16 -0400
Received: from mail.netfilter.org ([217.70.188.207]:42852 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbhHXKFL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:05:11 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4840D60243
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Aug 2021 12:03:30 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] cache: skip set element netlink dump for add/delete element command
Date:   Tue, 24 Aug 2021 12:04:18 +0200
Message-Id: <20210824100418.29423-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add NFT_CACHE_SETELEM_MAYBE to dump the set elements conditionally,
only in case that the set interval flag is set on.

Reported-by: Cristian Constantin <const.crist@googlemail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/cache.h |  1 +
 src/cache.c     | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/cache.h b/include/cache.h
index ad9078432c73..70aaf735f7d9 100644
--- a/include/cache.h
+++ b/include/cache.h
@@ -32,6 +32,7 @@ enum cache_level_flags {
 				  NFT_CACHE_CHAIN_BIT |
 				  NFT_CACHE_RULE_BIT,
 	NFT_CACHE_FULL		= __NFT_CACHE_MAX_BIT - 1,
+	NFT_CACHE_SETELEM_MAYBE	= (1 << 28),
 	NFT_CACHE_REFRESH	= (1 << 29),
 	NFT_CACHE_UPDATE	= (1 << 30),
 	NFT_CACHE_FLUSHED	= (1 << 31),
diff --git a/src/cache.c b/src/cache.c
index ff63e59eaafc..8300ce8e707a 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -38,7 +38,7 @@ static unsigned int evaluate_cache_add(struct cmd *cmd, unsigned int flags)
 			 NFT_CACHE_CHAIN |
 			 NFT_CACHE_SET |
 			 NFT_CACHE_OBJECT |
-			 NFT_CACHE_SETELEM;
+			 NFT_CACHE_SETELEM_MAYBE;
 		break;
 	case CMD_OBJ_RULE:
 		flags |= NFT_CACHE_TABLE |
@@ -62,7 +62,7 @@ static unsigned int evaluate_cache_del(struct cmd *cmd, unsigned int flags)
 {
 	switch (cmd->obj) {
 	case CMD_OBJ_ELEMENTS:
-		flags |= NFT_CACHE_SETELEM;
+		flags |= NFT_CACHE_SETELEM_MAYBE;
 		break;
 	default:
 		break;
@@ -600,6 +600,18 @@ static int cache_init_objects(struct netlink_ctx *ctx, unsigned int flags)
 		}
 		if (flags & NFT_CACHE_SETELEM_BIT) {
 			list_for_each_entry(set, &table->set_cache.list, cache.list) {
+				ret = netlink_list_setelems(ctx, &set->handle,
+							    set);
+				if (ret < 0) {
+					ret = -1;
+					goto cache_fails;
+				}
+			}
+		} else if (flags & NFT_CACHE_SETELEM_MAYBE) {
+			list_for_each_entry(set, &table->set_cache.list, cache.list) {
+				if (!set_is_non_concat_range(set))
+					continue;
+
 				ret = netlink_list_setelems(ctx, &set->handle,
 							    set);
 				if (ret < 0) {
-- 
2.20.1

