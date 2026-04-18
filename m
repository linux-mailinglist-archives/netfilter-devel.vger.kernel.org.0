Return-Path: <netfilter-devel+bounces-12021-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNEyOlri42mbMAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12021-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Apr 2026 21:58:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C0422272
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Apr 2026 21:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F7703029772
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Apr 2026 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2EF331220;
	Sat, 18 Apr 2026 19:58:14 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B553B40DFBB;
	Sat, 18 Apr 2026 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776542294; cv=none; b=pJeJPaaNiolGz9DMC8Rrjt4m1qb2k/wXnMoWxoo2xXdebUqykjj26bxqf0dilJs3hFL/7yJ2v+DOc80ZcYym4qidjIRnaYj6ui9CVIYB+DxpfMdNDdGuxtfuPqCBo9mSBIp3Ztx3r+J9OPo0bGWbCGWJLRGROlmQj1VY7K5gXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776542294; c=relaxed/simple;
	bh=YmD4xH14x4Bvv6dMNNSg+rwjIoqkpvZpcCLOuZSzbuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiUWzcMYKeUQ7Zu12K3JAYycbLlwzZ+GZiDsnIFUTSSY6oEWv+Pb4ZvpkHZviOXcuBtXcyY3bqyg3n8RYC44eQZ0gVC4MDessZ8+QUmTPCnXGGGK6lnRoccnQAD/TY8SacpS0RDglkk/+Q75M6oQ4bHc6ABUlB2mVuOU56lKOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 73AD9606C8; Sat, 18 Apr 2026 21:58:04 +0200 (CEST)
Date: Sat, 18 Apr 2026 21:58:03 +0200
From: Florian Westphal <fw@strlen.de>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH nf] netfilter: xt_TCPMSS: check skb_dst before path-MTU
 clamping
Message-ID: <aePiSwmP6YEQ4mNE@strlen.de>
References: <20260418163057.2611503-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260418163057.2611503-2-bestswngs@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12021-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid]
X-Rspamd-Queue-Id: 981C0422272
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Weiming Shi <bestswngs@gmail.com> wrote:
> When TCPMSS with CLAMP_PMTU is used via nft_compat in a non-base
> chain, par->hook_mask is set to 0, bypassing the checkentry hook
> validation. The target can then run at PRE_ROUTING where skb_dst is
> NULL, causing a null-ptr-deref in tcpmss_mangle_packet():
>=20
>  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>  RIP: 0010:tcpmss_mangle_packet (include/net/dst.h:219 net/netfilter/xt_T=
CPMSS.c:105)
>   tcpmss_tg4 (net/netfilter/xt_TCPMSS.c:202)
>   nft_target_eval_xt (net/netfilter/nft_compat.c:87)
>   nft_do_chain (net/netfilter/nf_tables_core.c:287)
>   nf_hook_slow (net/netfilter/core.c:623)
>=20
> Check skb_dst() for NULL before calling dst_mtu().

FWIW I will apply this patch even though its wrong.

nft_compat.c is just too broken, I don't see how it can be
fixed in any reasonable amount of time.

validation is done too early, at expression instantiation
time.

This doesn't work because we have incomplete graph, it has
to be done at final table validation time.

But then all required compat info (xtables hints) is gone
and no longer available.

AFAICS the only way to resolve this is to cache the info in
the nft_expr priv area (WHERE IS ABSOLUTELY DOESN'T BELONG!)
because thats the only storage thewre is.

*puke*

