Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91F93940F0
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 May 2021 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhE1KcO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 May 2021 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbhE1KcL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 May 2021 06:32:11 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3668C061760
        for <netfilter-devel@vger.kernel.org>; Fri, 28 May 2021 03:30:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lmZlC-00008B-1L; Fri, 28 May 2021 12:30:34 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 6/6] netfilter: nf_tables: remove xt_action_param from nft_pktinfo
Date:   Fri, 28 May 2021 12:30:08 +0200
Message-Id: <20210528103008.17425-7-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210528103008.17425-1-fw@strlen.de>
References: <20210528103008.17425-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Init it on demand in the nft_compat expression.  This reduces size
of nft_pktinfo from 48 to 24 bytes on x86_64.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_tables.h      | 25 ++++++++++++-----------
 include/net/netfilter/nf_tables_ipv4.h | 12 +++++------
 include/net/netfilter/nf_tables_ipv6.h | 12 +++++------
 net/netfilter/nft_compat.c             | 28 +++++++++++++++++---------
 4 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 958b8e68bb1a..6783164428f1 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -23,45 +23,46 @@ struct module;
 
 struct nft_pktinfo {
 	struct sk_buff			*skb;
+	const struct nf_hook_state	*state;
 	bool				tprot_set;
 	u8				tprot;
-	/* for x_tables compatibility */
-	struct xt_action_param		xt;
+	u16				fragoff;
+	unsigned int			thoff;
 };
 
 static inline struct sock *nft_sk(const struct nft_pktinfo *pkt)
 {
-	return pkt->xt.state->sk;
+	return pkt->state->sk;
 }
 
 static inline unsigned int nft_thoff(const struct nft_pktinfo *pkt)
 {
-	return pkt->xt.thoff;
+	return pkt->thoff;
 }
 
 static inline struct net *nft_net(const struct nft_pktinfo *pkt)
 {
-	return pkt->xt.state->net;
+	return pkt->state->net;
 }
 
 static inline unsigned int nft_hook(const struct nft_pktinfo *pkt)
 {
-	return pkt->xt.state->hook;
+	return pkt->state->hook;
 }
 
 static inline u8 nft_pf(const struct nft_pktinfo *pkt)
 {
-	return pkt->xt.state->pf;
+	return pkt->state->pf;
 }
 
 static inline const struct net_device *nft_in(const struct nft_pktinfo *pkt)
 {
-	return pkt->xt.state->in;
+	return pkt->state->in;
 }
 
 static inline const struct net_device *nft_out(const struct nft_pktinfo *pkt)
 {
-	return pkt->xt.state->out;
+	return pkt->state->out;
 }
 
 static inline void nft_set_pktinfo(struct nft_pktinfo *pkt,
@@ -69,15 +70,15 @@ static inline void nft_set_pktinfo(struct nft_pktinfo *pkt,
 				   const struct nf_hook_state *state)
 {
 	pkt->skb = skb;
-	pkt->xt.state = state;
+	pkt->state = state;
 }
 
 static inline void nft_set_pktinfo_unspec(struct nft_pktinfo *pkt)
 {
 	pkt->tprot_set = false;
 	pkt->tprot = 0;
-	pkt->xt.thoff = 0;
-	pkt->xt.fragoff = 0;
+	pkt->thoff = 0;
+	pkt->fragoff = 0;
 }
 
 /**
diff --git a/include/net/netfilter/nf_tables_ipv4.h b/include/net/netfilter/nf_tables_ipv4.h
index b185a9216bf1..eb4c094cd54d 100644
--- a/include/net/netfilter/nf_tables_ipv4.h
+++ b/include/net/netfilter/nf_tables_ipv4.h
@@ -12,8 +12,8 @@ static inline void nft_set_pktinfo_ipv4(struct nft_pktinfo *pkt)
 	ip = ip_hdr(pkt->skb);
 	pkt->tprot_set = true;
 	pkt->tprot = ip->protocol;
-	pkt->xt.thoff = ip_hdrlen(pkt->skb);
-	pkt->xt.fragoff = ntohs(ip->frag_off) & IP_OFFSET;
+	pkt->thoff = ip_hdrlen(pkt->skb);
+	pkt->fragoff = ntohs(ip->frag_off) & IP_OFFSET;
 }
 
 static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
@@ -38,8 +38,8 @@ static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
 
 	pkt->tprot_set = true;
 	pkt->tprot = iph->protocol;
-	pkt->xt.thoff = thoff;
-	pkt->xt.fragoff = ntohs(iph->frag_off) & IP_OFFSET;
+	pkt->thoff = thoff;
+	pkt->fragoff = ntohs(iph->frag_off) & IP_OFFSET;
 
 	return 0;
 }
@@ -73,8 +73,8 @@ static inline int nft_set_pktinfo_ipv4_ingress(struct nft_pktinfo *pkt)
 
 	pkt->tprot_set = true;
 	pkt->tprot = iph->protocol;
-	pkt->xt.thoff = thoff;
-	pkt->xt.fragoff = ntohs(iph->frag_off) & IP_OFFSET;
+	pkt->thoff = thoff;
+	pkt->fragoff = ntohs(iph->frag_off) & IP_OFFSET;
 
 	return 0;
 
diff --git a/include/net/netfilter/nf_tables_ipv6.h b/include/net/netfilter/nf_tables_ipv6.h
index bf132d488b17..7595e02b00ba 100644
--- a/include/net/netfilter/nf_tables_ipv6.h
+++ b/include/net/netfilter/nf_tables_ipv6.h
@@ -20,8 +20,8 @@ static inline void nft_set_pktinfo_ipv6(struct nft_pktinfo *pkt)
 
 	pkt->tprot_set = true;
 	pkt->tprot = protohdr;
-	pkt->xt.thoff = thoff;
-	pkt->xt.fragoff = frag_off;
+	pkt->thoff = thoff;
+	pkt->fragoff = frag_off;
 }
 
 static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
@@ -52,8 +52,8 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 
 	pkt->tprot_set = true;
 	pkt->tprot = protohdr;
-	pkt->xt.thoff = thoff;
-	pkt->xt.fragoff = frag_off;
+	pkt->thoff = thoff;
+	pkt->fragoff = frag_off;
 
 	return 0;
 #else
@@ -98,8 +98,8 @@ static inline int nft_set_pktinfo_ipv6_ingress(struct nft_pktinfo *pkt)
 
 	pkt->tprot_set = true;
 	pkt->tprot = protohdr;
-	pkt->xt.thoff = thoff;
-	pkt->xt.fragoff = frag_off;
+	pkt->thoff = thoff;
+	pkt->fragoff = frag_off;
 
 	return 0;
 
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 5415ab14400d..936e244f5aba 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -57,8 +57,13 @@ union nft_entry {
 };
 
 static inline void
-nft_compat_set_par(struct xt_action_param *par, void *xt, const void *xt_info)
+nft_compat_set_par(struct xt_action_param *par,
+		   const struct nft_pktinfo *pkt,
+		   const void *xt, const void *xt_info)
 {
+	par->state	= pkt->state;
+	par->thoff	= nft_thoff(pkt);
+	par->fragoff	= pkt->fragoff;
 	par->target	= xt;
 	par->targinfo	= xt_info;
 	par->hotdrop	= false;
@@ -71,13 +76,14 @@ static void nft_target_eval_xt(const struct nft_expr *expr,
 	void *info = nft_expr_priv(expr);
 	struct xt_target *target = expr->ops->data;
 	struct sk_buff *skb = pkt->skb;
+	struct xt_action_param xt;
 	int ret;
 
-	nft_compat_set_par((struct xt_action_param *)&pkt->xt, target, info);
+	nft_compat_set_par(&xt, pkt, target, info);
 
-	ret = target->target(skb, &pkt->xt);
+	ret = target->target(skb, &xt);
 
-	if (pkt->xt.hotdrop)
+	if (xt.hotdrop)
 		ret = NF_DROP;
 
 	switch (ret) {
@@ -97,13 +103,14 @@ static void nft_target_eval_bridge(const struct nft_expr *expr,
 	void *info = nft_expr_priv(expr);
 	struct xt_target *target = expr->ops->data;
 	struct sk_buff *skb = pkt->skb;
+	struct xt_action_param xt;
 	int ret;
 
-	nft_compat_set_par((struct xt_action_param *)&pkt->xt, target, info);
+	nft_compat_set_par(&xt, pkt, target, info);
 
-	ret = target->target(skb, &pkt->xt);
+	ret = target->target(skb, &xt);
 
-	if (pkt->xt.hotdrop)
+	if (&xt.hotdrop)
 		ret = NF_DROP;
 
 	switch (ret) {
@@ -350,13 +357,14 @@ static void __nft_match_eval(const struct nft_expr *expr,
 {
 	struct xt_match *match = expr->ops->data;
 	struct sk_buff *skb = pkt->skb;
+	struct xt_action_param xt;
 	bool ret;
 
-	nft_compat_set_par((struct xt_action_param *)&pkt->xt, match, info);
+	nft_compat_set_par(&xt, pkt, match, info);
 
-	ret = match->match(skb, (struct xt_action_param *)&pkt->xt);
+	ret = match->match(skb, &xt);
 
-	if (pkt->xt.hotdrop) {
+	if (xt.hotdrop) {
 		regs->verdict.code = NF_DROP;
 		return;
 	}
-- 
2.26.3

