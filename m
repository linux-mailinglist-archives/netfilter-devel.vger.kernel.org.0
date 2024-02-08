Return-Path: <netfilter-devel+bounces-950-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81E84D6B7
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 00:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6449CB215EE
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Feb 2024 23:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C176BFC6;
	Wed,  7 Feb 2024 23:37:42 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B41D6A8B9;
	Wed,  7 Feb 2024 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707349062; cv=none; b=R1560inKr7Y/taTy80YilbcbvbVsuYhSBTUgQQ/5w42PG1ibBudh2CjWh2QX1yIH/h+E0GCL6HnJ25McrmXCG1bTubXZ0UA5GU5vRt14AqMYO/pbvEYfolvw2ci5UcH1qWxTO/9kj1wVyO5fS9ZdYSI6qfatgx3SRjwYD4B9nL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707349062; c=relaxed/simple;
	bh=ZUS3AOC08vvTcXz0N2orRYLeWRPqjHUZjEMh/fpT8Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MyuuJS+zcJkyE09Hdu/pQpkWxOXrFLw/5sLyXmlfSv+u/ThFYYCDXX9QjyKc9HlIghFKFMljpW6kPkL6yfWL8FOkY0kFZrU7J9eDyjrQU77cIjddLo9jlCdfYz3O3nmusU81I3at5PlLkAFz28Q2KjVUVtM2HQIanlqFzDka54g=
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
Subject: [PATCH net 11/13] netfilter: nft_set_pipapo: store index in scratch maps
Date: Thu,  8 Feb 2024 00:37:24 +0100
Message-Id: <20240207233726.331592-12-pablo@netfilter.org>
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

Pipapo needs a scratchpad area to keep state during matching.
This state can be large and thus cannot reside on stack.

Each set preallocates percpu areas for this.

On each match stage, one scratchpad half starts with all-zero and the other
is inited to all-ones.

At the end of each stage, the half that starts with all-ones is
always zero.  Before next field is tested, pointers to the two halves
are swapped, i.e.  resmap pointer turns into fill pointer and vice versa.

After the last field has been processed, pipapo stashes the
index toggle in a percpu variable, with assumption that next packet
will start with the all-zero half and sets all bits in the other to 1.

This isn't reliable.

There can be multiple sets and we can't be sure that the upper
and lower half of all set scratch map is always in sync (lookups
can be conditional), so one set might have swapped, but other might
not have been queried.

Thus we need to keep the index per-set-and-cpu, just like the
scratchpad.

Note that this bug fix is incomplete, there is a related issue.

avx2 and normal implementation might use slightly different areas of the
map array space due to the avx2 alignment requirements, so
m->scratch (generic/fallback implementation) and ->scratch_aligned
(avx) may partially overlap. scratch and scratch_aligned are not distinct
objects, the latter is just the aligned address of the former.

After this change, write to scratch_align->map_index may write to
scratch->map, so this issue becomes more prominent, we can set to 1
a bit in the supposedly-all-zero area of scratch->map[].

A followup patch will remove the scratch_aligned and makes generic and
avx code use the same (aligned) area.

