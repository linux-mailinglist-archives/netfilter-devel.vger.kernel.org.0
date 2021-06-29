Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CEE3B7209
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Jun 2021 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhF2M26 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Jun 2021 08:28:58 -0400
Received: from mail.netfilter.org ([217.70.188.207]:33894 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhF2M26 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:28:58 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id E771360785
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Jun 2021 14:26:25 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables] cmd: incorrect table location in error reporting
Date:   Tue, 29 Jun 2021 14:26:28 +0200
Message-Id: <20210629122628.6890-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the command refers to an inexisting table, then use the table location.

ruleset.nft:3:12-12: Error: No such file or directory; did you mean table ‘filter’ in family ip?
add rule x x ip saddr @x log prefix "Anti SSH-Bruteforce: " drop
         ^

before this patch location is not correct:

ruleset.nft:3:12-12: Error: No such file or directory; did you mean table ‘filter’ in family ip?
add rule x x ip saddr @x log prefix "Anti SSH-Bruteforce: " drop
           ^

Fixes: 0276c2fee939 ("cmd: check for table mismatch first in error reporting")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cmd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/cmd.c b/src/cmd.c
index a69767c551fe..8d4bf8bc13aa 100644
--- a/src/cmd.c
+++ b/src/cmd.c
@@ -28,12 +28,12 @@ static int nft_cmd_enoent_table(struct netlink_ctx *ctx, const struct cmd *cmd,
 }
 
 static int table_fuzzy_check(struct netlink_ctx *ctx, const struct cmd *cmd,
-			     const struct table *table,
-			     const struct location *loc)
+			     const struct table *table)
 {
 	if (strcmp(cmd->handle.table.name, table->handle.table.name) ||
 	    cmd->handle.family != table->handle.family) {
-		netlink_io_error(ctx, loc, "%s; did you mean table ‘%s’ in family %s?",
+		netlink_io_error(ctx, &cmd->handle.table.location,
+				 "%s; did you mean table ‘%s’ in family %s?",
 				 strerror(ENOENT), table->handle.table.name,
 				 family2str(table->handle.family));
 		return 1;
@@ -56,7 +56,7 @@ static int nft_cmd_enoent_chain(struct netlink_ctx *ctx, const struct cmd *cmd,
 	if (!table)
 		return 0;
 
-	if (table_fuzzy_check(ctx, cmd, table, loc))
+	if (table_fuzzy_check(ctx, cmd, table))
 		return 1;
 
 	if (!chain)
@@ -85,7 +85,7 @@ static int nft_cmd_enoent_rule(struct netlink_ctx *ctx, const struct cmd *cmd,
 	if (!table)
 		return 0;
 
-	if (table_fuzzy_check(ctx, cmd, table, loc))
+	if (table_fuzzy_check(ctx, cmd, table))
 		return 1;
 
 	if (!chain)
@@ -117,7 +117,7 @@ static int nft_cmd_enoent_set(struct netlink_ctx *ctx, const struct cmd *cmd,
 	if (!table)
 		return 0;
 
-	if (table_fuzzy_check(ctx, cmd, table, loc))
+	if (table_fuzzy_check(ctx, cmd, table))
 		return 1;
 
 	if (!set)
@@ -146,7 +146,7 @@ static int nft_cmd_enoent_obj(struct netlink_ctx *ctx, const struct cmd *cmd,
 	if (!table)
 		return 0;
 
-	if (table_fuzzy_check(ctx, cmd, table, loc))
+	if (table_fuzzy_check(ctx, cmd, table))
 		return 1;
 
 	if (!obj)
@@ -175,7 +175,7 @@ static int nft_cmd_enoent_flowtable(struct netlink_ctx *ctx,
 	if (!table)
 		return 0;
 
-	if (table_fuzzy_check(ctx, cmd, table, loc))
+	if (table_fuzzy_check(ctx, cmd, table))
 		return 1;
 
 	if (!ft)
-- 
2.20.1

