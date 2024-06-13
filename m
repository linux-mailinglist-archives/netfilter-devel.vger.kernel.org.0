Return-Path: <netfilter-devel+bounces-2589-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F1906027
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jun 2024 03:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027F61C20852
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jun 2024 01:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5BA84055;
	Thu, 13 Jun 2024 01:02:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6016DF71;
	Thu, 13 Jun 2024 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240559; cv=none; b=etoHjfxDjQYruL85LJvT54lJGEBqrshE7kWVZG7Uh59Up4NwzdQJlyanx3zCLXg1R/3smZJsEfZIyQofXjhuajhGahshRSD7/7vkKIQR050JOnmoi5cSFMTrKDlQywtYoCjCgSUj1fiUdWPNYRlG28BYnalux63Mjvbu0JVJBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240559; c=relaxed/simple;
	bh=QnJZl/aTYLGe9ZQbdFRzEL1TQ5rKOqcDx3DIPQvMQPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afkOSNKO1HnFyZozcHZkXjwei9zPju0krZZFDeOuewkiER8ze9C75N9rkWOn9K0PZ9D1+7FVK5x3gMR1MfI3TW8TuADfq7WeVpLUGtnZOssghh5yOSQgvO7HX6YbLpOEp4obSmfHuQTt5y64PY9h06cv438xsSMBMaWbgN/mMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,4.19.x 30/40] netfilter: nft_dynset: relax superfluous check on set updates
Date: Thu, 13 Jun 2024 03:01:59 +0200
Message-Id: <20240613010209.104423-31-pablo@netfilter.org>
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

commit 7b1394892de8d95748d05e3ee41e85edb4abbfa1 upstream.

Relax this condition to make add and update commands idempotent for sets
with no timeout. The eval function already checks if the set element
timeout is available and updates it if the update command is used.

Fixes: 22fe54d5fefc ("netfilter: nf_tables: add support for dynamic set updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_dynset.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 04ca3afe70dc..1cc6f4602575 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -154,16 +154,8 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 		return -EBUSY;
 
 	priv->op = ntohl(nla_get_be32(tb[NFTA_DYNSET_OP]));
-	switch (priv->op) {
-	case NFT_DYNSET_OP_ADD:
-		break;
-	case NFT_DYNSET_OP_UPDATE:
-		if (!(set->flags & NFT_SET_TIMEOUT))
-			return -EOPNOTSUPP;
-		break;
-	default:
+	if (priv->op > NFT_DYNSET_OP_UPDATE)
 		return -EOPNOTSUPP;
-	}
 
 	timeout = 0;
 	if (tb[NFTA_DYNSET_TIMEOUT] != NULL) {
-- 
2.30.2


