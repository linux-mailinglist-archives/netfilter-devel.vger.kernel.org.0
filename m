Return-Path: <netfilter-devel+bounces-1012-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 172D2853363
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Feb 2024 15:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C915B21EA3
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Feb 2024 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC1958103;
	Tue, 13 Feb 2024 14:42:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD857895
	for <netfilter-devel@vger.kernel.org>; Tue, 13 Feb 2024 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835347; cv=none; b=PaKZI5lZL5hqctcTZ9ZQcGtE84nhId7l6eUtxt/pAY43x27Whm8BcwYBkVf20I2cUKZmTPm+zVJFic1QnRP3UDT9BJc5mQ9wKdQ1N3YMVT2uEh7OVUcHEwYtlEZSoa6vZFHE8fFKQwQWnye9VyLWlkqflTUHkGoSBPb/bJEiiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835347; c=relaxed/simple;
	bh=VRazo4BmnYwWzjXFE9BWrOn1SyFnRWfaDFVnBdPlia0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqCscp2DiGbtCCkFW1fXETXkpxJ7DrzISn9MFdSCtdRh8LgHYqak9DQ7B4n1tv4kdYW1hwWVHhkirtkJ4+CLv0PCanReeta2eILSqWj/+Q4utWn6CTrKCHVJBSBKO3TVzn98cW+QKi23H6XiOrrGOXITRpGLiy1KmmgCdC0PNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rZtzL-0000L6-3H; Tue, 13 Feb 2024 15:42:23 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: sbrivio@redhat.com,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v2 nf-next 1/4] netfilter: nft_set_pipapo: constify lookup fn args where possible
