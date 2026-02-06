Return-Path: <netfilter-devel+bounces-10691-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK+aDLzfhWnFHgQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10691-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Feb 2026 13:34:04 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E73CCFDA11
	for <lists+netfilter-devel@lfdr.de>; Fri, 06 Feb 2026 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5389300EC9C
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Feb 2026 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC4C3A9D8B;
	Fri,  6 Feb 2026 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="B1767P0e"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AFF3A7F46
	for <netfilter-devel@vger.kernel.org>; Fri,  6 Feb 2026 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381241; cv=none; b=V0mDEahpsRwuE5x/HLaodOBPqQoJVf6NkpIOF/UNKUvnPeriQVbbPvWDjCD1RIlDTCZ6/SfeCpIQzTvr/8zaufOEQ9N9H/kG0KXDmgSY6dIH8xczlk0jdP6++ErwWPYi78NNoR08cvBVO4a12PjXzQEzYioVaA5HJRwBwLB+saQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381241; c=relaxed/simple;
	bh=etPnn+sjBVMd9QgdNBoK5ALMs/JbGJgOTv9XMCD4QPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGbXk3wBhBEXHAPdwwvVkhOgRM4gE0IpxrvQYPJEbTdENC9Lak8VCkGXGIn7mk6W+115POix2S2gJzf+4ovNBPQg93TNTtJFg78JyjKZxdsIMU2Lw0hDnR9dsN1c/nFXW/3Zg/RYvL7DcUJGPsQf5n4kOhPE4Q4WB0yLB+r7UjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=B1767P0e; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 688F660891;
	Fri,  6 Feb 2026 13:33:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770381233;
	bh=0zj4ewZiLpjboSIrSiLOtd7D03rrZonDwWkgK1hsfcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1767P0eMF/NPoZ7zsmahS5bhp38BXnwxs8MiunymE6QJ8h39y7n4+wd3xA6Glicu
	 dhAa4br0QJuswJn3enhIRTq/PGJ1QNoeDAdyjTWkQSpmASNS8MUE3ivx1p8nE49G/O
	 NOBXkNZd/pawCpxGi3QuGjdrTzGNDgMYHS4zPyQi6UWAR/YN6ruHcvCVwh/3Q7+1Vh
	 Ih/JSKp78kS7NOaSoxiRWGqi7dYgbDPUFJ3tHTH+dqFgYwnXUFAutSjMHuIm+Gx+w+
	 yTcL+uHKofFWAgn6upsZMDgpKMUEkwTD374quq4iOIGvQ3QzHcK32nFuWrbe4YZcXg
	 mBgj2PDJJFCMw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf-next,v3 3/4] netfilter: nft_set_rbtree: validate element belonging to interval
Date: Fri,  6 Feb 2026 13:33:45 +0100
Message-ID: <20260206123346.1529474-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206123346.1529474-1-pablo@netfilter.org>
References: <20260206123346.1529474-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-10691-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E73CCFDA11
X-Rspamd-Action: no action

The existing partial overlap detection does not check if the elements
belong to the interval, eg.

  add element inet x y { 1.1.1.1-2.2.2.2, 4.4.4.4-5.5.5.5 }
  add element inet x y { 1.1.1.1-5.5.5.5 } => this should fail: ENOENT

Similar situation occurs with deletions:

  add element inet x y { 1.1.1.1-2.2.2.2, 4.4.4.4-5.5.5.5}
  delete element inet x y { 1.1.1.1-5.5.5.5 } => this should fail: ENOENT

This currently works via mitigation by nft in userspace, which is
performing the overlap detection before sending the elements to the
kernel. This requires a previous netlink dump of the set content which
slows down incremental updates on interval sets, because a netlink set
content dump is needed.

This patch extends the existing overlap detection to track the most
recent start element that already exists. The pointer to the existing
start element is stored as a cookie (no pointer dereference is ever
possible). If the end element is added and it already exists, then
check that the existing end element is adjacent to the already existing
start element. Similar logic applies to element deactivation.

This patch also annotates the timestamp to identify if start cookie
comes from an older batch, in such case reset it. Otherwise, a failing
create element command leaves the start cookie in place, resulting in
bogus error reporting.

There is still a few more corner cases of overlap detection related to
the open interval that are addressed in follow up patches.

