Return-Path: <netfilter-devel+bounces-848-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CCD846FC0
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Feb 2024 13:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08342996FD
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Feb 2024 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F713D4F7;
	Fri,  2 Feb 2024 12:06:11 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C8917C60
	for <netfilter-devel@vger.kernel.org>; Fri,  2 Feb 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875571; cv=none; b=CTMxSVxrXgLRrM/CtGYAu4y8hzHt7p9wVquEZOmogCbC863kK7D09hUCLzZ+6t+RAPsyBkeQqPYF6gUVbk2v9zf8RbWWPtSP/STnEAW3JdxV0sIaCFESkrfTldPSXNjXuPcpd/xllzvNKKvOzykmhxYdgBiivR9gt2sBqnTe+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875571; c=relaxed/simple;
	bh=zcar4yqU15euBGEfqckPSM9NzmEcAx30CC32rwg7hFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AAsnCiL5N4b8oqWlusgcWiMP0dM8LkpexFcctk4NdnJxys1PeJDu16nmKTbdxG+gj+LaZABytVAyk61wMbMjydRntNpaWegnPW4q1Dgp4dhbsDJa/s0Q5YGh1Rowk1PjlQI6CC6z0+O7joWZSGhxDjVdqQmf5MBeKtoQM50sL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf] netfilter: nft_byteorder: length must be multiple of size
Date: Fri,  2 Feb 2024 13:06:02 +0100
Message-Id: <20240202120602.5122-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although init path validates that store does not go over the register
boundaries, the eval loop iterates over length / size to perform the
byteorder swap.

Make sure length is a multiple of size, otherwise userspace is buggy.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_byteorder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index f6e791a68101..8cf91e47fd7a 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -139,6 +139,9 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 
 	priv->len = len;
 
+	if (len % size != 0)
+		return -EINVAL;
+
 	err = nft_parse_register_load(tb[NFTA_BYTEORDER_SREG], &priv->sreg,
 				      priv->len);
 	if (err < 0)
-- 
2.30.2


