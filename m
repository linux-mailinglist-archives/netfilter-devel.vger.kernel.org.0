Return-Path: <netfilter-devel+bounces-2588-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB45906025
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jun 2024 03:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B51C209A5
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jun 2024 01:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C1F9CF;
	Thu, 13 Jun 2024 01:02:38 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41689EAD0;
	Thu, 13 Jun 2024 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240558; cv=none; b=pq/wJpk+e6ztIhnAaTUQzJ6KUlSSEudwWpx1n0/IHhF7SGLMmwTVKLIbdKQzzCX1mKJkQQPNC4LdSZhYaw+TQKXBjZsHebHX/RyZFeNr3cRDSLhM3GKlctv3WfgIoGUl3qAXVcaVtTmF3K3Jna6YRwzsNxnj5vt2uMfx67fclOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240558; c=relaxed/simple;
	bh=96bmHFLSPpVIT2nbMyfL+r5hD7K93ZFKKcCx8auvrJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lU3tExjQAQct6xjM14wXiJkuasJ4s45tmE3Q8fMJr9RveFhjP9en/YqMKhoetfET/hVwi1lIKofoosuThuAa2+Ez3/YWN/tZjh6Igg1F6zyGuZ6mLyn4rs7n5aIxMvQCjKS8JL7qyouHPIO9z98bENP1Wr8RMk/0CUdfElOr5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,4.19.x 29/40] netfilter: nft_dynset: report EOPNOTSUPP on missing set feature
Date: Thu, 13 Jun 2024 03:01:58 +0200
Message-Id: <20240613010209.104423-30-pablo@netfilter.org>
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

commit 95cd4bca7b1f4a25810f3ddfc5e767fb46931789 upstream.

If userspace requests a feature which is not available the original set
definition, then bail out with EOPNOTSUPP. If userspace sends
unsupported dynset flags (new feature not supported by this kernel),
then report EOPNOTSUPP to userspace. EINVAL should be only used to
report malformed netlink messages from userspace.

Fixes: 22fe54d5fefc ("netfilter: nf_tables: add support for dynamic set updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_dynset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 7f79e877671b..04ca3afe70dc 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -133,7 +133,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 		u32 flags = ntohl(nla_get_be32(tb[NFTA_DYNSET_FLAGS]));
 
 		if (flags & ~NFT_DYNSET_F_INV)
-			return -EINVAL;
+			return -EOPNOTSUPP;
 		if (flags & NFT_DYNSET_F_INV)
 			priv->invert = true;
 	}
@@ -168,7 +168,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	timeout = 0;
 	if (tb[NFTA_DYNSET_TIMEOUT] != NULL) {
 		if (!(set->flags & NFT_SET_TIMEOUT))
-			return -EINVAL;
+			return -EOPNOTSUPP;
 
 		err = nf_msecs_to_jiffies64(tb[NFTA_DYNSET_TIMEOUT], &timeout);
 		if (err)
@@ -182,7 +182,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 
 	if (tb[NFTA_DYNSET_SREG_DATA] != NULL) {
 		if (!(set->flags & NFT_SET_MAP))
-			return -EINVAL;
+			return -EOPNOTSUPP;
 		if (set->dtype == NFT_DATA_VERDICT)
 			return -EOPNOTSUPP;
 
-- 
2.30.2


