Return-Path: <netfilter-devel+bounces-4807-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC29B6FE7
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Oct 2024 23:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEA51C20F78
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Oct 2024 22:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE11D1509;
	Wed, 30 Oct 2024 22:37:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0811925AE
	for <netfilter-devel@vger.kernel.org>; Wed, 30 Oct 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730327862; cv=none; b=hHdhnvz/Y3SUVQXZMBMYoqpgMtzUQAeRaJ80Qcx09xLCk7+E02loKjLtom1ClECchzfoWM2I+ZKLNiq/A0hdCoQk92jDyorT2QShztuDOm33GnED0QX+YVvL2EqobWfu3epCkvhr73kpwA6S6eh5DJV/JLdCfWVsL70RHT2+zXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730327862; c=relaxed/simple;
	bh=OKiIvEph95fdRC8pmGS6+p7/vpLvqgjurGSHv+rNOJI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tZ57/smTh7CFJkDQvWHcSubb9VD2NHKzNJnzRTb/td+pMPgEzxrhYP+khYMTL7eJg4IbHDJcOjozrQVypSDqWp9zdL4cGcbwASn7uzh1e3XhDerYAavJsnnn2yj1qTDnqzO8Ab5q5fV3VmNEh8uHRTDcgCvRdtPU1qch4EJ3aa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: nft_payload: sanitize offset and length before calling skb_checksum()
Date: Wed, 30 Oct 2024 23:37:28 +0100
Message-Id: <20241030223728.155513-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If access to offset + length is larger than the skbuff length, then
skb_checksum() triggers BUG_ON().

skb_checksum() internally subtracts the length parameter while iterating
over skbuff, BUG_ON(len) at the end of it checks that the expected
length to be included in the checksum calculation is fully consumed.

Fixes: 7ec3f7b47b8d ("netfilter: nft_payload: add packet mangling support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_payload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 330609a76fb2..7dfc5343dae4 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -904,6 +904,9 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	    ((priv->base != NFT_PAYLOAD_TRANSPORT_HEADER &&
 	      priv->base != NFT_PAYLOAD_INNER_HEADER) ||
 	     skb->ip_summed != CHECKSUM_PARTIAL)) {
+		if (offset + priv->len > skb->len)
+			goto err;
+
 		fsum = skb_checksum(skb, offset, priv->len, 0);
 		tsum = csum_partial(src, priv->len, 0);
 
-- 
2.30.2