Date: Tue, 13 Feb 2024 16:23:37 +0100
Message-ID: <20240213152345.10590-2-fw@strlen.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213152345.10590-1-fw@strlen.de>
References: <20240213152345.10590-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those get called from packet path, content must not be modified.
No functional changes intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: reformat long lines, no code changes.

 net/netfilter/nft_set_pipapo.c      | 18 +++++----
 net/netfilter/nft_set_pipapo.h      |  6 +--
 net/netfilter/nft_set_pipapo_avx2.c | 59 +++++++++++++++++------------
 3 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index aa1d9e93a9a0..dedb17a4e07c 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -360,7 +360,7 @@
  * Return: -1 on no match, bit position on 'match_only', 0 otherwise.
  */
 int pipapo_refill(unsigned long *map, int len, int rules, unsigned long *dst,
-		  union nft_pipapo_map_bucket *mt, bool match_only)
+		  const union nft_pipapo_map_bucket *mt, bool match_only)
 {
 	unsigned long bitset;
 	int k, ret = -1;
@@ -412,9 +412,9 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo_scratch *scratch;
 	unsigned long *res_map, *fill_map;
 	u8 genmask = nft_genmask_cur(net);
+	const struct nft_pipapo_match *m;
+	const struct nft_pipapo_field *f;
 	const u8 *rp = (const u8 *)key;
-	struct nft_pipapo_match *m;
-	struct nft_pipapo_field *f;
 	bool map_index;
 	int i;
 
@@ -519,11 +519,13 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
 	struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *m = priv->clone;
 	unsigned long *res_map, *fill_map = NULL;
-	struct nft_pipapo_field *f;
+	const struct nft_pipapo_match *m;
+	const struct nft_pipapo_field *f;
 	int i;
 
+	m = priv->clone;
+
 	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
 	if (!res_map) {
 		ret = ERR_PTR(-ENOMEM);
@@ -1597,7 +1599,7 @@ static void pipapo_gc(struct nft_set *set, struct nft_pipapo_match *m)
 
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
-		struct nft_pipapo_field *f;
+		const struct nft_pipapo_field *f;
 		int i, start, rules_fx;
 
 		start = first_rule;
@@ -2039,8 +2041,8 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct net *net = read_pnet(&set->net);
-	struct nft_pipapo_match *m;
-	struct nft_pipapo_field *f;
+	const struct nft_pipapo_match *m;
+	const struct nft_pipapo_field *f;
 	int i, r;
 
 	rcu_read_lock();
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index f59a0cd81105..90d22d691afc 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -187,7 +187,7 @@ struct nft_pipapo_elem {
 };
 
 int pipapo_refill(unsigned long *map, int len, int rules, unsigned long *dst,
-		  union nft_pipapo_map_bucket *mt, bool match_only);
+		  const union nft_pipapo_map_bucket *mt, bool match_only);
 
 /**
  * pipapo_and_field_buckets_4bit() - Intersect 4-bit buckets
@@ -195,7 +195,7 @@ int pipapo_refill(unsigned long *map, int len, int rules, unsigned long *dst,
  * @dst:	Area to store result
  * @data:	Input data selecting table buckets
  */
-static inline void pipapo_and_field_buckets_4bit(struct nft_pipapo_field *f,
+static inline void pipapo_and_field_buckets_4bit(const struct nft_pipapo_field *f,
 						 unsigned long *dst,
 						 const u8 *data)
 {
@@ -223,7 +223,7 @@ static inline void pipapo_and_field_buckets_4bit(struct nft_pipapo_field *f,
  * @dst:	Area to store result
  * @data:	Input data selecting table buckets
  */
-static inline void pipapo_and_field_buckets_8bit(struct nft_pipapo_field *f,
+static inline void pipapo_and_field_buckets_8bit(const struct nft_pipapo_field *f,
 						 unsigned long *dst,
 						 const u8 *data)
 {
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 90e275bb3e5d..21f340d16e9e 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -212,8 +212,9 @@ static int nft_pipapo_avx2_refill(int offset, unsigned long *map,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_2(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	u8 pg[2] = { pkt[0] >> 4, pkt[0] & 0xf };
@@ -274,8 +275,9 @@ static int nft_pipapo_avx2_lookup_4b_2(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_4(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	u8 pg[4] = { pkt[0] >> 4, pkt[0] & 0xf, pkt[1] >> 4, pkt[1] & 0xf };
@@ -350,8 +352,9 @@ static int nft_pipapo_avx2_lookup_4b_4(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_8(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	u8 pg[8] = {  pkt[0] >> 4,  pkt[0] & 0xf,  pkt[1] >> 4,  pkt[1] & 0xf,
 		      pkt[2] >> 4,  pkt[2] & 0xf,  pkt[3] >> 4,  pkt[3] & 0xf,
@@ -445,8 +448,9 @@ static int nft_pipapo_avx2_lookup_4b_8(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_12(unsigned long *map, unsigned long *fill,
-				        struct nft_pipapo_field *f, int offset,
-				        const u8 *pkt, bool first, bool last)
+					const struct nft_pipapo_field *f,
+					int offset, const u8 *pkt,
+					bool first, bool last)
 {
 	u8 pg[12] = {  pkt[0] >> 4,  pkt[0] & 0xf,  pkt[1] >> 4,  pkt[1] & 0xf,
 		       pkt[2] >> 4,  pkt[2] & 0xf,  pkt[3] >> 4,  pkt[3] & 0xf,
@@ -534,8 +538,9 @@ static int nft_pipapo_avx2_lookup_4b_12(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_32(unsigned long *map, unsigned long *fill,
-					struct nft_pipapo_field *f, int offset,
-					const u8 *pkt, bool first, bool last)
+					const struct nft_pipapo_field *f,
+					int offset, const u8 *pkt,
+					bool first, bool last)
 {
 	u8 pg[32] = {  pkt[0] >> 4,  pkt[0] & 0xf,  pkt[1] >> 4,  pkt[1] & 0xf,
 		       pkt[2] >> 4,  pkt[2] & 0xf,  pkt[3] >> 4,  pkt[3] & 0xf,
@@ -669,8 +674,9 @@ static int nft_pipapo_avx2_lookup_4b_32(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_1(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -726,8 +732,9 @@ static int nft_pipapo_avx2_lookup_8b_1(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_2(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -790,8 +797,9 @@ static int nft_pipapo_avx2_lookup_8b_2(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_4(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -865,8 +873,9 @@ static int nft_pipapo_avx2_lookup_8b_4(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_6(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -950,8 +959,9 @@ static int nft_pipapo_avx2_lookup_8b_6(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
-					struct nft_pipapo_field *f, int offset,
-					const u8 *pkt, bool first, bool last)
+					const struct nft_pipapo_field *f,
+					int offset, const u8 *pkt,
+					bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -1042,8 +1052,9 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_slow(unsigned long *map, unsigned long *fill,
-					struct nft_pipapo_field *f, int offset,
-					const u8 *pkt, bool first, bool last)
+					const struct nft_pipapo_field *f,
+					int offset, const u8 *pkt,
+					bool first, bool last)
 {
 	unsigned long bsize = f->bsize;
 	int i, ret = -1, b;
@@ -1119,9 +1130,9 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_scratch *scratch;
 	u8 genmask = nft_genmask_cur(net);
+	const struct nft_pipapo_match *m;
+	const struct nft_pipapo_field *f;
 	const u8 *rp = (const u8 *)key;
-	struct nft_pipapo_match *m;
-	struct nft_pipapo_field *f;
 	unsigned long *res, *fill;
 	bool map_index;
 	int i, ret = 0;
-- 
2.43.0


