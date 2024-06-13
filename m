Return-Path: <netfilter-devel+bounces-2596-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE9906035
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jun 2024 03:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A791C1C20BB5
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jun 2024 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C3412BE84;
	Thu, 13 Jun 2024 01:02:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B1984A5F;
	Thu, 13 Jun 2024 01:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240563; cv=none; b=iV+TjbaPhLrjFoBaQfg9Z66EoVJ/Z5w13l/UjHpFO5rKbywJvLrz0gpeUt+SCUgE1Fn8MHDpy8GctA59z7rivGKqGt/OI1afnvfr6/EYEFSVbrmhMjdJcTEraPw3xtbSVooNVKS0K3bmP8tEJ9eJ2xHwUNhgvyhbIeNMCWB4TnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240563; c=relaxed/simple;
	bh=q47zAy360POrRe7MdFoXQ34KOw7Qj07FA7CDKCrbjyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ePZ8pkbZgltwqO8j798T+Filbd9xLzUS7iTcKWP0QlrdqD31jQIoUYROdMl2yohxaTIpOiXn79dM7q7bdzo4LhqRbwCyFfZSOkNdmgan+ygQGGlfGF/C8NKYIKFGIqMdnkSjs8h/knqNFUKAwxt+ukon6aEzSREUDN+L7ywamw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,4.19.x 37/40] netfilter: nf_tables: do not compare internal table flags on updates
Date: Thu, 13 Jun 2024 03:02:06 +0200
Message-Id: <20240613010209.104423-38-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240613010209.104423-1-pablo@netfilter.org>
References: <20240613010209.104423-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 4a0e7f2decbf9bd72461226f1f5f7dcc4b08f139 ]

Restore skipping transaction if table update does not modify flags.

Fixes: 179d9ba5559a ("netfilter: nf_tables: fix table flag updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d2f095e8853f..2c7fd0df9389 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -890,7 +890,7 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	if (flags & ~NFT_TABLE_F_DORMANT)
 		return -EINVAL;
 
-	if (flags == ctx->table->flags)
+	if (flags == (ctx->table->flags & NFT_TABLE_F_MASK))
 		return 0;
 
 	/* No dormant off/on/off/on games in single transaction */
-- 
2.30.2


