Return-Path: <netfilter-devel+bounces-10668-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBOiJgN7hGlU3AMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10668-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 12:12:03 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E22F1B71
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Feb 2026 12:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C82BA302E421
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Feb 2026 11:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17303ACA53;
	Thu,  5 Feb 2026 11:09:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D853A1D01;
	Thu,  5 Feb 2026 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289786; cv=none; b=WOTslK9Fe8XEjtVAjRhQX0XXx2WoGaEPYe66sgxdD6P28WWLjHJdOEBvmxsUkeVmYmMKJHRMUZuy60WEMsN7HHV+DsPtIEztUOVqpluCcpvqIHxY8VliBiCrr1WwyNVgqjopIrX85c1VfcPTJkHNu+sbIRP+whqqUaQ+CbYIm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289786; c=relaxed/simple;
	bh=kYV5va+0ZjJf2HXoGsWzin75sojef68gB/lyG9O5bIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TiYas/FJ9PHAE4IWM9UXdZMW+PmkYNcHsQNKCpO8cx7RoUgjo/CmuFoTfLRVDEk5HrX1GjW8yJi5SF/q6lDh4dCyMGi0+/RuDjG5mx7+fUWsGPa/LZ5TdBUfpawbbDQfXdpTkpuuCKL+08NXBLkEYjEEEAR2QyuKkIYBg4Uxtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3BBAC60610; Thu, 05 Feb 2026 12:09:45 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 07/11] netfilter: nft_set_rbtree: fix bogus EEXIST with NLM_F_CREATE with null interval
Date: Thu,  5 Feb 2026 12:09:01 +0100
Message-ID: <20260205110905.26629-8-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205110905.26629-1-fw@strlen.de>
References: <20260205110905.26629-1-fw@strlen.de>
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
	TAGGED_FROM(0.00)[bounces-10668-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email,netfilter.org:email]
X-Rspamd-Queue-Id: 25E22F1B71
X-Rspamd-Action: no action

From: Pablo Neira Ayuso <pablo@netfilter.org>

Userspace adds a non-matching null element to the kernel for historical
reasons. This null element is added when the set is populated with
elements. Inclusion of this element is conditional, therefore,
userspace needs to dump the set content to check for its presence.

If the NLM_F_CREATE flag is turned on, this becomes an issue because
kernel bogusly reports EEXIST.

Add special case to ignore NLM_F_CREATE in this case, therefore,
re-adding the nul-element never fails.

Fixes: c016c7e45ddf ("netfilter: nf_tables: honor NLM_F_EXCL flag in set element insertion")'
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c  |  5 +++++
 net/netfilter/nft_set_rbtree.c | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index be4924aeaf0e..8ced4964eade 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7636,6 +7636,11 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			 * and an existing one.
 			 */
 			err = -EEXIST;
+		} else if (err == -ECANCELED) {
+			/* ECANCELED reports an existing nul-element in
+			 * interval sets.
+			 */
+			err = 0;
 		}
 		goto err_element_clash;
 	}
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 0efaa8c3f31b..2c240b0ade87 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -57,6 +57,13 @@ static bool nft_rbtree_interval_start(const struct nft_rbtree_elem *rbe)
 	return !nft_rbtree_interval_end(rbe);
 }
 
+static bool nft_rbtree_interval_null(const struct nft_set *set,
+				     const struct nft_rbtree_elem *rbe)
+{
+	return (!memchr_inv(nft_set_ext_key(&rbe->ext), 0, set->klen) &&
+		nft_rbtree_interval_end(rbe));
+}
+
 static int nft_rbtree_cmp(const struct nft_set *set,
 			  const struct nft_rbtree_elem *e1,
 			  const struct nft_rbtree_elem *e2)
@@ -373,6 +380,12 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	 */
 	if (rbe_le && !nft_rbtree_cmp(set, new, rbe_le) &&
 	    nft_rbtree_interval_end(rbe_le) == nft_rbtree_interval_end(new)) {
+		/* - ignore null interval, otherwise NLM_F_CREATE bogusly
+		 *   reports EEXIST.
+		 */
+		if (nft_rbtree_interval_null(set, new))
+			return -ECANCELED;
+
 		*elem_priv = &rbe_le->priv;
 		return -EEXIST;
 	}
-- 
2.52.0


