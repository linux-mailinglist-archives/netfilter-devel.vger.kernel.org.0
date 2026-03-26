Return-Path: <netfilter-devel+bounces-11452-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM+pOZEyxWk98AQAu9opvQ
	(envelope-from <netfilter-devel+bounces-11452-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 14:20:17 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F2335E09
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 14:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5269130A84B6
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2026 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27342C326D;
	Thu, 26 Mar 2026 13:17:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1608231A23
	for <netfilter-devel@vger.kernel.org>; Thu, 26 Mar 2026 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531042; cv=none; b=Wr41KhXA8mEjPALQKMD2y56m8CCFWmMGuw1OGXQ+AVeUxOOOx5717xQG50MlhvvQILmgIvtvaOiJm21JJyDz9HodvnASTh5NF5hjC/Gh0QFs2hXqTCVw+9qAisAxrP8eCmhF24BR2R6ItFPa8r5QHgAMfw4kfExfvQD788zpPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531042; c=relaxed/simple;
	bh=j8mIjqCT4OCigp1jdW02EjLrFeFWtRiehjZxHkqg/W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz2WhHwtyy1xt80dISojqbsW0RnYnZjrGE51vy7ULwNviRGf6INUGBcQD9Vvdyzmcvxv5rFjwYiRLsZu6kqwq+3BwWX+Dtmt1J7IGG6y3anmpx8pGLZ7JOxWo1+ZEs6dcF50iklOUXbH4ZiP1LsnSpqF76BEwC4+ANxRUj/A2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8929A608BD; Thu, 26 Mar 2026 14:17:12 +0100 (CET)
Date: Thu, 26 Mar 2026 14:16:51 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net,v3 00/12] Netfilter for net
Message-ID: <acUxw826gEzIv8Zp@strlen.de>
References: <20260326125153.685915-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326125153.685915-1-pablo@netfilter.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11452-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,netfilter.org:email]
X-Rspamd-Queue-Id: 204F2335E09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> This is v3, I kept back an ipset fix and another to tigthen the xtables
> interface to reject invalid combinations with the NFPROTO_ARP family.
> They need a bit more discussion. I fixed the issues reported by AI on
> patch 9 (add #ifdef to access ct zone, update nf_conntrack_broadcast
> and patch 10 (use better Fixes: tag). Thanks!

Dropping netdev@.

I think the NFPROTO_ARP fix is legit.

If anything, we should also consider this (not even compile tested):

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 53a614a0e3cd..39446edb0d70 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -778,6 +778,20 @@ static const struct nfnetlink_subsystem nfnl_compat_subsys = {
 
 static struct nft_expr_type nft_match_type;
 
+static bool is_valid_compat_family(u32 family)
+{
+	switch (family) {
+	case NFPROTO_IPV4:
+	case NFPROTO_ARP:
+	case NFPROTO_BRIDGE:
+	case NFPROTO_IPV6:
+		return true;
+	}
+
+	/* others are nftables only */
+	return false;
+}
+
 static const struct nft_expr_ops *
 nft_match_select_ops(const struct nft_ctx *ctx,
 		     const struct nlattr * const tb[])
@@ -798,6 +812,9 @@ nft_match_select_ops(const struct nft_ctx *ctx,
 	rev = ntohl(nla_get_be32(tb[NFTA_MATCH_REV]));
 	family = ctx->family;
 
+	if (!is_valid_compat_family(family))
+		return ERR_PTR(-EAFNOSUPPORT);
+
 	match = xt_request_find_match(family, mt_name, rev);
 	if (IS_ERR(match))
 		return ERR_PTR(-ENOENT);
@@ -877,6 +894,9 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	rev = ntohl(nla_get_be32(tb[NFTA_TARGET_REV]));
 	family = ctx->family;
 
+	if (!is_valid_compat_family(family))
+		return ERR_PTR(-EAFNOSUPPORT);
+
 	if (strcmp(tg_name, XT_ERROR_TARGET) == 0 ||
 	    strcmp(tg_name, XT_STANDARD_TARGET) == 0 ||
 	    strcmp(tg_name, "standard") == 0)

