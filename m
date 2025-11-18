Return-Path: <netfilter-devel+bounces-9810-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2198C6C0D6
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Nov 2025 00:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FED74E6113
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Nov 2025 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C63195EC;
	Tue, 18 Nov 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ftAgxkU/"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42714A8E
	for <netfilter-devel@vger.kernel.org>; Tue, 18 Nov 2025 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509829; cv=none; b=pq2ZjxlpN8yn9oeczpeTvTyWQo7huDGgTiLO7Bra6E8nKKR/BFSN097W2owAeMJt33RXg/wCeAJYwPJvedn80nSk9FMb9QYllFP6lTLlWRZd5qYK7FuMI8f7H6r0iMcCoCUVoxf4Swnqtl7SeJSzmNvNgwF+dT+8+A0pNG91wBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509829; c=relaxed/simple;
	bh=hvEIDmU4FkmOtuQhEBXuUo7g519l0Z4KJfiDTjhSYU0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QMzUhmd/yaCHJVO5XLLpTHK2MMbRnS1nvxNybkJyy2DUUMfxua5QS4ZbEKHIxyZX+qoOvWwL1mpl0KQ+Y5LTj0++75ofFRU8KZHF37YYNxwtifxvWc0oYCV+HQOGmeDgrhzVlhk21uEt/wqrFqHgqAkvQFjEeSd/WhUhYJCv6mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ftAgxkU/; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id DD7AA6026C
	for <netfilter-devel@vger.kernel.org>; Wed, 19 Nov 2025 00:50:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1763509818;
	bh=lJLWasZ9oHR3COxrekpnmZIE0zkYMGrXmsnTomB+ZR0=;
	h=From:To:Subject:Date:From;
	b=ftAgxkU/DF+vYhW/nUCMZIBh8TahcvI781VCFyitdMJZn5Dgg54m7pvBfSg2caw1x
	 6IUngxb6CHbcKqpPCQbB7ATgULM/EuKe7ccsFYsVST4rLlvloRg/suIN2of4XosqvZ
	 YbnN5yYKYjUU8HMpiIFqeRtMrrR8UoNpZ0JQYfh1qgjTcjYOGmiDJH4wLPNmkkcWQZ
	 bORzYB0IJDwOZYao9//9VPA/t+eIOFYdIQ+3RrQ9apBNa0nlfGKALE1e/N/EEqbetb
	 dXtpphm0wpzHT1OsE+OaY0uJUmvqYkSgI/T4+leBxBf2yHxtWvwPGadUAOgSbziEzN
	 GET14oQkJ5N0Q==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 1/2] netfilter: nf_tables: skip register jump/goto validation for non-base chain
Date: Wed, 19 Nov 2025 00:50:08 +0100
Message-Id: <20251118235009.149562-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validating a non-base chain for each register store slows down
validation unnecessarily, remove it.

Fixes: a654de8fdc18 ("netfilter: nf_tables: fix chain dependency validation")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6f35f0b7a33c..bef95cede7b5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -11846,6 +11846,9 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 		if (data != NULL &&
 		    (data->verdict.code == NFT_GOTO ||
 		     data->verdict.code == NFT_JUMP)) {
+			if (!nft_is_base_chain(ctx->chain))
+				break;
+
 			err = nft_chain_validate(ctx, data->verdict.chain);
 			if (err < 0)
 				return err;
-- 
2.30.2


