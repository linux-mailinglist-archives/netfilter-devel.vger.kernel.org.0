Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA60AFC96E
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Nov 2019 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfKNPDK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 14 Nov 2019 10:03:10 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:52898 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfKNPDK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:03:10 -0500
Received: from localhost ([::1]:37756 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iVGeK-0004ja-KY; Thu, 14 Nov 2019 16:03:08 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] cache: Reduce caching for get command
Date:   Thu, 14 Nov 2019 16:03:05 +0100
Message-Id: <20191114150305.18704-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Introduce a function to distinguish which command object was given and
request only the necessary bits to have sets and their elements
available for 'get element' command.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/cache.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/cache.c b/src/cache.c
index a778650ac133a..0c28a28d3b554 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -63,6 +63,21 @@ static unsigned int evaluate_cache_del(struct cmd *cmd, unsigned int flags)
 	return flags;
 }
 
+static unsigned int evaluate_cache_get(struct cmd *cmd, unsigned int flags)
+{
+	switch (cmd->obj) {
+	case CMD_OBJ_SETELEM:
+		flags |= NFT_CACHE_TABLE |
+			 NFT_CACHE_SET |
+			 NFT_CACHE_SETELEM;
+		break;
+	default:
+		break;
+	}
+
+	return flags;
+}
+
 static unsigned int evaluate_cache_flush(struct cmd *cmd, unsigned int flags)
 {
 	switch (cmd->obj) {
@@ -121,6 +136,8 @@ unsigned int cache_evaluate(struct nft_ctx *nft, struct list_head *cmds)
 			flags = evaluate_cache_del(cmd, flags);
 			break;
 		case CMD_GET:
+			flags = evaluate_cache_get(cmd, flags);
+			break;
 		case CMD_LIST:
 		case CMD_RESET:
 		case CMD_EXPORT:
-- 
2.24.0

