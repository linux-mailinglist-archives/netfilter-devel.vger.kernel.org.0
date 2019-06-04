Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F21C34EE7
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Jun 2019 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFDRco (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Jun 2019 13:32:44 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:56496 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfFDRco (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:32:44 -0400
Received: from localhost ([::1]:41352 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hYDIg-0000oL-Ap; Tue, 04 Jun 2019 19:32:42 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>
Subject: [nft PATCH v5 04/10] libnftables: Keep list of commands in nft context
Date:   Tue,  4 Jun 2019 19:31:52 +0200
Message-Id: <20190604173158.1184-5-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604173158.1184-1-phil@nwl.cc>
References: <20190604173158.1184-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

To fix the pending issues with cache updates, the list of commands needs
to be accessible from within cache_update(). In theory, there is a path
via nft->state->cmds but that struct parser_state is used (and
initialized) by bison parser only so that does not work with JSON
parser.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/nftables.h |  1 +
 src/libnftables.c  | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/nftables.h b/include/nftables.h
index bb9bb2091716d..faacf26509104 100644
--- a/include/nftables.h
+++ b/include/nftables.h
@@ -102,6 +102,7 @@ struct nft_ctx {
 	struct parser_state	*state;
 	void			*scanner;
 	void			*json_root;
+	struct list_head	cmds;
 	FILE			*f[MAX_INCLUDE_DEPTH];
 };
 
diff --git a/src/libnftables.c b/src/libnftables.c
index e928ce476a90f..b53b3f2ecfece 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -152,6 +152,7 @@ struct nft_ctx *nft_ctx_new(uint32_t flags)
 	nft_ctx_add_include_path(ctx, DEFAULT_INCLUDE_PATH);
 	ctx->parser_max_errors	= 10;
 	init_list_head(&ctx->cache.list);
+	init_list_head(&ctx->cmds);
 	ctx->flags = flags;
 	ctx->output.output_fp = stdout;
 	ctx->output.error_fp = stderr;
@@ -351,7 +352,7 @@ static int nft_parse_bison_buffer(struct nft_ctx *nft, const char *buf,
 	struct cmd *cmd;
 	int ret;
 
-	parser_init(nft, nft->state, msgs, cmds);
+	parser_init(nft, nft->state, msgs, &nft->cmds);
 	nft->scanner = scanner_init(nft->state);
 	scanner_push_buffer(nft->scanner, &indesc_cmdline, buf);
 
@@ -390,7 +391,6 @@ int nft_run_cmd_from_buffer(struct nft_ctx *nft, const char *buf)
 {
 	struct cmd *cmd, *next;
 	LIST_HEAD(msgs);
-	LIST_HEAD(cmds);
 	char *nlbuf;
 	int rc = -EINVAL;
 
@@ -398,17 +398,17 @@ int nft_run_cmd_from_buffer(struct nft_ctx *nft, const char *buf)
 	sprintf(nlbuf, "%s\n", buf);
 
 	if (nft_output_json(&nft->output))
-		rc = nft_parse_json_buffer(nft, nlbuf, &msgs, &cmds);
+		rc = nft_parse_json_buffer(nft, nlbuf, &msgs, &nft->cmds);
 	if (rc == -EINVAL)
-		rc = nft_parse_bison_buffer(nft, nlbuf, &msgs, &cmds);
+		rc = nft_parse_bison_buffer(nft, nlbuf, &msgs, &nft->cmds);
 	if (rc)
 		goto err;
 
-	if (nft_netlink(nft, &cmds, &msgs, nft->nf_sock) != 0)
+	if (nft_netlink(nft, &nft->cmds, &msgs, nft->nf_sock) != 0)
 		rc = -1;
 err:
 	erec_print_list(&nft->output, &msgs, nft->debug_mask);
-	list_for_each_entry_safe(cmd, next, &cmds, list) {
+	list_for_each_entry_safe(cmd, next, &nft->cmds, list) {
 		list_del(&cmd->list);
 		cmd_free(cmd);
 	}
@@ -432,7 +432,6 @@ int nft_run_cmd_from_filename(struct nft_ctx *nft, const char *filename)
 {
 	struct cmd *cmd, *next;
 	LIST_HEAD(msgs);
-	LIST_HEAD(cmds);
 	int rc;
 
 	rc = cache_update(nft, CMD_INVALID, &msgs);
@@ -444,17 +443,17 @@ int nft_run_cmd_from_filename(struct nft_ctx *nft, const char *filename)
 
 	rc = -EINVAL;
 	if (nft_output_json(&nft->output))
-		rc = nft_parse_json_filename(nft, filename, &msgs, &cmds);
+		rc = nft_parse_json_filename(nft, filename, &msgs, &nft->cmds);
 	if (rc == -EINVAL)
-		rc = nft_parse_bison_filename(nft, filename, &msgs, &cmds);
+		rc = nft_parse_bison_filename(nft, filename, &msgs, &nft->cmds);
 	if (rc)
 		goto err;
 
-	if (nft_netlink(nft, &cmds, &msgs, nft->nf_sock) != 0)
+	if (nft_netlink(nft, &nft->cmds, &msgs, nft->nf_sock) != 0)
 		rc = -1;
 err:
 	erec_print_list(&nft->output, &msgs, nft->debug_mask);
-	list_for_each_entry_safe(cmd, next, &cmds, list) {
+	list_for_each_entry_safe(cmd, next, &nft->cmds, list) {
 		list_del(&cmd->list);
 		cmd_free(cmd);
 	}
-- 
2.21.0

