Return-Path: <netfilter-devel+bounces-12140-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOnuFvAE6Wl5SgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12140-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 19:27:12 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6444947B
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 19:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980B5300A627
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB0351C1F;
	Wed, 22 Apr 2026 17:27:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BF280331
	for <netfilter-devel@vger.kernel.org>; Wed, 22 Apr 2026 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776878830; cv=none; b=s23gAJBCdecyXP4YGPRPt8jFkvUXiZnQx7br+F+KAuOng2aDtN8Ma3fHGnqz5PSaLNhGxSRvJTb8knVy4rP2iiddiZeoioq0A1ypo4EQr+xORtkVeEnligNEZAHa00JkMqtxihqEHlabj0+BNMqRIlUY7HUQj5EfZcWdYE1ECPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776878830; c=relaxed/simple;
	bh=FpDKUg3wCPHyI/Ka/LtZoeI7/SXUpJyfYFIVnj0blMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzqCx1EJWPW0bHWyeQpiCLUTFAwJMcL0NGU+IJbf9wcNwXtGIvyR/vBS3V5zK/IGkyvdNtAKf1VJiF+vaTpR3Ltbg6O9e15hOWDt5ZpA88CMEaCGd8gIRY2A+eBp5X+qupaMVAXC18VYv2Rr3rzCtPnZwBnURqn+OQ00Muj2K58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 401EF60890; Wed, 22 Apr 2026 19:27:05 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] evaluate: zap useless 0-shifts
Date: Wed, 22 Apr 2026 19:26:56 +0200
Message-ID: <20260422172659.24184-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12140-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6A6444947B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is a (not yet applied) kernel patch that rejects 0-shifts,
auto-suppress them at eval stage.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/evaluate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 482708ae6191..8bb7b6095309 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1454,6 +1454,12 @@ static int expr_evaluate_shift(struct eval_ctx *ctx, struct expr **expr)
 					 "shifts exceeding %u bits are not supported", UINT_MAX);
 
 	shift = mpz_get_uint32(right->value);
+	if (shift == 0) {
+		*expr = expr_get(left);
+		expr_free(op);
+		return 0;
+	}
+
 	if (ctx->stmt_len > left->len)
 		max_shift_len = ctx->stmt_len;
 	else
-- 
2.53.0


