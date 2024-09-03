Return-Path: <netfilter-devel+bounces-3651-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9A969F86
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2024 15:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952961C2359A
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA67E2AE75;
	Tue,  3 Sep 2024 13:55:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4798C07
	for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371743; cv=none; b=Xydhy3LmKoKs1LJIwUXiHVWPFTGaNox8v2cWvkl52tM+SaaRR9trImjfb2oW7unPRh8hapv4TkOkrzH+eKd5ZX/6Bf/+umWRA8YxtIyAjsyRwmjNm/KPu0e5yM/96m5kM//6dJBRBeVq+FZHWCg0jF/mkrPJd1h9xvzBrr4tasI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371743; c=relaxed/simple;
	bh=2OrSndajDNIha5uIQxD6yaPpkkzNhmN68FFll3Nx/ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dpTI84FgIJdJGtSK8xkSkhLRcBVl2Na9YgqeO4KkncVYT9pG0YwHHLYjesdLFi+PuDbCQdY9pG6sj6yv5jQn6jHOBCD+n97m2ZFds7osOh/R7X2MxHDIU9eehWXAZ7L3JGAdyaPifsMayRQWsi2bNSR6Qu1M4jNrnQP4DY82PeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf-next,v3 2/9] netfilter: nf_tables: reject element expiration with no timeout
Date: Tue,  3 Sep 2024 15:55:26 +0200
Message-Id: <20240903135533.2021-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240903135533.2021-1-pablo@netfilter.org>
References: <20240903135533.2021-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If element timeout is unset and set provides no default timeout, the
element expiration is silently ignored, reject this instead to let user
know this is unsupported.

Also prepare for supporting timeout that never expire, where zero
timeout and expiration must be also rejected.

Fixes: 8e1102d5a159 ("netfilter: nf_tables: support timeouts larger than 23 days")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: no changes

 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6de74dae50fc..1884125ebb28 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6917,6 +6917,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (nla[NFTA_SET_ELEM_EXPIRATION] != NULL) {
 		if (!(set->flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
+		if (timeout == 0)
+			return -EOPNOTSUPP;
+
 		err = nf_msecs_to_jiffies64(nla[NFTA_SET_ELEM_EXPIRATION],
 					    &expiration);
 		if (err)
-- 
2.30.2