Its done in a separate change to ease review.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_pipapo.c      | 41 ++++++++++++++++++-----------
 net/netfilter/nft_set_pipapo.h      | 14 ++++++++--
 net/netfilter/nft_set_pipapo_avx2.c | 15 +++++------
 3 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 7ee4e54fbb4b..687c640fe745 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -342,9 +342,6 @@
 #include "nft_set_pipapo_avx2.h"
 #include "nft_set_pipapo.h"
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_scratch_index);
-
 /**
  * pipapo_refill() - For each set bit, set bits from selected mapping table item
  * @map:	Bitmap to be scanned for set bits
@@ -412,6 +409,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		       const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_scratch *scratch;
 	unsigned long *res_map, *fill_map;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
@@ -422,15 +420,17 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 
 	local_bh_disable();
 
-	map_index = raw_cpu_read(nft_pipapo_scratch_index);
-
 	m = rcu_dereference(priv->match);
 
 	if (unlikely(!m || !*raw_cpu_ptr(m->scratch)))
 		goto out;
 
-	res_map  = *raw_cpu_ptr(m->scratch) + (map_index ? m->bsize_max : 0);
-	fill_map = *raw_cpu_ptr(m->scratch) + (map_index ? 0 : m->bsize_max);
+	scratch = *raw_cpu_ptr(m->scratch);
+
+	map_index = scratch->map_index;
+
+	res_map  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill_map = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	memset(res_map, 0xff, m->bsize_max * sizeof(*res_map));
 
@@ -460,7 +460,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		b = pipapo_refill(res_map, f->bsize, f->rules, fill_map, f->mt,
 				  last);
 		if (b < 0) {
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return false;
@@ -477,7 +477,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 			 * current inactive bitmap is clean and can be reused as
 			 * *next* bitmap (not initial) for the next packet.
 			 */
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return true;
@@ -1122,12 +1122,12 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 	int i;
 
 	for_each_possible_cpu(i) {
-		unsigned long *scratch;
+		struct nft_pipapo_scratch *scratch;
 #ifdef NFT_PIPAPO_ALIGN
-		unsigned long *scratch_aligned;
+		void *scratch_aligned;
 #endif
-
-		scratch = kzalloc_node(bsize_max * sizeof(*scratch) * 2 +
+		scratch = kzalloc_node(struct_size(scratch, map,
+						   bsize_max * 2) +
 				       NFT_PIPAPO_ALIGN_HEADROOM,
 				       GFP_KERNEL, cpu_to_node(i));
 		if (!scratch) {
@@ -1146,7 +1146,16 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 		*per_cpu_ptr(clone->scratch, i) = scratch;
 
 #ifdef NFT_PIPAPO_ALIGN
-		scratch_aligned = NFT_PIPAPO_LT_ALIGN(scratch);
+		/* Align &scratch->map (not the struct itself): the extra
+		 * %NFT_PIPAPO_ALIGN_HEADROOM bytes passed to kzalloc_node()
+		 * above guarantee we can waste up to those bytes in order
+		 * to align the map field regardless of its offset within
+		 * the struct.
+		 */
+		BUILD_BUG_ON(offsetof(struct nft_pipapo_scratch, map) > NFT_PIPAPO_ALIGN_HEADROOM);
+
+		scratch_aligned = NFT_PIPAPO_LT_ALIGN(&scratch->map);
+		scratch_aligned -= offsetof(struct nft_pipapo_scratch, map);
 		*per_cpu_ptr(clone->scratch_aligned, i) = scratch_aligned;
 #endif
 	}
@@ -2135,7 +2144,7 @@ static int nft_pipapo_init(const struct nft_set *set,
 	m->field_count = field_count;
 	m->bsize_max = 0;
 
-	m->scratch = alloc_percpu(unsigned long *);
+	m->scratch = alloc_percpu(struct nft_pipapo_scratch *);
 	if (!m->scratch) {
 		err = -ENOMEM;
 		goto out_scratch;
@@ -2144,7 +2153,7 @@ static int nft_pipapo_init(const struct nft_set *set,
 		*per_cpu_ptr(m->scratch, i) = NULL;
 
 #ifdef NFT_PIPAPO_ALIGN
-	m->scratch_aligned = alloc_percpu(unsigned long *);
+	m->scratch_aligned = alloc_percpu(struct nft_pipapo_scratch *);
 	if (!m->scratch_aligned) {
 		err = -ENOMEM;
 		goto out_free;
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 1040223da5fa..144b186c4caf 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -130,6 +130,16 @@ struct nft_pipapo_field {
 	union nft_pipapo_map_bucket *mt;
 };
 
+/**
+ * struct nft_pipapo_scratch - percpu data used for lookup and matching
+ * @map_index	Current working bitmap index, toggled between field matches
+ * @map		store partial matching results during lookup
+ */
+struct nft_pipapo_scratch {
+	u8 map_index;
+	unsigned long map[];
+};
+
 /**
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count		Amount of fields in set
@@ -142,9 +152,9 @@ struct nft_pipapo_field {
 struct nft_pipapo_match {
 	int field_count;
 #ifdef NFT_PIPAPO_ALIGN
-	unsigned long * __percpu *scratch_aligned;
+	struct nft_pipapo_scratch * __percpu *scratch_aligned;
 #endif
-	unsigned long * __percpu *scratch;
+	struct nft_pipapo_scratch * __percpu *scratch;
 	size_t bsize_max;
 	struct rcu_head rcu;
 	struct nft_pipapo_field f[] __counted_by(field_count);
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 52e0d026d30a..78213c73af2e 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -71,9 +71,6 @@
 #define NFT_PIPAPO_AVX2_ZERO(reg)					\
 	asm volatile("vpxor %ymm" #reg ", %ymm" #reg ", %ymm" #reg)
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_avx2_scratch_index);
-
 /**
  * nft_pipapo_avx2_prepare() - Prepare before main algorithm body
  *
@@ -1120,11 +1117,12 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			    const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	unsigned long *res, *fill, *scratch;
+	struct nft_pipapo_scratch *scratch;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
 	struct nft_pipapo_match *m;
 	struct nft_pipapo_field *f;
+	unsigned long *res, *fill;
 	bool map_index;
 	int i, ret = 0;
 
@@ -1146,10 +1144,11 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 		kernel_fpu_end();
 		return false;
 	}
-	map_index = raw_cpu_read(nft_pipapo_avx2_scratch_index);
 
-	res  = scratch + (map_index ? m->bsize_max : 0);
-	fill = scratch + (map_index ? 0 : m->bsize_max);
+	map_index = scratch->map_index;
+
+	res  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	/* Starting map doesn't need to be set for this implementation */
 
@@ -1221,7 +1220,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 
 out:
 	if (i % 2)
-		raw_cpu_write(nft_pipapo_avx2_scratch_index, !map_index);
+		scratch->map_index = !map_index;
 	kernel_fpu_end();
 
 	return ret >= 0;
-- 
2.30.2


