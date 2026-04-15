Return-Path: <netfilter-devel+bounces-11907-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDkMErBf32k0SQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11907-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 11:51:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED1402E44
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 11:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F89330A2DA7
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F433A9E2;
	Wed, 15 Apr 2026 09:44:11 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DC3368B1;
	Wed, 15 Apr 2026 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246251; cv=none; b=IBZrX2kwbRbsimDzPIXEWOF89OLGmEKQvKNqmZ9tBHA7W+JBYQHIYo97khXANwvcpoFU0DE/y4PnEt3/OmWeUG8eD2FxQOtMmFc3enNmEe+41eukoP0R9OkL9dKF7kNvNfjETYhar2T7f0OalA2JKrjPea44/VVm4ExpAJzGH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246251; c=relaxed/simple;
	bh=iT0ho2XklXWmEyjVCwL/uZx0vgXGXFxFZ8anJWFAwNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnsFTVB1OL5j2fiCkXHE6qc3Vzn2X+SGUworUFhEr+uQ7wFuoSVAOSZgNPKvsNmlhuEyxNfiOv6F9Nvbi9o+BVwRSooN+/ehGVANIIQjsuKMJBGcZi1L7YFjaJ70oZ/+coKU8IFX43BwOVp+RcMa43A27P7FY5BVb6twhlbs+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CC2C660640; Wed, 15 Apr 2026 11:44:07 +0200 (CEST)
Date: Wed, 15 Apr 2026 11:44:07 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: "Kito Xu (veritas501)" <hxzene@gmail.com>, phil@nwl.cc,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jengelh@medozas.de,
	kaber@trash.net, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: xt_realm: fix null-ptr-deref in realm_mt()
Message-ID: <ad9d52dQWrS1H_ju@strlen.de>
References: <20260415034343.107920-1-hxzene@gmail.com>
 <ad9UF5Cr12YGJnbi@strlen.de>
 <ad9aDziQEBR0h3U8@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ad9aDziQEBR0h3U8@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11907-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,medozas.de,trash.net,vger.kernel.org,netfilter.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,netfilter.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBED1402E44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Wed, Apr 15, 2026 at 11:02:15AM +0200, Florian Westphal wrote:
> > Kito Xu (veritas501) <hxzene@gmail.com> wrote:
> > > realm_mt() unconditionally dereferences skb_dst(skb) without a NULL
> > > check. The xt_realm match registers with .family =3D NFPROTO_UNSPEC,
> > > making it available to all netfilter protocol families. Through the
> > > nftables compat layer (nft_compat), an unprivileged user inside a
> > > user/net namespace can load this match into a bridge-family chain.
> >=20
> > I do not think this bug is related to nft_compat.
> > You can also use ebtables setsockopt api to request xt_realm, no?
> >=20
> > > Fixes: ab4f21e6fb1c ("netfilter: xtables: use NFPROTO_UNSPEC in more =
extensions")
> >=20
> > Looks correct.  Alternatively we could revert the xt_realm.c change.
> > But I don't have a strong opinion here, patch looks correct.
>=20
> Maybe partial revert makes sense, since in ab4f21e6fb1c:
>=20
> - xt_MARK: OK
> - xt_NOTRACK: OK
> - xt_comment: OK

Agree.

> - xt_mac: There is a better way to do this in bridge.

Right.

> - xt_owner, no sockets in bridge.

Output/postrouting maybe?

> - xt_physdev, which makes no sense in bridge, this is for br_netfilter
>   only.

Agree.

> - xt_realm (as already mentioned).
> That is, a partial revert of this patch for:
>=20
> - xt_mac
> - xt_owner
> - xt_physdev
> - xt_realm

I'm ok with that too.

