Return-Path: <netfilter-devel+bounces-949-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442F84D6B6
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 00:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBC1B22CF1
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Feb 2024 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5326BFBF;
	Wed,  7 Feb 2024 23:37:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84CC6A8C6;
	Wed,  7 Feb 2024 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349062; cv=none; b=t5ELr4qz5SUnlpIZ7zBmgLl1Vy7kzjUv5brTDBKFf/xRg5u9ISJm36yRkF/uyURMeg8QrmxnwPGDaWXvMLsCe0Yuw5WAj6VNBK3xexZSJ0hoJbFhxQXkarLUNP0XEFoa6isyOaFNxJfG1n9b0iuNUsLIiYBBdqnTyUz+vc4Jz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349062; c=relaxed/simple;
	bh=B2FBbcPSNWbRZ4PkgF4e8kesNIICipHfJ6hwGXwO+1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ofre6q3ZAN1NecJPfpVMXzpsh/qE6k2X+3xQIgK99U+yGYXePRafPjYNMF/A9vPKxyyEVON3VbYchZCWpCjh1aqOkA3lTQj607CvXApz7+MK8lXk4epULOHGKBE1WswTOE87zukuribGC7QkDO81t+rPbBx1XLFDr3ImlWvTxOU=
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
Subject: [PATCH net 12/13] netfilter: nft_set_pipapo: add helper to release pcpu scratch area
Date: Thu,  8 Feb 2024 00:37:25 +0100
Message-Id: <20240207233726.331592-13-pablo@netfilter.org>
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

From: Florian Westphal <fw@strlen.de>

After next patch simple kfree() is not enough anymore, so add
a helper for it.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_pipapo.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 687c640fe745..dbcd925d5c95 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1109,6 +1109,24 @@ static void pipapo_map(struct nft_pipapo_match *m,
 		f->mt[map[i].to + j].e = e;
 }
 
+/**
+ * pipapo_free_scratch() - Free per-CPU map at original (not aligned) address
+ * @m:		Matching data
+ * @cpu:	CPU number
+ */
+static void pipapo_free_scratch(const struct nft_pipapo_match *m, unsigned int cpu)
+{
+	struct nft_pipapo_scratch *s;
+	void *mem;
+
+	s = *per_cpu_ptr(m->scratch, cpu);
+	if (!s)
+		return;
+
+	mem = s;
+	kfree(mem);
+}
+
 /**
  * pipapo_realloc_scratch() - Reallocate scratch maps for partial match results
  * @clone:	Copy of matching data with pending insertions and deletions
@@ -1141,7 +1159,7 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 			return -ENOMEM;
 		}
 
-		kfree(*per_cpu_ptr(clone->scratch, i));
+		pipapo_free_scratch(clone, i);
 
 		*per_cpu_ptr(clone->scratch, i) = scratch;
 
@@ -1368,7 +1386,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	}
 out_scratch_realloc:
 	for_each_possible_cpu(i)
-		kfree(*per_cpu_ptr(new->scratch, i));
+		pipapo_free_scratch(new, i);
 #ifdef NFT_PIPAPO_ALIGN
 	free_percpu(new->scratch_aligned);
 #endif
@@ -1652,7 +1670,7 @@ static void pipapo_free_match(struct nft_pipapo_match *m)
 	int i;
 
 	for_each_possible_cpu(i)
-		kfree(*per_cpu_ptr(m->scratch, i));
+		pipapo_free_scratch(m, i);
 
 #ifdef NFT_PIPAPO_ALIGN
 	free_percpu(m->scratch_aligned);
@@ -2252,7 +2270,7 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 		free_percpu(m->scratch_aligned);
 #endif
 		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(m->scratch, cpu));
+			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
 		pipapo_free_fields(m);
 		kfree(m);
@@ -2269,7 +2287,7 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 		free_percpu(priv->clone->scratch_aligned);
 #endif
 		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(priv->clone->scratch, cpu));
+			pipapo_free_scratch(priv->clone, cpu);
 		free_percpu(priv->clone->scratch);
 
 		pipapo_free_fields(priv->clone);
-- 
2.30.2