This is address an early design mistake where an interval is expressed
as two elements, using the NFT_SET_ELEM_INTERVAL_END flag, instead of
the more recent NFTA_SET_ELEM_KEY_END attribute that pipapo already
uses.

Fixes: 7c84d41416d8 ("netfilter: nft_set_rbtree: Detect partial overlaps on insertion")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: no changes

 net/netfilter/nft_set_rbtree.c | 147 ++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 14b4256bb00d..a4fb5b517d9d 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -33,8 +33,10 @@ struct nft_rbtree {
 	rwlock_t		lock;
 	struct nft_array __rcu	*array;
 	struct nft_array	*array_next;
+	unsigned long		start_rbe_cookie;
 	unsigned long		last_gc;
 	struct list_head	expired;
+	u64			last_tstamp;
 };
 
 struct nft_rbtree_elem {
@@ -263,16 +265,85 @@ static struct nft_rbtree_elem *nft_rbtree_prev_active(struct nft_rbtree_elem *rb
 	return rb_entry(node, struct nft_rbtree_elem, node);
 }
 
+static struct nft_rbtree_elem *
+__nft_rbtree_next_active(struct rb_node *node, u8 genmask)
+{
+	struct nft_rbtree_elem *next_rbe;
+
+	while (node) {
+		next_rbe = rb_entry(node, struct nft_rbtree_elem, node);
+		if (!nft_set_elem_active(&next_rbe->ext, genmask)) {
+			node = rb_next(node);
+			continue;
+		}
+
+		return next_rbe;
+	}
+
+	return NULL;
+}
+
+static struct nft_rbtree_elem *
+nft_rbtree_next_active(struct nft_rbtree_elem *rbe, u8 genmask)
+{
+	return __nft_rbtree_next_active(rb_next(&rbe->node), genmask);
+}
+
+static void nft_rbtree_maybe_reset_start_cookie(struct nft_rbtree *priv,
+						u64 tstamp)
+{
+	if (priv->last_tstamp != tstamp) {
+		priv->start_rbe_cookie = 0;
+		priv->last_tstamp = tstamp;
+	}
+}
+
+static void nft_rbtree_set_start_cookie(struct nft_rbtree *priv,
+					const struct nft_rbtree_elem *rbe)
+{
+	priv->start_rbe_cookie = (unsigned long)rbe;
+}
+
+static bool nft_rbtree_cmp_start_cookie(struct nft_rbtree *priv,
+					const struct nft_rbtree_elem *rbe)
+{
+	return priv->start_rbe_cookie == (unsigned long)rbe;
+}
+
+static bool nft_rbtree_insert_same_interval(const struct net *net,
+					    struct nft_rbtree *priv,
+					    struct nft_rbtree_elem *rbe)
+{
+	u8 genmask = nft_genmask_next(net);
+	struct nft_rbtree_elem *next_rbe;
+
+	if (!priv->start_rbe_cookie)
+		return true;
+
+	next_rbe = nft_rbtree_next_active(rbe, genmask);
+	if (next_rbe) {
+		/* Closest start element differs from last element added. */
+		if (nft_rbtree_interval_start(next_rbe) &&
+		    nft_rbtree_cmp_start_cookie(priv, next_rbe)) {
+			priv->start_rbe_cookie = 0;
+			return true;
+		}
+	}
+
+	priv->start_rbe_cookie = 0;
+
+	return false;
+}
+
 static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			       struct nft_rbtree_elem *new,
-			       struct nft_elem_priv **elem_priv)
+			       struct nft_elem_priv **elem_priv, u64 tstamp)
 {
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL, *rbe_prev;
 	struct rb_node *node, *next, *parent, **p, *first = NULL;
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
-	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	/* Descend the tree to search for an existing element greater than the
@@ -378,12 +449,18 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		}
 	}
 
+	if (nft_rbtree_interval_null(set, new))
+		priv->start_rbe_cookie = 0;
+	else if (nft_rbtree_interval_start(new) && priv->start_rbe_cookie)
+		priv->start_rbe_cookie = 0;
+
 	/* - new start element matching existing start element: full overlap
 	 *   reported as -EEXIST, cleared by caller if NLM_F_EXCL is not given.
 	 */
 	if (rbe_ge && !nft_rbtree_cmp(set, new, rbe_ge) &&
 	    nft_rbtree_interval_start(rbe_ge) == nft_rbtree_interval_start(new)) {
 		*elem_priv = &rbe_ge->priv;
+		nft_rbtree_set_start_cookie(priv, rbe_ge);
 		return -EEXIST;
 	}
 
@@ -399,6 +476,11 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			return -ECANCELED;
 
 		*elem_priv = &rbe_le->priv;
+
+		/* - start and end element belong to the same interval. */
+		if (!nft_rbtree_insert_same_interval(net, priv, rbe_le))
+			return -ENOTEMPTY;
+
 		return -EEXIST;
 	}
 
