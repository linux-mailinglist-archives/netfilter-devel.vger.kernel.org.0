Return-Path: <netfilter-devel+bounces-1000-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271818510C5
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Feb 2024 11:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E51B247B2
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Feb 2024 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25BA1862A;
	Mon, 12 Feb 2024 10:26:13 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FC1803A
	for <netfilter-devel@vger.kernel.org>; Mon, 12 Feb 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733573; cv=none; b=tv5gCpyNbtvSAs437Ne2eMKQY6kRveDFrvxIgzPocsSI/vdKjG6m+mgk4TvHXmKClCeHchHwo4h1xX7gtrCYXJ3+OJ2rCzMMMUZvptyBvbMqap3GF65SY5Oapk5rZpPUMi2PJ5Zqxz2/fVnwZ1tENupa8/utV26DN5OVHOpwjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733573; c=relaxed/simple;
	bh=SlSS6qvsf99OLbwicFkR0HZkNC5U0um0tWsIJJF+e7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhJprea1ewr7yLGmVKNywnq9pwLLpxpUHQUY3Kw987n0LpyGfBBYipS8Y7/Pc4RvKJhT6VwP2DCKxECCgcl4/zpU4lua7eUx/Ppps6j92bbym2dIG5j2QD2hO/0C9vENuZDmZDWzgMWXHZBl0q9xD6D3Xx/nJtHmWHQhsFvTArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rZTVp-0005pq-RZ; Mon, 12 Feb 2024 11:26:09 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: sbrivio@redhat.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 3/4] netfilter: nft_set_pipapo: shrink data structures
Date: Mon, 12 Feb 2024 11:01:52 +0100
Message-ID: <20240212100202.10116-4-fw@strlen.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212100202.10116-1-fw@strlen.de>
References: <20240212100202.10116-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The set uses a mix of 'int', 'unsigned int', and size_t.

The rule count limit is NFT_PIPAPO_RULE0_MAX, which cannot
exceed INT_MAX (a few helpers use 'int' as return type).

Add a compile-time assertion for this.

Replace size_t usage in structs with unsigned int or u8 where
the stored values are smaller.

Replace signed-int arguments for lengths with 'unsigned int'
where possible.

Last, remove lt_aligned member: its set but never read.

struct nft_pipapo_match 40 bytes -> 32 bytes
struct nft_pipapo_field 56 bytes -> 32 bytes

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_pipapo.c | 60 ++++++++++++++++++++++------------
 net/netfilter/nft_set_pipapo.h | 29 ++++++----------
 2 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 6a79ec98de86..a0ddf24a8052 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -359,11 +359,13 @@
  *
  * Return: -1 on no match, bit position on 'match_only', 0 otherwise.
  */
