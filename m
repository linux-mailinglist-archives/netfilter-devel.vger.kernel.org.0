Return-Path: <netfilter-devel+bounces-3731-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B2E96E649
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Sep 2024 01:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678B9286E6E
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Sep 2024 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AFA1BD513;
	Thu,  5 Sep 2024 23:29:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651EE1BBBD8;
	Thu,  5 Sep 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725578983; cv=none; b=Cy4jPVvXAdOtLCEi9i1udQ68ErMbZbW35IMGQ3mHKJ50WCmYuTF7bNxdKgSQh/Gb3FYb6I02JsbE559uUzZmyp+NDn5TZg0AnzJFtihB/CQcSgXsr+lLBs+SXTcyS39PWwSrnL4bfa8iUDOQm0CRfFlxZDERodqQxphnQIW80lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725578983; c=relaxed/simple;
	bh=yaOwtLeEgVrn/6Qd1K3XmtginthgbN6a1Vonn2dzfyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tndDgEabyKEt6v97rmV0E/PALrJFQRTTNafeRTsUf+qZoCEGzZw8PKm9yYSavIIWAbesEZfPcWgCLhDxKUl4CGTH6FhQMf3gni2KPV1XqZKkqgAdksgIfGA3KMkU38tvUuhHu/uNp+BDP5u6yeh+KqCR58ALzrOy9SK/i2iyG/o=
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
Subject: [PATCH net-next 12/16] netfilter: nft_dynset: annotate data-races around set timeout
Date: Fri,  6 Sep 2024 01:29:16 +0200
Message-Id: <20240905232920.5481-13-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240905232920.5481-1-pablo@netfilter.org>
References: <20240905232920.5481-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set timeout can be read locklessly while being updated from control
plane, add annotation.

Fixes: 123b99619cca ("netfilter: nf_tables: honor set timeout and garbage collection updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_dynset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 6920df754265..5812fd880b79 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -56,7 +56,7 @@ static struct nft_elem_priv *nft_dynset_new(struct nft_set *set,
 	if (!atomic_add_unless(&set->nelems, 1, set->size))
 		return NULL;
 
-	timeout = priv->timeout ? : set->timeout;
+	timeout = priv->timeout ? : READ_ONCE(set->timeout);
 	elem_priv = nft_set_elem_init(set, &priv->tmpl,
 				      &regs->data[priv->sreg_key], NULL,
 				      &regs->data[priv->sreg_data],
@@ -95,7 +95,7 @@ void nft_dynset_eval(const struct nft_expr *expr,
 			     expr, regs, &ext)) {
 		if (priv->op == NFT_DYNSET_OP_UPDATE &&
 		    nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION)) {
-			timeout = priv->timeout ? : set->timeout;
+			timeout = priv->timeout ? : READ_ONCE(set->timeout);
 			*nft_set_ext_expiration(ext) = get_jiffies_64() + timeout;
 		}
 
@@ -313,7 +313,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 		nft_dynset_ext_add_expr(priv);
 
 	if (set->flags & NFT_SET_TIMEOUT) {
-		if (timeout || set->timeout) {
+		if (timeout || READ_ONCE(set->timeout)) {
 			nft_set_ext_add(&priv->tmpl, NFT_SET_EXT_TIMEOUT);
 			nft_set_ext_add(&priv->tmpl, NFT_SET_EXT_EXPIRATION);
 		}
-- 
2.30.2


