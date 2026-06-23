Return-Path: <netfilter-devel+bounces-13417-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Ua7DbDAOmqCFwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13417-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 19:21:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 325116B9009
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 19:21:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=A2KC0mKP;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13417-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13417-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2F2D301E195
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3C38AC9A;
	Tue, 23 Jun 2026 17:21:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841638A71F
	for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2026 17:21:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235299; cv=none; b=F0qunCzIS41UkMWBrn0BKHyS90HcTZExHCP77eGdEwBbFixXyXzz0fJOrE8eFaA9BqOO5cFzDDv1N3N9f6Bw++xSXPZt1YdgIxixG++xr+wWdDpDD1HJqfCgLlVaNO1+OeF+TgwVKylAoxnWzuE5RlkSxwU4iT+FbAQQjw1I/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235299; c=relaxed/simple;
	bh=WOBTmTDgcQMlYIshXA8yoR47KK9WAkQrmXCcqkzUUSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgEuT9x9q/DcSnnNaQkogl1z+5HbNH8BHxJzSuRh7hga4V2F8rpbVW1/S2BFM6XFnyFOcTio7J6N6fZPrEHrt9Nj5Z+Rsw5XbqX/jGViInlDwBpWXFSUJSz3vbkSeoA+jSiY3mT4tRHKvot52svvrEaclnbG2+5+zD1yLz42rKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=A2KC0mKP; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 4BD616057F;
	Tue, 23 Jun 2026 19:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782235296;
	bh=sHBTEaz3faCO87lt1hgm2LeBGzLfAbgfu8Wc+vkMGFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2KC0mKPH6oJCQO4bCyMLVJdSokVYqBRSHeNw6gYrjSMGqb7JLT2KrbixkP73zuP/
	 cM33MyJKILm3+4Voy6cDWb/AITNhBJvrmtQLRYoTG8TjknlfbB/mbYT55aoOE+Gtmm
	 +OYmTDmntrR0mSILl/p/1GwC3Lr062gL6LfkalJubzz0BtsAdFvGy2QuVDo1m+enQ7
	 Wn7IaWE6o+VJ7Sv/xKWVlEHXfX7iSbwyPzwFnN5Qm+swenltsBgjnwHmJsBQd4j6Vi
	 6t0g8rTdRHLUcsbch3hK8kNBalCccT9wXGUoCrvbK1NdX31vFnxjDJ7eWfx1PcBoWQ
	 IwaL+0E3O05Xw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc
Subject: [PATCH nft,v2 4/5] src: allow reset commands in batch with list and get commands only
Date: Tue, 23 Jun 2026 19:21:27 +0200
Message-ID: <20260623172128.401234-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623172128.401234-1-pablo@netfilter.org>
References: <20260623172128.401234-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13417-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:phil@nwl.cc,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 325116B9009

Currently, only single reset command is working properly, but more than
one fail because of the existing cache logic. Bail out in case user
mixes reset commands.

The reset command is special because it provides no transaction
semantics, like the list command. Allowing the use of the reset command
in conjunction with other commands require an implicit end of batch /
commit command.

Allow a batch that contains reset commands with list and get command
by now.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/cmd.h      |  2 ++
 src/cmd.c          | 37 +++++++++++++++++++++++++++++++++++++
 src/parser_bison.y | 12 ++++++++++--
 src/parser_json.c  |  8 ++++----
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/cmd.h b/include/cmd.h
index cf7e43bf46ec..a457364aeeeb 100644
--- a/include/cmd.h
+++ b/include/cmd.h
@@ -11,4 +11,6 @@ bool nft_cmd_collapse_elems(enum cmd_ops op, struct list_head *cmds,
 
 void nft_cmd_expand(struct cmd *cmd);
 
+int cmd_batch_add(struct cmd *cmd, struct list_head *cmds);
+
 #endif
diff --git a/src/cmd.c b/src/cmd.c
index 9d5544f03c32..7ee2176191b1 100644
--- a/src/cmd.c
+++ b/src/cmd.c
@@ -489,3 +489,40 @@ void nft_cmd_expand(struct cmd *cmd)
 		break;
 	}
 }
+
+static bool cmd_valid_mix(const struct cmd *cmd, const struct cmd *last_cmd)
+{
+	switch (cmd->op) {
+	case CMD_RESET:
+		if (last_cmd->op == CMD_RESET ||
+		    last_cmd->op == CMD_LIST ||
+		    last_cmd->op == CMD_GET)
+			return true;
+
+		return false;
+	case CMD_LIST:
+	case CMD_GET:
+		return true;
+	default:
+		if (last_cmd->op == CMD_RESET)
+			return false;
+		break;
+	}
+
+	return true;
+}
+
+int cmd_batch_add(struct cmd *cmd, struct list_head *cmds)
+{
+	struct cmd *last_cmd;
+	int ret = 0;
+
+	if (!list_empty(cmds)) {
+		last_cmd = list_last_entry(cmds, struct cmd, list);
+		if (!cmd_valid_mix(cmd, last_cmd))
+			ret = -1;
+	}
+	list_add_tail(&cmd->list, cmds);
+
+	return ret;
+}
diff --git a/src/parser_bison.y b/src/parser_bison.y
index 5a334bf0c499..48151a419096 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -1073,7 +1073,11 @@ input			:	/* empty */
 			{
 				if ($2 != NULL) {
 					$2->location = @2;
-					list_add_tail(&$2->list, state->cmds);
+					if (cmd_batch_add($2, state->cmds) < 0) {
+						erec_queue(error(&@2, "unsupported command mix"),
+							   state->msgs);
+						YYERROR;
+					}
 				}
 			}
 			;
@@ -1210,7 +1214,11 @@ line			:	common_block			{ $$ = NULL; }
 				 */
 				if ($1 != NULL) {
 					$1->location = @1;
-					list_add_tail(&$1->list, state->cmds);
+					if (cmd_batch_add($1, state->cmds) < 0) {
+						erec_queue(error(&@2, "unsupported command mix"),
+							   state->msgs);
+						YYERROR;
+					}
 				}
 				$$ = NULL;
 				YYACCEPT;
diff --git a/src/parser_json.c b/src/parser_json.c
index f04772a022a0..47acc200ad83 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -4492,7 +4492,6 @@ static int __json_parse(struct json_ctx *ctx)
 
 	json_array_foreach(tmp, index, value) {
 		/* this is more or less from parser_bison.y:716 */
-		LIST_HEAD(list);
 		struct cmd *cmd;
 		json_t *tmp2;
 
@@ -4522,9 +4521,10 @@ static int __json_parse(struct json_ctx *ctx)
 			return -1;
 		}
 
-		list_add_tail(&cmd->list, &list);
-
-		list_splice_tail(&list, ctx->cmds);
+		if (cmd_batch_add(cmd, ctx->cmds) < 0) {
+			json_error(ctx, "unsupported command mix");
+			return -1;
+		}
 
 		if (nft_output_echo(&ctx->nft->output))
 			json_cmd_assoc_add(value, cmd);
-- 
2.47.3


