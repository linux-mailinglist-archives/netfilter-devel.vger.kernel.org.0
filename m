Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C5DE7C73
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2019 23:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfJ1Wiv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Oct 2019 18:38:51 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40842 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJ1Wiu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:38:50 -0400
Received: from localhost ([::1]:53932 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iPDey-0005sk-KR; Mon, 28 Oct 2019 23:38:48 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] mnl: Replace use of untyped nftnl data setters
Date:   Mon, 28 Oct 2019 23:38:40 +0100
Message-Id: <20191028223840.10288-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Setting strings won't make a difference, but passing data length to
*_set_data() functions catches accidental changes on either side.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/mnl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/mnl.c b/src/mnl.c
index 75ab07b045aa5..5b0569f37b27e 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -695,7 +695,7 @@ int mnl_nft_table_add(struct netlink_ctx *ctx, const struct cmd *cmd,
 		memory_allocation_error();
 
 	nftnl_table_set_u32(nlt, NFTNL_TABLE_FAMILY, cmd->handle.family);
-	nftnl_table_set(nlt, NFTNL_TABLE_NAME, cmd->handle.table.name);
+	nftnl_table_set_str(nlt, NFTNL_TABLE_NAME, cmd->handle.table.name);
 	if (cmd->table)
 		nftnl_table_set_u32(nlt, NFTNL_TABLE_FLAGS, cmd->table->flags);
 	else
@@ -724,7 +724,8 @@ int mnl_nft_table_del(struct netlink_ctx *ctx, const struct cmd *cmd)
 
 	nftnl_table_set_u32(nlt, NFTNL_TABLE_FAMILY, cmd->handle.family);
 	if (cmd->handle.table.name)
-		nftnl_table_set(nlt, NFTNL_TABLE_NAME, cmd->handle.table.name);
+		nftnl_table_set_str(nlt, NFTNL_TABLE_NAME,
+				    cmd->handle.table.name);
 	else if (cmd->handle.handle.id)
 		nftnl_table_set_u64(nlt, NFTNL_TABLE_HANDLE,
 				    cmd->handle.handle.id);
@@ -1016,8 +1017,9 @@ int mnl_nft_obj_add(struct netlink_ctx *ctx, const struct cmd *cmd,
 		if (obj->ct_timeout.l3proto)
 			nftnl_obj_set_u16(nlo, NFTNL_OBJ_CT_TIMEOUT_L3PROTO,
 					  obj->ct_timeout.l3proto);
-		nftnl_obj_set(nlo, NFTNL_OBJ_CT_TIMEOUT_ARRAY,
-			      obj->ct_timeout.timeout);
+		nftnl_obj_set_data(nlo, NFTNL_OBJ_CT_TIMEOUT_ARRAY,
+				   obj->ct_timeout.timeout,
+				   sizeof(obj->ct_timeout.timeout));
 		break;
 	case NFT_OBJECT_CT_EXPECT:
 		if (obj->ct_expect.l3proto)
@@ -1418,7 +1420,8 @@ int mnl_nft_flowtable_add(struct netlink_ctx *ctx, const struct cmd *cmd,
 		dev_array[i++] = expr->identifier;
 
 	dev_array[i] = NULL;
-	nftnl_flowtable_set(flo, NFTNL_FLOWTABLE_DEVICES, dev_array);
+	nftnl_flowtable_set_data(flo, NFTNL_FLOWTABLE_DEVICES,
+				 dev_array, sizeof(dev_array));
 
 	netlink_dump_flowtable(flo, ctx);
 
-- 
2.23.0

