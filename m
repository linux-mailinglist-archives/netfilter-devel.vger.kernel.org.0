Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06714ED5EB
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Mar 2022 10:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiCaImO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Mar 2022 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiCaImO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:42:14 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE371F6F1A;
        Thu, 31 Mar 2022 01:40:26 -0700 (PDT)
Message-ID: <e730480d-9396-6486-ab98-67ecb683e819@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648716024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gjd+dbhFmrBLNB/9TKNS+UOHcvb+YXKxRkGJlSXZ+Tw=;
        b=SNknQRMaIDmyxd6oN5iXxs3eXvXhPLSnioo7N0kQXqV0Phb5RdHweKFC3vVD0tGSuBn0Kv
        xPvS31sPQoh0yuaDJYF9FieeW9zCvVucER8X3/M01ojzNDzDcf2MiKIE3bOPCpo7DXwROu
        OGCS/uQs3oo50FkVzKLSKxC//Vs/pLg=
Date:   Thu, 31 Mar 2022 11:40:23 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: [PATCH nft] nft: memcg accounting for dynamically allocated objects
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     kernel@openvz.org, Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <bf4b8fe3-6dd6-4f3a-12f4-1b5bf2e45783@linux.dev>
Content-Language: en-US
In-Reply-To: <bf4b8fe3-6dd6-4f3a-12f4-1b5bf2e45783@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nft_*.c files whose NFT_EXPR_STATEFUL flag is set on need to
use __GFP_ACCOUNT flag for objects that are dynamically
allocated from the packet path.

Such objects are allocated inside .init() or .clone() callbacks
of struct nft_expr_ops executed in task context while processing
netlink messages.

In addition, this patch adds accounting to nft_set_elem_expr_clone()
used for the same purposes.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 net/netfilter/nft_connlimit.c | 4 ++--
 net/netfilter/nft_counter.c   | 4 ++--
 net/netfilter/nft_last.c      | 4 ++--
 net/netfilter/nft_limit.c     | 4 ++--
 net/netfilter/nft_quota.c     | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 04be94236a34..e01241151ef7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5447,7 +5447,7 @@ int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
 	int err, i, k;
 
 	for (i = 0; i < set->num_exprs; i++) {
-		expr = kzalloc(set->exprs[i]->ops->size, GFP_KERNEL);
+		expr = kzalloc(set->exprs[i]->ops->size, GFP_KERNEL_ACCOUNT);
 		if (!expr)
 			goto err_expr;
 
diff --git a/net/netfilter/nft_connlimit.c b/net/netfilter/nft_connlimit.c
index 3362417ebfdb..9c2146aac59e 100644
--- a/net/netfilter/nft_connlimit.c
+++ b/net/netfilter/nft_connlimit.c
@@ -77,7 +77,7 @@ static int nft_connlimit_do_init(const struct nft_ctx *ctx,
 			invert = true;
 	}
 
-	priv->list = kmalloc(sizeof(*priv->list), GFP_KERNEL);
+	priv->list = kmalloc(sizeof(*priv->list), GFP_KERNEL_ACCOUNT);
 	if (!priv->list)
 		return -ENOMEM;
 
@@ -214,7 +214,7 @@ static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src)
 	struct nft_connlimit *priv_dst = nft_expr_priv(dst);
 	struct nft_connlimit *priv_src = nft_expr_priv(src);
 
-	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC);
+	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!priv_dst->list)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index f179e8c3b0ca..040a697d96b3 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -62,7 +62,7 @@ static int nft_counter_do_init(const struct nlattr * const tb[],
 	struct nft_counter __percpu *cpu_stats;
 	struct nft_counter *this_cpu;
 
-	cpu_stats = alloc_percpu(struct nft_counter);
+	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_KERNEL_ACCOUNT);
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
@@ -235,7 +235,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
 
 	nft_counter_fetch(priv, &total);
 
-	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC);
+	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC | __GFP_ACCOUNT);
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_last.c b/net/netfilter/nft_last.c
index 4f745a409d34..4cf4f6349855 100644
--- a/net/netfilter/nft_last.c
+++ b/net/netfilter/nft_last.c
@@ -30,7 +30,7 @@ static int nft_last_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	u64 last_jiffies;
 	int err;
 
-	last = kzalloc(sizeof(*last), GFP_KERNEL);
+	last = kzalloc(sizeof(*last), GFP_KERNEL_ACCOUNT);
 	if (!last)
 		return -ENOMEM;
 
@@ -105,7 +105,7 @@ static int nft_last_clone(struct nft_expr *dst, const struct nft_expr *src)
 {
 	struct nft_last_priv *priv_dst = nft_expr_priv(dst);
 
-	priv_dst->last = kzalloc(sizeof(*priv_dst->last), GFP_ATOMIC);
+	priv_dst->last = kzalloc(sizeof(*priv_dst->last), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!priv_dst->last)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_limit.c b/net/netfilter/nft_limit.c
index a726b623963d..d7779d5f3cbb 100644
--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -90,7 +90,7 @@ static int nft_limit_init(struct nft_limit_priv *priv,
 				 priv->rate);
 	}
 
-	priv->limit = kmalloc(sizeof(*priv->limit), GFP_KERNEL);
+	priv->limit = kmalloc(sizeof(*priv->limit), GFP_KERNEL_ACCOUNT);
 	if (!priv->limit)
 		return -ENOMEM;
 
@@ -144,7 +144,7 @@ static int nft_limit_clone(struct nft_limit_priv *priv_dst,
 	priv_dst->burst = priv_src->burst;
 	priv_dst->invert = priv_src->invert;
 
-	priv_dst->limit = kmalloc(sizeof(*priv_dst->limit), GFP_ATOMIC);
+	priv_dst->limit = kmalloc(sizeof(*priv_dst->limit), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!priv_dst->limit)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
index f394a0b562f6..2def4d92a170 100644
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -90,7 +90,7 @@ static int nft_quota_do_init(const struct nlattr * const tb[],
 			return -EOPNOTSUPP;
 	}
 
-	priv->consumed = kmalloc(sizeof(*priv->consumed), GFP_KERNEL);
+	priv->consumed = kmalloc(sizeof(*priv->consumed), GFP_KERNEL_ACCOUNT);
 	if (!priv->consumed)
 		return -ENOMEM;
 
@@ -236,7 +236,7 @@ static int nft_quota_clone(struct nft_expr *dst, const struct nft_expr *src)
 {
 	struct nft_quota *priv_dst = nft_expr_priv(dst);
 
-	priv_dst->consumed = kmalloc(sizeof(*priv_dst->consumed), GFP_ATOMIC);
+	priv_dst->consumed = kmalloc(sizeof(*priv_dst->consumed), GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!priv_dst->consumed)
 		return -ENOMEM;
 
-- 
2.31.1

