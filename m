Return-Path: <netfilter-devel+bounces-939-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FD84D6A1
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 00:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0783285887
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Feb 2024 23:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B49D535C4;
	Wed,  7 Feb 2024 23:37:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39EB20335;
	Wed,  7 Feb 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349057; cv=none; b=A8QZvMsYITtT9sJPog3wisTHoOUV0tC9N3oyjdAPYUVu0DySzLCKQe8OPnGPEZ7F/nyba/CoPmrfUSH6WYE7SU0MxScMtELAHeTnSg6rhalKsHwH3eTxaHvKvnrr73vwQe9LCwn1croL3EDpq3fap1aGeXQeZymU3wCOuk+DOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349057; c=relaxed/simple;
	bh=zt+vClPJLNab6Ob4q7jou1FjjrMe31sCfWi/4X78goA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CtRtgQq0aGIw587NR+6YcNhbeEOdpTfWP9SluUY0NV0TImX4KP+RDdNJroxn6G8pdrKlFBQfLilCMCEDiH5q5mbGzmIs+2+79dVDzl28m9e9Egp/LQAtcIlykEbLpaYGJ5F5PSAXhGXnX3gFkzlbA7BynEvGLQs/DulZVsKUMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 02/13] netfilter: nft_compat: reject unused compat flag
Date: Thu,  8 Feb 2024 00:37:15 +0100
Message-Id: <20240207233726.331592-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240207233726.331592-1-pablo@netfilter.org>
References: <20240207233726.331592-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flag (1 << 0) is ignored is set, never used, reject it it with EINVAL
instead.

Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/netfilter/nf_tables.h | 2 ++
 net/netfilter/nft_compat.c               | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index ca30232b7bc8..117c6a9b845b 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -285,9 +285,11 @@ enum nft_rule_attributes {
 /**
  * enum nft_rule_compat_flags - nf_tables rule compat flags
  *
+ * @NFT_RULE_COMPAT_F_UNUSED: unused
  * @NFT_RULE_COMPAT_F_INV: invert the check result
  */
 enum nft_rule_compat_flags {
+	NFT_RULE_COMPAT_F_UNUSED = (1 << 0),
 	NFT_RULE_COMPAT_F_INV	= (1 << 1),
 	NFT_RULE_COMPAT_F_MASK	= NFT_RULE_COMPAT_F_INV,
 };
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 001b6841a4b6..ed71d5ecbe0a 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -212,7 +212,8 @@ static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 		return -EINVAL;
 
 	flags = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_FLAGS]));
-	if (flags & ~NFT_RULE_COMPAT_F_MASK)
+	if (flags & NFT_RULE_COMPAT_F_UNUSED ||
+	    flags & ~NFT_RULE_COMPAT_F_MASK)
 		return -EINVAL;
 	if (flags & NFT_RULE_COMPAT_F_INV)
 		*inv = true;
-- 
2.30.2


