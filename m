Return-Path: <netfilter-devel+bounces-3013-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C493443B
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2024 23:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CA21C20AF3
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jul 2024 21:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98B187325;
	Wed, 17 Jul 2024 21:52:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3555B36AEC;
	Wed, 17 Jul 2024 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253150; cv=none; b=BWt17zzgo9o4hUOPPyOO1sNgw4WBW7m6U4C35oxovoCy3+o1Ysyp8qezX2XBAAZ8xYZ28S/0rY1ALIA2GITbRj481malBVGTZLTWB3AxGGTvm7QNtFHu/C46D0mdtywjiCyyMau56eRLkOAHPN7KIv/kEQRNth+7Fa9UDqf/LVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253150; c=relaxed/simple;
	bh=vyePOu/V21C2fLF+74+Frg6UCE5nvON5C5BgJYJD2mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rb8yvtNIoLzH4EKyhDZ7fIjK13c6jkCztfbUavZle1vssOc4BoL2opfkjFsR9gxagjYH7xRThjRxoT3JpBfmYJHtG0lhleVaqs4ZHhkfnyc58cXZO+ktoRrUv3xNERSJLZBpu2Spqf88r7dan26BQr/45HfQQZBlinQLNUTO4BU=
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
Subject: [PATCH net 2/4] netfilter: nf_set_pipapo: fix initial map fill
Date: Wed, 17 Jul 2024 23:52:12 +0200
Message-Id: <20240717215214.225394-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240717215214.225394-1-pablo@netfilter.org>
References: <20240717215214.225394-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

The initial buffer has to be inited to all-ones, but it must restrict
it to the size of the first field, not the total field size.

After each round in the map search step, the result and the fill map
are swapped, so if we have a set where f->bsize of the first element
is smaller than m->bsize_max, those one-bits are leaked into future
rounds result map.

This makes pipapo find an incorrect matching results for sets where
first field size is not the largest.

Followup patch adds a test case to nft_concat_range.sh selftest script.

Thanks to Stefano Brivio for pointing out that we need to zero out
the remainder explicitly, only correcting memset() argument isn't enough.

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Reported-by: Yi Chen <yiche@redhat.com>
Cc: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_pipapo.c      |  4 ++--
 net/netfilter/nft_set_pipapo.h      | 21 +++++++++++++++++++++
 net/netfilter/nft_set_pipapo_avx2.c | 10 ++++++----
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 15a236bebb46..eb4c4a4ac7ac 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -434,7 +434,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 	res_map  = scratch->map + (map_index ? m->bsize_max : 0);
 	fill_map = scratch->map + (map_index ? 0 : m->bsize_max);
 
-	memset(res_map, 0xff, m->bsize_max * sizeof(*res_map));
+	pipapo_resmap_init(m, res_map);
 
 	nft_pipapo_for_each_field(f, i, m) {
 		bool last = i == m->field_count - 1;
@@ -542,7 +542,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 		goto out;
 	}
 
-	memset(res_map, 0xff, m->bsize_max * sizeof(*res_map));
+	pipapo_resmap_init(m, res_map);
 
 	nft_pipapo_for_each_field(f, i, m) {
 		bool last = i == m->field_count - 1;
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 0d2e40e10f7f..4a2ff85ce1c4 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -278,4 +278,25 @@ static u64 pipapo_estimate_size(const struct nft_set_desc *desc)
 	return size;
 }
 
+/**
+ * pipapo_resmap_init() - Initialise result map before first use
+ * @m:		Matching data, including mapping table
+ * @res_map:	Result map
+ *
+ * Initialize all bits covered by the first field to one, so that after
+ * the first step, only the matching bits of the first bit group remain.
+ *
+ * If other fields have a large bitmap, set remainder of res_map to 0.
+ */
+static inline void pipapo_resmap_init(const struct nft_pipapo_match *m, unsigned long *res_map)
+{
+	const struct nft_pipapo_field *f = m->f;
+	int i;
+
+	for (i = 0; i < f->bsize; i++)
+		res_map[i] = ULONG_MAX;
+
+	for (i = f->bsize; i < m->bsize_max; i++)
+		res_map[i] = 0ul;
+}
 #endif /* _NFT_SET_PIPAPO_H */
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index d08407d589ea..8910a5ac7ed1 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1036,6 +1036,7 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
 
 /**
  * nft_pipapo_avx2_lookup_slow() - Fallback function for uncommon field sizes
+ * @mdata:	Matching data, including mapping table
  * @map:	Previous match result, used as initial bitmap
  * @fill:	Destination bitmap to be filled with current match result
  * @f:		Field, containing lookup and mapping tables
@@ -1051,7 +1052,8 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
  * Return: -1 on no match, rule index of match if @last, otherwise first long
  * word index to be checked next (i.e. first filled word).
  */
-static int nft_pipapo_avx2_lookup_slow(unsigned long *map, unsigned long *fill,
+static int nft_pipapo_avx2_lookup_slow(const struct nft_pipapo_match *mdata,
+					unsigned long *map, unsigned long *fill,
 					const struct nft_pipapo_field *f,
 					int offset, const u8 *pkt,
 					bool first, bool last)
@@ -1060,7 +1062,7 @@ static int nft_pipapo_avx2_lookup_slow(unsigned long *map, unsigned long *fill,
 	int i, ret = -1, b;
 
 	if (first)
-		memset(map, 0xff, bsize * sizeof(*map));
+		pipapo_resmap_init(mdata, map);
 
 	for (i = offset; i < bsize; i++) {
 		if (f->bb == 8)
@@ -1186,7 +1188,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			} else if (f->groups == 16) {
 				NFT_SET_PIPAPO_AVX2_LOOKUP(8, 16);
 			} else {
-				ret = nft_pipapo_avx2_lookup_slow(res, fill, f,
+				ret = nft_pipapo_avx2_lookup_slow(m, res, fill, f,
 								  ret, rp,
 								  first, last);
 			}
@@ -1202,7 +1204,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			} else if (f->groups == 32) {
 				NFT_SET_PIPAPO_AVX2_LOOKUP(4, 32);
 			} else {
-				ret = nft_pipapo_avx2_lookup_slow(res, fill, f,
+				ret = nft_pipapo_avx2_lookup_slow(m, res, fill, f,
 								  ret, rp,
 								  first, last);
 			}
-- 
2.30.2


