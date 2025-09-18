Return-Path: <netfilter-devel+bounces-8749-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE474B510A4
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Sep 2025 10:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9774464DFD
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Sep 2025 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70430FC3F;
	Wed, 10 Sep 2025 08:03:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8130FC2A
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Sep 2025 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491404; cv=none; b=lW33jJhVRJ2FxEQCGPAJd++sfOrTS9SJslQfL1peFWe2QnIFS0aSqCN8mE5Qo1Gs9ByjSVSqngKTFXfpMeNCOZ7y7osB8FMXnobmqCHS3PcTHJ6ClZPrYushSKUZIhGwtEd1AXG63poViV3Uykb5qBsciXaNTZSVtsY139RoYUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491404; c=relaxed/simple;
	bh=htwj2a/YsxqxTxlHgw3XZSijRZgZ4KcSpbxaRIhbswQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLbHclktUkKarqs4FEg88DLODN+E9oDzZauKZJ1dZkk7CODMUxo3k4mpQeQqAOdv2fE0bm/bGkzvKF03EE/xBf6fgF5l+ONdNWQr0AVLAkfYySIGBuIDwBr8zfOCpgzyjtoyqN22eH4IokIxyyIGt12mkQx//aiwrxv5m8vy6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EB4736061A; Wed, 10 Sep 2025 10:03:13 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: s.hanreich@proxmox.com,
	Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>
Subject: [PATCH nf 1/5] netfilter: nft_set_pipapo: don't check genbit from packetpath lookups
Date: Wed, 10 Sep 2025 10:02:18 +0200
Message-ID: <20250910080227.11174-2-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250910080227.11174-1-fw@strlen.de>
References: <20250910080227.11174-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pipapo set type is special in that it has two copies of its
datastructure: one live copy containing only valid elements and one
on-demand clone used during transaction where adds/deletes happen.

This clone is not visible to the datapath.

This is unlike all other set types in nftables, those all link new
elements into their live hlist/tree.

For those sets, the lookup functions must skip the new elements while the
transaction is ongoing to ensure consistency.

As the clone is shallow, removal does have an effect on the packet path:
once the transaction enters the commit phase the 'gencursor' bit that
determines which elements are active and which elements should be ignored
(because they are no longer valid) is flipped.

This causes the datapath lookup to ignore these elements if they are found
during lookup.

This opens up a small race window where pipapo has an inconsistent view of
the dataset from when the transaction-cpu flipped the genbit until the
transaction-cpu calls nft_pipapo_commit() to swap live/clone pointers:

cpu0					cpu1
  has added new elements to clone
  has marked elements as being
  inactive in new generation
					perform lookup in the set
  enters commit phase:

I) increments the genbit
					A) observes new genbit
  removes elements from the clone so
  they won't be found anymore
					B) lookup in datastructure
					   can't see new elements yet,
					   but old elements are ignored
					   -> Only matches elements that
					   were not changed in the
					   transaction
II) calls nft_pipapo_commit(), clone
    and live pointers are swapped.
					C New nft_lookup happening now
				       	  will find matching elements.

Consider a packet matching range r1-r2:

cpu0 processes following transaction:
1. remove r1-r2
2. add r1-r3

P is contained in both ranges. Therefore, cpu1 should always find a match
for P.  Due to above race, this is not the case:

cpu1 does find r1-r2, but then ignores it due to the genbit indicating
the range has been removed.

At the same time, r1-r3 is not visible yet, because it can only be found
in the clone.

The situation persists for all lookups until after cpu0 hits II).

The fix is easy: Don't check the genbit from pipapo lookup functions.
This is possible because unlike the other set types, the new elements are
not reachable from the live copy of the dataset.

The clone/live pointer swap is enough to avoid matching on old elements
while at the same time all new elements are exposed in one go.

After this change, step B above returns a match in r1-r2.
This is fine: r1-r2 only becomes truly invalid the moment they get freed.
This happens after a synchronize_rcu() call and rcu read lock is held
via netfilter hook traversal (nf_hook_slow()).

Cc: Stefano Brivio <sbrivio@redhat.com>
Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_pipapo.c      | 20 ++++++++++++++++++--
 net/netfilter/nft_set_pipapo_avx2.c |  4 +---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 9a10251228fd..793790d79d13 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -510,6 +510,23 @@ static struct nft_pipapo_elem *pipapo_get(const struct nft_pipapo_match *m,
  *
  * This function is called from the data path.  It will search for
  * an element matching the given key in the current active copy.
+ * Unlike other set types, this uses NFT_GENMASK_ANY instead of
+ * nft_genmask_cur().
+ *
+ * This is because new (future) elements are not reachable from
+ * priv->match, they get added to priv->clone instead.
+ * When the commit phase flips the generation bitmask, the
+ * 'now old' entries are skipped but without the 'now current'
+ * elements becoming visible. Using nft_genmask_cur() thus creates
+ * inconsistent state: matching old entries get skipped but thew
+ * newly matching entries are unreachable.
+ *
+ * GENMASK will still find the 'now old' entries which ensures consistent
+ * priv->match view.
+ *
+ * nft_pipapo_commit swaps ->clone and ->match shortly after the
+ * genbit flip.  As ->clone doesn't contain the old entries in the first
+ * place, lookup will only find the now-current ones.
  *
  * Return: ntables API extension pointer or NULL if no match.
  */
@@ -518,12 +535,11 @@ nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		  const u32 *key)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	u8 genmask = nft_genmask_cur(net);
 	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_elem *e;
 
 	m = rcu_dereference(priv->match);
-	e = pipapo_get(m, (const u8 *)key, genmask, get_jiffies_64());
+	e = pipapo_get(m, (const u8 *)key, NFT_GENMASK_ANY, get_jiffies_64());
 
 	return e ? &e->ext : NULL;
 }
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 2f090e253caf..c0884fa68c79 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1152,7 +1152,6 @@ nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo *priv = nft_set_priv(set);
 	const struct nft_set_ext *ext = NULL;
 	struct nft_pipapo_scratch *scratch;
-	u8 genmask = nft_genmask_cur(net);
 	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	const u8 *rp = (const u8 *)key;
@@ -1248,8 +1247,7 @@ nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 		if (last) {
 			const struct nft_set_ext *e = &f->mt[ret].e->ext;
 
-			if (unlikely(nft_set_elem_expired(e) ||
-				     !nft_set_elem_active(e, genmask)))
+			if (unlikely(nft_set_elem_expired(e)))
 				goto next_match;
 
 			ext = e;
-- 
2.49.1


