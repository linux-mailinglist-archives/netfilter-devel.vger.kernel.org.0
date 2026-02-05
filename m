Return-Path: <netfilter-devel+bounces-10654-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA85I7IDhGmHwwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10654-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:42:58 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E902EE121
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CB10301C908
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 02:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B02C0290;
	Thu,  5 Feb 2026 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="KAZwF8Wf"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8A2BE62E
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 02:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259317; cv=none; b=L4QzJ5YJ7OkSPD+3ur/bCg3le/bvhiog0Pz6dLNylCHlvGLeF1RlpaalgEQG+SQuXfoTXBU1fbIdqCTV4UOM6/jind+osNbbCkpcUSL+cKayb27rokokli4LyytGvbrtSw6EB8Yyp4R3MV7Ql5ZZeAKrKd0tbJx7igtqGaTGP5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259317; c=relaxed/simple;
	bh=mUorSy+NrOfY5d2yUVO1dpwzFxnYeAy71BNcZukDvEc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAb10jm9VnU1hJYudJ9QsPfXmNlwOoZ4gWCE3KGEU+dXLkm95KJy+z6mJTtIGfJiNchpta8Mv3RQL3mlW4PrrjEyzfcDl6j51qlUpz6dbbQiZsrzcdzQkjXx1KFv4taFMcip1qbbR1cURE3CG9/67qqk8UBexjrdtuMuqQoj+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=KAZwF8Wf; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 5330660883
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 03:41:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770259315;
	bh=lWpZwDyxBWsNX4RdaGetha0YenyhCqt8E+hzDvSsVzE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KAZwF8WfjlID079bSeqNkl/aDbv0u+XmHmhnjOKdQJZP7pECJNi7Gjw5991MJlnvb
	 gVKt6uu0rvhSVQuzApmg6gYQg2lOTkBD3/8HPGPHSh0+V9g9IwftfQ/fA0lLo+TIUN
	 i9VxmWqqVaHq13IR8DKKRXJOVe/qhK6aUsqrLtQVpoT4T3q8qhWQavyhjGJ7Cv+vpc
	 Sx4NFKQd/io1EOf5D6DK49ELCWUH5J771+PjonF88cnUffpxNC8d+UM8z6vF6ryd+S
	 7KavHehar4lCAI2HwJcrjHA8INq8W/vdPGeC/MUARMJMTdL+ykt2LKRH0lJ0MXREPc
	 9PfScczBqk1Zw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft 19/20] evaluate: remove check for constant expression in set/map statement
Date: Thu,  5 Feb 2026 03:41:28 +0100
Message-ID: <20260205024130.1470284-20-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205024130.1470284-1-pablo@netfilter.org>
References: <20260205024130.1470284-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-10654-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netfilter.org:email,netfilter.org:dkim,netfilter.org:mid]
X-Rspamd-Queue-Id: 4E902EE121
X-Rspamd-Action: no action

a8260c056a69 ("tests: add dynmap datapath add/delete test case") proves
this is indeed supported, remove these checks.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index 3b6008149801..ea6013f6a24e 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -4847,9 +4847,6 @@ static int stmt_evaluate_set(struct eval_ctx *ctx, struct stmt *stmt)
 			      stmt->set.set->set->key->byteorder,
 			      &stmt->set.key->key) < 0)
 		return -1;
-	if (expr_is_constant(stmt->set.key))
-		return expr_error(ctx->msgs, stmt->set.key,
-				  "Key expression can not be constant");
 	if (stmt->set.key->comment != NULL)
 		return expr_error(ctx->msgs, stmt->set.key,
 				  "Key expression comments are not supported");
@@ -4891,9 +4888,6 @@ static int stmt_evaluate_map(struct eval_ctx *ctx, struct stmt *stmt)
 			      stmt->map.set->set->key->byteorder,
 			      &stmt->map.key->key) < 0)
 		return -1;
-	if (expr_is_constant(stmt->map.key))
-		return expr_error(ctx->msgs, stmt->map.key,
-				  "Key expression can not be constant");
 	if (stmt->map.key->comment != NULL)
 		return expr_error(ctx->msgs, stmt->map.key,
 				  "Key expression comments are not supported");
@@ -4904,9 +4898,6 @@ static int stmt_evaluate_map(struct eval_ctx *ctx, struct stmt *stmt)
 			      stmt->map.set->set->data->byteorder,
 			      &stmt->map.data->key) < 0)
 		return -1;
-	if (expr_is_constant(stmt->map.data))
-		return expr_error(ctx->msgs, stmt->map.data,
-				  "Data expression can not be constant");
 	if (stmt->map.data->comment != NULL)
 		return expr_error(ctx->msgs, stmt->map.data,
 				  "Data expression comments are not supported");
-- 
2.47.3


