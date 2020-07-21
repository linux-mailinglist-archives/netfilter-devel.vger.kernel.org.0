Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9233227361
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jul 2020 02:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGUABb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jul 2020 20:01:31 -0400
Received: from correo.us.es ([193.147.175.20]:35474 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGUABb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:01:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D4DEBD1620
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:01:28 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C64CDDA722
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:01:28 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BBF56DA73D; Tue, 21 Jul 2020 02:01:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 89302DA722
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:01:26 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 Jul 2020 02:01:26 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 6C9124265A32
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:01:26 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] rule: flush set cache after flush command
Date:   Tue, 21 Jul 2020 02:01:22 +0200
Message-Id: <20200721000122.9159-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Flush the set cache before adding the flush command to the netlink batch.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/rule.c b/src/rule.c
index fa1861403ba1..6b71dfee0d09 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -2692,6 +2692,21 @@ static int do_command_reset(struct netlink_ctx *ctx, struct cmd *cmd)
 	return do_list_obj(ctx, cmd, type);
 }
 
+static void flush_set_cache(struct netlink_ctx *ctx, struct cmd *cmd)
+{
+	struct table *table;
+	struct set *set;
+
+	table = table_lookup(&cmd->handle, &ctx->nft->cache);
+	assert(table);
+	set = set_lookup(table, cmd->handle.set.name);
+	assert(set);
+	if (set->init != NULL) {
+		expr_free(set->init);
+		set->init = NULL;
+	}
+}
+
 static int do_command_flush(struct netlink_ctx *ctx, struct cmd *cmd)
 {
 	switch (cmd->obj) {
@@ -2701,6 +2716,7 @@ static int do_command_flush(struct netlink_ctx *ctx, struct cmd *cmd)
 	case CMD_OBJ_SET:
 	case CMD_OBJ_MAP:
 	case CMD_OBJ_METER:
+		flush_set_cache(ctx, cmd);
 		return mnl_nft_setelem_flush(ctx, cmd);
 	case CMD_OBJ_RULESET:
 		return mnl_nft_table_del(ctx, cmd);
-- 
2.20.1

