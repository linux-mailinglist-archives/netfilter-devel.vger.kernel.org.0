Return-Path: <netfilter-devel+bounces-8757-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB4B52096
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Sep 2025 21:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC50466D5F
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Sep 2025 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349A22D3ECB;
	Wed, 10 Sep 2025 19:03:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3902D3A89;
	Wed, 10 Sep 2025 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531009; cv=none; b=Amrv9/kVGc5JFGH3j0iG23mxGvkST/gmemQtzz/1s9dERM+DdbCAJV1EQ14DnXGQMlkASR5otYG4Pkz46dB1yt1hr7d8Q9UIUH3thFdFqn0gCB375XZES6L99TCRjl8TwoIS6YqnpFBMxjBWdTWsmtXd2p83uD8RTyVp5O/SF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531009; c=relaxed/simple;
	bh=F4mFLyBpGvFB/7aFjBdKeJ4pOQViBIyXuoa4Z/Nvqwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1QeyEz+OWwCsQRF6QQRGRTTDfiPVMMCEIbtv4RJODnjsKHwHF3JxZDdbAhgz854Ka/B5255T50MXG9D0CtijzUYEmozGHNyDQhjT/8giUYz8UBNLdNseRakTXl8b563ynVpBn/q/ArhbEINSEonhgOFGMBdJa3SCcFVPvyIRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C442E6061A; Wed, 10 Sep 2025 21:03:25 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 3/7] netfilter: nft_set_rbtree: continue traversal if element is inactive
Date: Wed, 10 Sep 2025 21:03:04 +0200
Message-ID: <20250910190308.13356-4-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250910190308.13356-1-fw@strlen.de>
References: <20250910190308.13356-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the rbtree lookup function finds a match in the rbtree, it sets the
range start interval to a potentially inactive element.

Then, after tree lookup, if the matching element is inactive, it returns
NULL and suppresses a matching result.

This is wrong and leads to false negative matches when a transaction has
already entered the commit phase.

cpu0					cpu1
  has added new elements to clone
  has marked elements as being
  inactive in new generation
					perform lookup in the set
  enters commit phase:
I) increments the genbit
					A) observes new genbit
					B) finds matching range
					C) returns no match: found
					range invalid in new generation
II) removes old elements from the tree
					C New nft_lookup happening now
				       	  will find matching element,
					  because it is no longer
					  obscured by old, inactive one.

Consider a packet matching range r1-r2:

cpu0 processes following transaction:
1. remove r1-r2
2. add r1-r3

P is contained in both ranges. Therefore, cpu1 should always find a match
for P.  Due to above race, this is not the case:

cpu1 does find r1-r2, but then ignores it due to the genbit indicating
the range has been removed.  It does NOT test for further matches.

The situation persists for all lookups until after cpu0 hits II) after
which r1-r3 range start node is tested for the first time.

Move the "interval start is valid" check ahead so that tree traversal
continues if the starting interval is not valid in this generation.

Thanks to Stefan Hanreich for providing an initial reproducer for this
bug.

Reported-by: Stefan Hanreich <s.hanreich@proxmox.com>
Fixes: c1eda3c6394f ("netfilter: nft_rbtree: ignore inactive matching element with no descendants")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_rbtree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 938a257c069e..b1f04168ec93 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -77,7 +77,9 @@ __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
 			    nft_rbtree_interval_end(rbe) &&
 			    nft_rbtree_interval_start(interval))
 				continue;
-			interval = rbe;
+			if (nft_set_elem_active(&rbe->ext, genmask) &&
+			    !nft_rbtree_elem_expired(rbe))
+				interval = rbe;
 		} else if (d > 0)
 			parent = rcu_dereference_raw(parent->rb_right);
 		else {
@@ -102,8 +104,6 @@ __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
 	}
 
 	if (set->flags & NFT_SET_INTERVAL && interval != NULL &&
-	    nft_set_elem_active(&interval->ext, genmask) &&
-	    !nft_rbtree_elem_expired(interval) &&
 	    nft_rbtree_interval_start(interval))
 		return &interval->ext;
 
-- 
2.49.1


