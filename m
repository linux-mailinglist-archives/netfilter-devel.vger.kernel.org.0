Return-Path: <netfilter-devel+bounces-704-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EC8831D70
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jan 2024 17:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3420B2121F
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jan 2024 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7932CCB0;
	Thu, 18 Jan 2024 16:17:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90CB2C6B9;
	Thu, 18 Jan 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594665; cv=none; b=mLBV+szZ4CEDmhc7F3566lhhGPE1SmdVEC57CXop0Hauqo3gO5qrqIDQwFNXUHVD4COUAmt4lnQIgeuz3GuTS0M+j8DqHB2lJDSNTE5w/JqDVj62PiWzUVeIkhTix8BHDs3WLP0aSXyHP1mMhXfhrZtxZnGw84fNPYkuERbjASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594665; c=relaxed/simple;
	bh=DqAPtdzyDrXVLwhz7Y33bPeIFtxJQ4xuGUt7Q1XJ5nY=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding; b=Jwl5QiU0NIMUgvjhKm7xBLT1WvFLFgTT4f55PcxzocfInJiGCVc6c9ynGUejzXPCw/RE0J85oaTk5t/z62c8ZoBBjtoXq99gGJS/LORxbbJJ9vnUfAvZXkxaFES+EtLE/0upDB3Jdftjd1hrJtBIA79h77vttVOnXnhVvS7Bm3Q=
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
Subject: [PATCH net 10/13] netfilter: nf_tables: do not allow mismatch field size and set key length
Date: Thu, 18 Jan 2024 17:17:23 +0100
Message-Id: <20240118161726.14838-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240118161726.14838-1-pablo@netfilter.org>
References: <20240118161726.14838-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The set description provides the size of each field in the set whose sum
should not mismatch the set key length, bail out otherwise.

I did not manage to crash nft_set_pipapo with mismatch fields and set key
length so far, but this is UB which must be disallowed.

Fixes: f3a2181e16f1 ("netfilter: nf_tables: Support for sets with multiple ranged fields")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 50b595ef6389..e9fa4a32c093 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4813,8 +4813,8 @@ static int nft_set_desc_concat_parse(const struct nlattr *attr,
 static int nft_set_desc_concat(struct nft_set_desc *desc,
 			       const struct nlattr *nla)
 {
+	u32 num_regs = 0, key_num_regs = 0;
 	struct nlattr *attr;
-	u32 num_regs = 0;
 	int rem, err, i;
 
 	nla_for_each_nested(attr, nla, rem) {
@@ -4829,6 +4829,10 @@ static int nft_set_desc_concat(struct nft_set_desc *desc,
 	for (i = 0; i < desc->field_count; i++)
 		num_regs += DIV_ROUND_UP(desc->field_len[i], sizeof(u32));
 
+	key_num_regs = DIV_ROUND_UP(desc->klen, sizeof(u32));
+	if (key_num_regs != num_regs)
+		return -EINVAL;
+
 	if (num_regs > NFT_REG32_COUNT)
 		return -E2BIG;
 
-- 
2.30.2


