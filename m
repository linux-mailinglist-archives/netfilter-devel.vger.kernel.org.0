Return-Path: <netfilter-devel+bounces-11136-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XuJ1EYQTsmnKIQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11136-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 02:14:44 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0422226BDD5
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F14693025E42
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD533EAFF;
	Thu, 12 Mar 2026 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="DN1dtVax"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9B2F0673
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773278077; cv=none; b=ZHFbE2dmOfgZ0uiVpLdoas279TlsmyTkI3tKrz8cG1JX6fybMsquFm47TNgCWUe8FPbNIokexAH+iW2gYPyGV3liNvmdIqQSHIaIMGFDCFkiSgmfZSLX+g1qLTjJAXnIuzG1UZY09zzOTvV9Tc7m0hsW6ToHFHN1PE3itGorQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773278077; c=relaxed/simple;
	bh=0f35bsW2VVRU39WCAynWxdpG6tswHh39xkgsH46NMkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lktjCkEcNHJYMbNZZcPH8e4lvresiKNXWmlWXThY3KeQTITuGFkt96KjJxwx3u873W/YlVg2IobhZiMOk82JHbX4OJ8gV8/DGhBnJiG50gQ5JY5xvrRy5Pfl0yXlR7xKbiPyDQKvL57+Sl6FwljKPKZ8PcJ9gv0wh/5Gbq3WUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=DN1dtVax; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id AD4386058D;
	Thu, 12 Mar 2026 02:14:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1773278071;
	bh=dBWO3p8/UyXu0GYtvOAmInL4ts7eHt4IHO3iv5aA2t8=;
	h=From:To:Cc:Subject:Date:From;
	b=DN1dtVaxakzBcbYRBKZcjrKMOXDM2MKAIS7vQu+ed7pcsjCmrxtuVsmEx6sqHVm0v
	 mTh7sN4TbfwIb4nX5d+PiOQHt/RHswvjHazqqvn0wNJFNaV3kYdoyZdosV8HPpwjxg
	 4IMyPHPDORzU2XqI2AW58jld1yQSfnXa59UDnZp3QviQPU1oH+R2aoV8zy4UyffnkK
	 ZLgrw1ugj/YW91sEtnt1fi4pJ4U11IyPq/o8Fx5WO9Cx2/8SLzLal0dPKVmaTTwV3b
	 j22P8OlnEjsBwYiKnzJo3y7+S7Ae80eZEofr6P6E3Ix4VEMCgPcuTG4IiliMPybx8C
	 uaYskvQoZ9xZQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: carges@cloudflare.com,
	fw@strlen.de
Subject: [PATCH nf] netfilter: nft_set_rbtree: revisit array resize logic
Date: Thu, 12 Mar 2026 02:14:23 +0100
Message-ID: <20260312011423.3492328-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11136-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	MSBL_EBL_FAIL(0.00)[carges@cloudflare.com:query timed out];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:email]
X-Rspamd-Queue-Id: 0422226BDD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Start by 8192 slots in the array and expand it by pow of 2 to simplify
growth and shrink logic.

Use set->ndeact to subtract deactivated elements when calculating the
number of the slots in the array.

Add shrink logic to deal with flush+add set, otherwise the array size
array gets increased artifically.

Reported-by: Chris Arges <carges@cloudflare.com>
Fixes: 7e43e0a1141d ("netfilter: nft_set_rbtree: translate rbtree to array for binary search")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Chris, I'm posting this patch, but I am not sure it fits into the
scenario you described.

 net/netfilter/nft_set_rbtree.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index bdcea649467f..b0a3503bbd81 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -616,14 +616,14 @@ static struct nft_array *nft_array_alloc(u32 max_intervals)
 	return array;
 }
 
-#define NFT_ARRAY_EXTRA_SIZE	10240
+#define NFT_ARRAY_INITIAL_SIZE	8192
 
 /* Similar to nft_rbtree_{u,k}size to hide details to userspace, but consider
  * packed representation coming from userspace for anonymous sets too.
  */
 static u32 nft_array_elems(const struct nft_set *set)
 {
-	u32 nelems = atomic_read(&set->nelems);
+	u32 nelems = atomic_read(&set->nelems) - set->ndeact;
 
 	/* Adjacent intervals are represented with a single start element in
 	 * anonymous sets, use the current element counter as is.
@@ -649,7 +649,7 @@ static int nft_array_may_resize(const struct nft_set *set)
 		if (priv->array)
 			new_max_intervals = priv->array->max_intervals;
 		else
-			new_max_intervals = NFT_ARRAY_EXTRA_SIZE;
+			new_max_intervals = NFT_ARRAY_INITIAL_SIZE;
 
 		array = nft_array_alloc(new_max_intervals);
 		if (!array)
@@ -658,10 +658,18 @@ static int nft_array_may_resize(const struct nft_set *set)
 		priv->array_next = array;
 	}
 
+	if (nelems >= NFT_ARRAY_INITIAL_SIZE && nelems < (priv->array_next->max_intervals >> 1)) {
+		new_max_intervals = priv->array_next->max_intervals >> 1;
+		if (nft_array_intervals_alloc(priv->array_next, new_max_intervals) < 0)
+			return -ENOMEM;
+
+		return 0;
+	}
+
 	if (nelems < priv->array_next->max_intervals)
 		return 0;
 
-	new_max_intervals = priv->array_next->max_intervals + NFT_ARRAY_EXTRA_SIZE;
+	new_max_intervals = priv->array_next->max_intervals << 1;
 	if (nft_array_intervals_alloc(priv->array_next, new_max_intervals) < 0)
 		return -ENOMEM;
 
-- 
2.47.3


