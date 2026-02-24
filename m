Return-Path: <netfilter-devel+bounces-10857-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHehOMAPnmlBTQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10857-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 21:53:20 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8912118C82E
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 21:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A8B930A52B9
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9192B33B6F9;
	Tue, 24 Feb 2026 20:51:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7933B6ED;
	Tue, 24 Feb 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771966285; cv=none; b=FQA+jiWs8g724eDAdq3/em4Jl6xclciC67Ms9wIDKSaIkRjTqf4wP+46ofARTa6+4qTIOO5ZDIzoywAS5CIpHKQBT9Psgacvah0Qd9Phxzr6JC02tpGI2PQIj3EhJFgV0CXJMr9wb1ig/q2TKhmHv1ItY1XcuH04suxjDXMIRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771966285; c=relaxed/simple;
	bh=cAreoWgHTw4tLyYkvGxHkPhS7ZsmGWj5PB0JKWDZkaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poxe2V7pN9j+ODYtLO2OZLXQKB9+phTpHe7jK0NigiMUWfcRpP4lS9Pd7/PYxfNpvQK0E6qQX0X1xhslTQaY610dIRSTlH2GBWmOzAVwM4Lu+Oen9nVK0hxMBZ7WEE/fepxOCwK6RhHQhQH2rYUDUfU+FaLPt/wuoRiAJIk63V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2C6C260516; Tue, 24 Feb 2026 21:51:23 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 7/9] netfilter: nft_set_rbtree: don't disable bh when acquiring tree lock
Date: Tue, 24 Feb 2026 21:50:46 +0100
Message-ID: <20260224205048.4718-8-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224205048.4718-1-fw@strlen.de>
References: <20260224205048.4718-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10857-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8912118C82E
X-Rspamd-Action: no action

As of commit 7e43e0a1141d
("netfilter: nft_set_rbtree: translate rbtree to array for binary search")
the lock is only taken from control plane, no need to disable BH anymore.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_set_rbtree.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 644d4b916705..ef567a948703 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -684,9 +684,9 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 		cond_resched();
 
-		write_lock_bh(&priv->lock);
+		write_lock(&priv->lock);
 		err = __nft_rbtree_insert(net, set, rbe, elem_priv, tstamp, last);
-		write_unlock_bh(&priv->lock);
+		write_unlock(&priv->lock);
 
 		if (nft_rbtree_interval_end(rbe))
 			priv->start_rbe_cookie = 0;
@@ -696,13 +696,6 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	return err;
 }
 
-static void nft_rbtree_erase(struct nft_rbtree *priv, struct nft_rbtree_elem *rbe)
-{
-	write_lock_bh(&priv->lock);
-	rb_erase(&rbe->node, &priv->root);
-	write_unlock_bh(&priv->lock);
-}
-
 static void nft_rbtree_remove(const struct net *net,
 			      const struct nft_set *set,
 			      struct nft_elem_priv *elem_priv)
@@ -710,7 +703,9 @@ static void nft_rbtree_remove(const struct net *net,
 	struct nft_rbtree_elem *rbe = nft_elem_priv_cast(elem_priv);
 	struct nft_rbtree *priv = nft_set_priv(set);
 
-	nft_rbtree_erase(priv, rbe);
+	write_lock(&priv->lock);
+	rb_erase(&rbe->node, &priv->root);
+	write_unlock(&priv->lock);
 }
 
 static void nft_rbtree_activate(const struct net *net,
@@ -871,9 +866,9 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 		nft_rbtree_do_walk(ctx, set, iter);
 		break;
 	case NFT_ITER_READ:
-		read_lock_bh(&priv->lock);
+		read_lock(&priv->lock);
 		nft_rbtree_do_walk(ctx, set, iter);
-		read_unlock_bh(&priv->lock);
+		read_unlock(&priv->lock);
 		break;
 	default:
 		iter->err = -EINVAL;
@@ -909,14 +904,14 @@ static void nft_rbtree_gc_scan(struct nft_set *set)
 		/* end element needs to be removed first, it has
 		 * no timeout extension.
 		 */
-		write_lock_bh(&priv->lock);
+		write_lock(&priv->lock);
 		if (rbe_end) {
 			nft_rbtree_gc_elem_move(net, set, priv, rbe_end);
 			rbe_end = NULL;
 		}
 
 		nft_rbtree_gc_elem_move(net, set, priv, rbe);
-		write_unlock_bh(&priv->lock);
+		write_unlock(&priv->lock);
 	}
 
 	priv->last_gc = jiffies;
-- 
2.52.0


