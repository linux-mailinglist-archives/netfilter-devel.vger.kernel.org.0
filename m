Return-Path: <netfilter-devel+bounces-2156-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9218C3755
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 May 2024 18:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB301F20F11
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 May 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064B50269;
	Sun, 12 May 2024 16:14:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFD44CB35;
	Sun, 12 May 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530493; cv=none; b=vBoj5/J+HA+7/YHOJ6CCanWCFCpuuDcfbS19CVMiJ0I6RZhOaE7ottYnjFPgbzoHrLLtlk3/SePINpWgSrdYVeU46z0LNVy/3ylXPstqFHA3C/Mfak51zOk6GlhQ3xf0FS61VFIACL73jztQTNsCzLPKy4ntItZAikOFkbJ1+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530493; c=relaxed/simple;
	bh=uHXtpDkqZpXO1jvNA6DSK746u84mOtiFS+C0aaGMpp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oe06d1tuvD1Szc55UwztMFNp6BAq5sqEezpvoSk3DeMYGAhVkBJ1fU9GoKQ4Az1wtvn1jQRj4YxRvu6hQbIO7cKNolVpb6GYhNlyB/AW93VYg/iUmt93Aw0HjgA/qXDFRgBvUS98QAqwMtJPYR5uJiW01uI2l7NeH0Mh/ENNJWQ=
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
Subject: [PATCH net-next 08/17] netfilter: nft_set_pipapo: move prove_locking helper around
Date: Sun, 12 May 2024 18:14:27 +0200
Message-Id: <20240512161436.168973-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240512161436.168973-1-pablo@netfilter.org>
References: <20240512161436.168973-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Preparation patch, the helper will soon get called from insert
function too.

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_pipapo.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 187138afac45..b8205d961ba4 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1247,6 +1247,17 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 	return 0;
 }
 
+static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	const struct net *net = read_pnet(&set->net);
+
+	return lockdep_is_held(&nft_pernet(net)->commit_mutex);
+#else
+	return true;
+#endif
+}
+
 /**
  * nft_pipapo_insert() - Validate and insert ranged elements
  * @net:	Network namespace
@@ -1799,17 +1810,6 @@ static void nft_pipapo_commit(struct nft_set *set)
 	priv->clone = new_clone;
 }
 
-static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
-{
-#ifdef CONFIG_PROVE_LOCKING
-	const struct net *net = read_pnet(&set->net);
-
-	return lockdep_is_held(&nft_pernet(net)->commit_mutex);
-#else
-	return true;
-#endif
-}
-
 static void nft_pipapo_abort(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-- 
2.30.2


