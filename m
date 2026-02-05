Return-Path: <netfilter-devel+bounces-10655-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ5EBbQDhGmHwwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10655-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:43:00 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DC6EE128
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 03:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF64E301FC8A
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 02:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128062C031B;
	Thu,  5 Feb 2026 02:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="WM9sSleb"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98D2C0F96
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259318; cv=none; b=XAzKRh4MyU4pOP3Lw5yQcO/P4QsXE+LhMrcY1xpXCLp8+zGHvHSn7tJrcCYTYdESyw24/B/q2BtWm8eMPj+B7PcnNGRbBxiouePrrb3diG4lxZLId81Z6/8a+Nc/jzbwZiTIctn65BgZO4O7Mwyy8iOk0Wc0fkoNx+Hw2ar33So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259318; c=relaxed/simple;
	bh=fK7C6Lm1u7Y1vjhLT0wde//45HDEK0p1+JhrSwYS5dc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/h6aU04YDAO2z8Fyt4dRQM9l5S4jND6UrJhRiCE5ljmC6JxY8LVcL41XB6tKJQtcP0j4vWkXuYORveZVsKbUEB+kFiEjSLUsWQVgw2aw/iYkjlMEtEBo6ggZ2EH6J+KxE9WwHF8fqLMomm1T0gECKzXhWnjNSXYEjGCvh67jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WM9sSleb; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 2F1A260888
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Feb 2026 03:41:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770259316;
	bh=yqM6ftYaYjbgjZ9Hr0w0z3K8idGerrJwAGn5QLKoNho=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WM9sSlebToA3KPtzi/zf8MlhvjY6sx59cnH7t/aJ6Hqt7ReJJIyoufynULyWa5Qyt
	 Znp9OVox3KxkKgTrRCnSjkIGbMGLIjo+WWcyZdsi8d48+8V6FTQiO/41hjlYxjbOk/
	 q7+HSBv4HgFdhEOwwLqEH2iXZSPRPFeTtrSXRPa/bVA5dQ5D3H/mKOa0iD/OLX0hEA
	 gBCeTZ/zy8YpiOdSlp4DDedoenaQTN9gF4KXza9NXp4rH0g7fQ6uYt3Oq2xwWLCySV
	 L19NcaG5b2Chb8gqXLvun5rgQ3/qun9WpJYpUGm9ICzX262uTnz8ufGA+CLf94IGWf
	 1hBJvYOjS4K8w==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nft 20/20] evaluate: skip EXPR_SET_ELEM in error path of set statements
Date: Thu,  5 Feb 2026 03:41:29 +0100
Message-ID: <20260205024130.1470284-21-pablo@netfilter.org>
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
	TAGGED_FROM(0.00)[bounces-10655-lists,netfilter-devel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,netfilter.org:dkim,netfilter.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6DC6EE128
X-Rspamd-Action: no action

Use the key value directly, skip EXPR_SET_ELEM indirection.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index ea6013f6a24e..482708ae6191 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -3673,28 +3673,28 @@ static int stmt_evaluate_meter(struct eval_ctx *ctx, struct stmt *stmt)
 	expr_set_context(&ctx->ectx, NULL, 0);
 	if (expr_evaluate(ctx, &stmt->meter.key) < 0)
 		return -1;
-	if (expr_is_constant(stmt->meter.key))
-		return expr_error(ctx->msgs, stmt->meter.key,
+	if (expr_is_constant(stmt->meter.key->key))
+		return expr_error(ctx->msgs, stmt->meter.key->key,
 				  "Meter key expression can not be constant");
 	if (stmt->meter.key->comment)
-		return expr_error(ctx->msgs, stmt->meter.key,
+		return expr_error(ctx->msgs, stmt->meter.key->key,
 				  "Meter key expression can not contain comments");
 
 	/* Declare an empty set */
 	key = stmt->meter.key;
 	if (existing_set) {
 		if ((existing_set->flags & NFT_SET_TIMEOUT) && !key->timeout)
-			return expr_error(ctx->msgs, stmt->meter.key,
+			return expr_error(ctx->msgs, stmt->meter.key->key,
 					  "existing set '%s' has timeout flag",
 					  stmt->meter.name);
 
 		if ((existing_set->flags & NFT_SET_TIMEOUT) == 0 && key->timeout)
-			return expr_error(ctx->msgs, stmt->meter.key,
+			return expr_error(ctx->msgs, stmt->meter.key->key,
 					  "existing set '%s' lacks timeout flag",
 					  stmt->meter.name);
 
 		if (stmt->meter.size > 0 && existing_set->desc.size != stmt->meter.size)
-			return expr_error(ctx->msgs, stmt->meter.key,
+			return expr_error(ctx->msgs, stmt->meter.key->key,
 					  "existing set '%s' has size %u, meter has %u",
 					  stmt->meter.name, existing_set->desc.size,
 					  stmt->meter.size);
@@ -4848,7 +4848,7 @@ static int stmt_evaluate_set(struct eval_ctx *ctx, struct stmt *stmt)
 			      &stmt->set.key->key) < 0)
 		return -1;
 	if (stmt->set.key->comment != NULL)
-		return expr_error(ctx->msgs, stmt->set.key,
+		return expr_error(ctx->msgs, stmt->set.key->key,
 				  "Key expression comments are not supported");
 	list_for_each_entry(this, &stmt->set.stmt_list, list) {
 		if (stmt_evaluate_stateful(ctx, this, "set") < 0)
@@ -4889,7 +4889,7 @@ static int stmt_evaluate_map(struct eval_ctx *ctx, struct stmt *stmt)
 			      &stmt->map.key->key) < 0)
 		return -1;
 	if (stmt->map.key->comment != NULL)
-		return expr_error(ctx->msgs, stmt->map.key,
+		return expr_error(ctx->msgs, stmt->map.key->key,
 				  "Key expression comments are not supported");
 
 	if (stmt_evaluate_arg(ctx, stmt,
-- 
2.47.3