@@ -543,8 +625,11 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 {
 	struct nft_rbtree_elem *rbe = nft_elem_priv_cast(elem->priv);
 	struct nft_rbtree *priv = nft_set_priv(set);
+	u64 tstamp = nft_net_tstamp(net);
 	int err;
 
+	nft_rbtree_maybe_reset_start_cookie(priv, tstamp);
+
 	if (nft_array_may_resize(set) < 0)
 		return -ENOMEM;
 
@@ -555,7 +640,7 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		cond_resched();
 
 		write_lock_bh(&priv->lock);
-		err = __nft_rbtree_insert(net, set, rbe, elem_priv);
+		err = __nft_rbtree_insert(net, set, rbe, elem_priv, tstamp);
 		write_unlock_bh(&priv->lock);
 	} while (err == -EAGAIN);
 
@@ -588,6 +673,48 @@ static void nft_rbtree_activate(const struct net *net,
 	nft_clear(net, &rbe->ext);
 }
 
+static struct nft_rbtree_elem *
+nft_rbtree_next_inactive(struct nft_rbtree_elem *rbe, u8 genmask)
+{
+	struct nft_rbtree_elem *next_rbe;
+	struct rb_node *node;
+
+	node = rb_next(&rbe->node);
+	if (node) {
+		next_rbe = rb_entry(node, struct nft_rbtree_elem, node);
+		if (nft_rbtree_interval_start(next_rbe) &&
+		    !nft_set_elem_active(&next_rbe->ext, genmask))
+			return next_rbe;
+	}
+
+	return NULL;
+}
+
+static bool nft_rbtree_deactivate_same_interval(const struct net *net,
+						struct nft_rbtree *priv,
+						struct nft_rbtree_elem *rbe)
+{
+	u8 genmask = nft_genmask_next(net);
+	struct nft_rbtree_elem *next_rbe;
+
+	if (!priv->start_rbe_cookie)
+		return true;
+
+	next_rbe = nft_rbtree_next_inactive(rbe, genmask);
+	if (next_rbe) {
+		/* Closest start element differs from last element added. */
+		if (nft_rbtree_interval_start(next_rbe) &&
+		    nft_rbtree_cmp_start_cookie(priv, next_rbe)) {
+			priv->start_rbe_cookie = 0;
+			return true;
+		}
+	}
+
+	priv->start_rbe_cookie = 0;
+
+	return false;
+}
+
 static void nft_rbtree_flush(const struct net *net,
 			     const struct nft_set *set,
 			     struct nft_elem_priv *elem_priv)
@@ -602,12 +729,18 @@ nft_rbtree_deactivate(const struct net *net, const struct nft_set *set,
 		      const struct nft_set_elem *elem)
 {
 	struct nft_rbtree_elem *rbe, *this = nft_elem_priv_cast(elem->priv);
-	const struct nft_rbtree *priv = nft_set_priv(set);
+	struct nft_rbtree *priv = nft_set_priv(set);
 	const struct rb_node *parent = priv->root.rb_node;
 	u8 genmask = nft_genmask_next(net);
 	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
+	nft_rbtree_maybe_reset_start_cookie(priv, tstamp);
+
+	if (nft_rbtree_interval_start(this) ||
+	    nft_rbtree_interval_null(set, this))
+		priv->start_rbe_cookie = 0;
+
 	if (nft_array_may_resize(set) < 0)
 		return NULL;
 
@@ -635,6 +768,12 @@ nft_rbtree_deactivate(const struct net *net, const struct nft_set *set,
 				parent = parent->rb_left;
 				continue;
 			}
+
+			if (nft_rbtree_interval_start(rbe))
+				nft_rbtree_set_start_cookie(priv, rbe);
+			else if (!nft_rbtree_deactivate_same_interval(net, priv, rbe))
+				return NULL;
+
 			nft_rbtree_flush(net, set, &rbe->priv);
 			return &rbe->priv;
 		}
-- 
2.47.3


