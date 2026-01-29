Return-Path: <netfilter-devel+bounces-10509-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGmQKcdQe2meDwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10509-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 13:21:27 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2138B0039
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 13:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2CBA3002D13
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7E387599;
	Thu, 29 Jan 2026 12:21:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3529ACD1;
	Thu, 29 Jan 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689281; cv=none; b=tmINFhie6hZ/ZcB1SQAsIaHK84DWU8grZBh1lAt9ob6JWQIlRasjqPOvcG9SyiQjIJPicETs3fAHmNDl83kL+Iohn5Fq4nTDBSemsAMi2yXD6Vl46oeanX0Kk6VOfdXnPOHL062BdzttVmIUfzeWiNH/K0gZzxFyVNcmLp1g8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689281; c=relaxed/simple;
	bh=N88fNO7e6FBpx/dQ/XRljTfmNBuMN/7svA6A6osVWaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxW0cyV2uNhcZjel9Uu5tY094OdllbC6oJhBOLnSyDIBb69Arx1owMRSTVeITN/7yQOlEAKWz0qNx6xkhorqUSWvX3W3Tc98g79dBjv7Z/dY5CUXqwp3a7tb+nhdkmZyEXEQ+4Mhe452Yto1FkmFk2ibjDTlfvzzRi1xbzRgAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 68D3360516; Thu, 29 Jan 2026 13:21:15 +0100 (CET)
Date: Thu, 29 Jan 2026 13:21:15 +0100
From: Florian Westphal <fw@strlen.de>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH nf-next] netfilter: flowtable: dedicated slab for flow
 entry
Message-ID: <aXtQu1eW_GR4lTMH@strlen.de>
References: <20260129101213.74557-1-dqfext@gmail.com>
 <aXs14ZJGN3lDnMDc@strlen.de>
 <CALW65ja5wOf-5PAkQY0yt8FO1_gTvfL392Q+S3TKtJoQ1kXFug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65ja5wOf-5PAkQY0yt8FO1_gTvfL392Q+S3TKtJoQ1kXFug@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10509-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F2138B0039
X-Rspamd-Action: no action

Qingfang Deng <dqfext@gmail.com> wrote:
> On Thu, Jan 29, 2026 at 6:26 PM Florian Westphal <fw@strlen.de> wrote:
> > Ok, but please use KMEM_CACHE(), we've had a bunch of patches
> > that removed kmem_cache_create() in several places, I would like
> > to avoid a followup patch.
> 
> But I'm creating a slab with a different name (`nf_flow_offload`) from
> the struct name (`flow_offload`). Should I keep the `nf_` prefix?

Then add a comment that its intentional due to the name, else
we'll get a followup 'cleanup patch' to switch to KMEM_CACHE().