-int pipapo_refill(unsigned long *map, int len, int rules, unsigned long *dst,
+int pipapo_refill(unsigned long *map, unsigned int len, unsigned int rules,
+		  unsigned long *dst,
 		  const union nft_pipapo_map_bucket *mt, bool match_only)
 {
 	unsigned long bitset;
-	int k, ret = -1;
+	unsigned int k;
+	int ret = -1;
 
 	for (k = 0; k < len; k++) {
 		bitset = map[k];
@@ -632,13 +634,16 @@ nft_pipapo_get(const struct net *net, const struct nft_set *set,
  *
  * Return: 0 on success, -ENOMEM on allocation failure.
  */
-static int pipapo_resize(struct nft_pipapo_field *f, int old_rules, int rules)
+static int pipapo_resize(struct nft_pipapo_field *f, unsigned int old_rules, unsigned int rules)
 {
 	long *new_lt = NULL, *new_p, *old_lt = f->lt, *old_p;
 	union nft_pipapo_map_bucket *new_mt, *old_mt = f->mt;
-	size_t new_bucket_size, copy;
+	unsigned int new_bucket_size, copy;
 	int group, bucket;
 
+	if (rules >= NFT_PIPAPO_RULE0_MAX)
+		return -ENOSPC;
+
 	new_bucket_size = DIV_ROUND_UP(rules, BITS_PER_LONG);
 #ifdef NFT_PIPAPO_ALIGN
 	new_bucket_size = roundup(new_bucket_size,
@@ -691,7 +696,7 @@ static int pipapo_resize(struct nft_pipapo_field *f, int old_rules, int rules)
 
 	if (new_lt) {
 		f->bsize = new_bucket_size;
-		NFT_PIPAPO_LT_ASSIGN(f, new_lt);
+		f->lt = new_lt;
 		kvfree(old_lt);
 	}
 
@@ -848,8 +853,8 @@ static void pipapo_lt_8b_to_4b(int old_groups, int bsize,
  */
 static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 {
+	unsigned int groups, bb;
 	unsigned long *new_lt;
-	int groups, bb;
 	size_t lt_size;
 
 	lt_size = f->groups * NFT_PIPAPO_BUCKETS(f->bb) * f->bsize *
@@ -899,7 +904,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 	f->groups = groups;
 	f->bb = bb;
 	kvfree(f->lt);
-	NFT_PIPAPO_LT_ASSIGN(f, new_lt);
+	f->lt = new_lt;
 }
 
 /**
@@ -916,7 +921,7 @@ static void pipapo_lt_bits_adjust(struct nft_pipapo_field *f)
 static int pipapo_insert(struct nft_pipapo_field *f, const uint8_t *k,
 			 int mask_bits)
 {
-	int rule = f->rules, group, ret, bit_offset = 0;
+	unsigned int rule = f->rules, group, ret, bit_offset = 0;
 
 	ret = pipapo_resize(f, f->rules, f->rules + 1);
 	if (ret)
@@ -1256,8 +1261,14 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	/* Validate */
 	start_p = start;
 	end_p = end;
+
+	/* some helpers return -1, or 0 >= for valid rule pos,
+	 * so we cannot support more than INT_MAX rules at this time.
+	 */
+	BUILD_BUG_ON(NFT_PIPAPO_RULE0_MAX > INT_MAX);
+
 	nft_pipapo_for_each_field(f, i, m) {
-		if (f->rules >= (unsigned long)NFT_PIPAPO_RULE0_MAX)
+		if (f->rules >= NFT_PIPAPO_RULE0_MAX)
 			return -ENOSPC;
 
 		if (memcmp(start_p, end_p,
@@ -1363,7 +1374,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		if (!new_lt)
 			goto out_lt;
 
-		NFT_PIPAPO_LT_ASSIGN(dst, new_lt);
+		dst->lt = new_lt;
 
 		memcpy(NFT_PIPAPO_LT_ALIGN(new_lt),
 		       NFT_PIPAPO_LT_ALIGN(src->lt),
@@ -1433,10 +1444,10 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
  *
  * Return: Number of rules that originated from the same entry as @first.
  */
-static int pipapo_rules_same_key(struct nft_pipapo_field *f, int first)
+static unsigned int pipapo_rules_same_key(struct nft_pipapo_field *f, unsigned int first)
 {
 	struct nft_pipapo_elem *e = NULL; /* Keep gcc happy */
-	int r;
+	unsigned int r;
 
 	for (r = first; r < f->rules; r++) {
 		if (r != first && e != f->mt[r].e)
@@ -1489,8 +1500,8 @@ static int pipapo_rules_same_key(struct nft_pipapo_field *f, int first)
  *                        0      1      2
  *  element pointers:  0x42   0x42   0x44
  */
-static void pipapo_unmap(union nft_pipapo_map_bucket *mt, int rules,
-			 int start, int n, int to_offset, bool is_last)
+static void pipapo_unmap(union nft_pipapo_map_bucket *mt, unsigned int rules,
+			 unsigned int start, unsigned int n, unsigned int to_offset, bool is_last)
 {
 	int i;
 
@@ -1596,8 +1607,8 @@ static void pipapo_gc(struct nft_set *set, struct nft_pipapo_match *m)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct net *net = read_pnet(&set->net);
+	unsigned int rules_f0, first_rule = 0;
 	u64 tstamp = nft_net_tstamp(net);
-	int rules_f0, first_rule = 0;
 	struct nft_pipapo_elem *e;
 	struct nft_trans_gc *gc;
 
@@ -1608,7 +1619,7 @@ static void pipapo_gc(struct nft_set *set, struct nft_pipapo_match *m)
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
 		const struct nft_pipapo_field *f;
-		int i, start, rules_fx;
+		unsigned int i, start, rules_fx;
 
 		start = first_rule;
 		rules_fx = rules_f0;
@@ -1986,7 +1997,7 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *m = priv->clone;
-	int rules_f0, first_rule = 0;
+	unsigned int rules_f0, first_rule = 0;
 	struct nft_pipapo_elem *e;
 	const u8 *data;
 
@@ -2051,7 +2062,7 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 	struct net *net = read_pnet(&set->net);
 	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
-	int i, r;
+	unsigned int i, r;
 
 	rcu_read_lock();
 	if (iter->genmask == nft_genmask_cur(net))
@@ -2155,6 +2166,9 @@ static int nft_pipapo_init(const struct nft_set *set,
 
 	field_count = desc->field_count ? : 1;
 
+	BUILD_BUG_ON(NFT_PIPAPO_MAX_FIELDS > 255);
+	BUILD_BUG_ON(NFT_PIPAPO_MAX_FIELDS != NFT_REG32_COUNT);
+
 	if (field_count > NFT_PIPAPO_MAX_FIELDS)
 		return -EINVAL;
 
@@ -2176,7 +2190,11 @@ static int nft_pipapo_init(const struct nft_set *set,
 	rcu_head_init(&m->rcu);
 
 	nft_pipapo_for_each_field(f, i, m) {
-		int len = desc->field_len[i] ? : set->klen;
+		unsigned int len = desc->field_len[i] ? : set->klen;
+
+		/* f->groups is u8 */
+		BUILD_BUG_ON((NFT_PIPAPO_MAX_BYTES *
+			      BITS_PER_BYTE / NFT_PIPAPO_GROUP_BITS_LARGE_SET) >= 256);
 
 		f->bb = NFT_PIPAPO_GROUP_BITS_INIT;
 		f->groups = len * NFT_PIPAPO_GROUPS_PER_BYTE(f);
@@ -2185,7 +2203,7 @@ static int nft_pipapo_init(const struct nft_set *set,
 
 		f->bsize = 0;
 		f->rules = 0;
-		NFT_PIPAPO_LT_ASSIGN(f, NULL);
+		f->lt = NULL;
 		f->mt = NULL;
 	}
 
@@ -2221,7 +2239,7 @@ static void nft_set_pipapo_match_destroy(const struct nft_ctx *ctx,
 					 struct nft_pipapo_match *m)
 {
 	struct nft_pipapo_field *f;
-	int i, r;
+	unsigned int i, r;
 
 	for (i = 0, f = m->f; i < m->field_count - 1; i++, f++)
 		;
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 90d22d691afc..8d9486ae0c01 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -70,15 +70,9 @@
 #define NFT_PIPAPO_ALIGN_HEADROOM					\
 	(NFT_PIPAPO_ALIGN - ARCH_KMALLOC_MINALIGN)
 #define NFT_PIPAPO_LT_ALIGN(lt)		(PTR_ALIGN((lt), NFT_PIPAPO_ALIGN))
-#define NFT_PIPAPO_LT_ASSIGN(field, x)					\
-	do {								\
-		(field)->lt_aligned = NFT_PIPAPO_LT_ALIGN(x);		\
-		(field)->lt = (x);					\
-	} while (0)
 #else
 #define NFT_PIPAPO_ALIGN_HEADROOM	0
 #define NFT_PIPAPO_LT_ALIGN(lt)		(lt)
-#define NFT_PIPAPO_LT_ASSIGN(field, x)	((field)->lt = (x))
 #endif /* NFT_PIPAPO_ALIGN */
 
 #define nft_pipapo_for_each_field(field, index, match)		\
@@ -110,22 +104,18 @@ union nft_pipapo_map_bucket {
 
 /**
  * struct nft_pipapo_field - Lookup, mapping tables and related data for a field
- * @groups:	Amount of bit groups
  * @rules:	Number of inserted rules
  * @bsize:	Size of each bucket in lookup table, in longs
+ * @groups:	Amount of bit groups
  * @bb:		Number of bits grouped together in lookup table buckets
  * @lt:		Lookup table: 'groups' rows of buckets
- * @lt_aligned:	Version of @lt aligned to NFT_PIPAPO_ALIGN bytes
  * @mt:		Mapping table: one bucket per rule
  */
 struct nft_pipapo_field {
-	int groups;
-	unsigned long rules;
-	size_t bsize;
-	int bb;
-#ifdef NFT_PIPAPO_ALIGN
-	unsigned long *lt_aligned;
-#endif
+	unsigned int rules;
+	unsigned int bsize;
+	u8 groups;
+	u8 bb;
 	unsigned long *lt;
 	union nft_pipapo_map_bucket *mt;
 };
@@ -145,15 +135,15 @@ struct nft_pipapo_scratch {
 /**
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count		Amount of fields in set
- * @scratch:		Preallocated per-CPU maps for partial matching results
  * @bsize_max:		Maximum lookup table bucket size of all fields, in longs
+ * @scratch:		Preallocated per-CPU maps for partial matching results
  * @rcu			Matching data is swapped on commits
  * @f:			Fields, with lookup and mapping tables
  */
 struct nft_pipapo_match {
-	int field_count;
+	u8 field_count;
+	unsigned int bsize_max;
 	struct nft_pipapo_scratch * __percpu *scratch;
-	size_t bsize_max;
 	struct rcu_head rcu;
 	struct nft_pipapo_field f[] __counted_by(field_count);
 };
@@ -186,7 +176,8 @@ struct nft_pipapo_elem {
 	struct nft_set_ext	ext;
 };
 
-int pipapo_refill(unsigned long *map, int len, int rules, unsigned long *dst,
+int pipapo_refill(unsigned long *map, unsigned int len, unsigned int rules,
+		  unsigned long *dst,
 		  const union nft_pipapo_map_bucket *mt, bool match_only);
 
 /**
-- 
2.43.0


