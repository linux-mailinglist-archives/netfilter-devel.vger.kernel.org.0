Return-Path: <netfilter-devel+bounces-11599-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AdULu2mz2mZyQYAu9opvQ
	(envelope-from <netfilter-devel+bounces-11599-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Apr 2026 13:39:25 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 280E3393C4C
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Apr 2026 13:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49723300FB60
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Apr 2026 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C98A3A9001;
	Fri,  3 Apr 2026 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="pGM/W+k4"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80E31D375;
	Fri,  3 Apr 2026 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216305; cv=none; b=sZo+wmBYoFab3gkfKfJyfYsjq8dvf9w7u8Gk9kGqOt5ifa3X3sDKbSuv4Ey/sUBoNo6B5Hs4AjEw/m9NfTjMexCj8byL7c1NrfVflqcdiDSvyX3QURk8le/fDd8VtuF8ikHCcqNdfSrB5sm/skWQQXdtQomZPB3vC0YfHikT218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216305; c=relaxed/simple;
	bh=Vpm56VZ1GZ1Y7W9CVZyWBqubGh02QR8XtmUh7YGRPUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktTYvJTfgI1OKwjSL9V9pEyKEhRtD67eOqc0WHM8lWX1oc9bh+DKUoaCDwmD43qbpM5h9kRTkJ17jC/WyEbgkgqEqk05kRFFOLKCayN7EDTdR9tUr1mFcJhJVASDtxbj/61SMFUaC8PFCt1dPZDTgSNqr2GuZV8I4VlJ5rI5Izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=pGM/W+k4; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 01C0560251;
	Fri,  3 Apr 2026 13:38:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1775216302;
	bh=b7Q9vhu468ezbsFTKuz/mFheQzvf86bCacmkT7oDh4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGM/W+k4sf9TU1cj1tAL9bQwvZSBUfsYhxKpA/i4SVcREdOSqPv/c53jV5jM4E1h9
	 NdDbeKwtndII6cv4Ju30pW12SNnWMI8k3BphFUXUL0as0J4hZFvyAHlTDCSCmuob+k
	 PlXC8pJX5vPMhevmqM29wUMihN8OX73PzeyL9k7W4gvGWHbU3sqg4XkmarUPdVChCi
	 ORhui7I4ZtVIkf7hful83LIJszwv6aP8VJdN5g65V++zEhRWqGhxgifPnLUzyn4GO/
	 jtEccGGASv9mBOujSrCt+WXOzMdLh9uXLpjIhs9mhAbefHJnLQKh7Dujoh5RdZzz1P
	 Ha/WDlBX98aGw==
Date: Fri, 3 Apr 2026 13:38:18 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, fw@strlen.de,
	phil@nwl.cc, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	yasuyuki.kozakai@toshiba.co.jp, kaber@trash.net,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com,
	bird@lzu.edu.cn, z1652074432@gmail.com
Subject: Re: [PATCH v3] netfilter: xt_multiport: validate range encoding in
 checkentry
Message-ID: <ac-mqkVOMHu673UC@lemonverbena>
References: <cover.1774624314.git.n05ec@lzu.edu.cn>
 <d5c0d106e724c732436b985dd694272bcb813bb1.1775153311.git.n05ec@lzu.edu.cn>
 <ac-lHcg6NTg9sWGY@lemonverbena>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac-lHcg6NTg9sWGY@lemonverbena>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11599-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,toshiba.co.jp,trash.net,gmail.com,lzu.edu.cn];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Queue-Id: 280E3393C4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 01:31:41PM +0200, Pablo Neira Ayuso wrote:
> On Fri, Apr 03, 2026 at 02:21:17AM +0800, Ren Wei wrote:
> > ports_match_v1() treats any non-zero pflags entry as the start of a
> > port range and unconditionally consumes the next ports[] element as
> > the range end.
> > 
> > The checkentry path currently validates protocol, flags and count, but
> > it does not validate the range encoding itself. As a result, malformed
> > rules can mark the last slot as a range start or place two range starts
> > back to back, leaving ports_match_v1() to step past the last valid
> > ports[] element while interpreting the rule.
> > 
> > Reject malformed multiport v1 rules in checkentry by validating that
> > each range start has a following element and that the following element
> > is not itself marked as another range start.
> > 
> > Fixes: a89ecb6a2ef7 ("[NETFILTER]: x_tables: unify IPv4/IPv6 multiport match")
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> > Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> > Suggested-by: Xin Liu <bird@lzu.edu.cn>
> > Tested-by: Yuhang Zheng <z1652074432@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> > Changes in v2:
> > - drop the selftest patch
> > - send the fix publicly to netfilter-devel
> > 
> > Changes in v3:
> > - drop datatype cleanup from the fix
> > - keep the original check() interface unchanged
> > - validate malformed range encoding in checkentry
> > 
> >  net/netfilter/xt_multiport.c | 30 ++++++++++++++++++++++++++----
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/netfilter/xt_multiport.c b/net/netfilter/xt_multiport.c
> > index 44a00f5acde8..07a0f2a3fc75 100644
> > --- a/net/netfilter/xt_multiport.c
> > +++ b/net/netfilter/xt_multiport.c
> > @@ -105,6 +105,24 @@ multiport_mt(const struct sk_buff *skb, struct xt_action_param *par)
> >  	return ports_match_v1(multiinfo, ntohs(pptr[0]), ntohs(pptr[1]));
> >  }
> >  
> > +static inline bool
> > +multiport_valid_ranges(const struct xt_multiport_v1 *multiinfo)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < multiinfo->count; i++) {
> > +		if (!multiinfo->pflags[i])
> > +			continue;
> > +
> > +		if (i + 1 >= multiinfo->count || multiinfo->pflags[i + 1])
> > +			return false;
> > +
> > +		i++;
> > +	}
> > +
> > +	return true;
> > +}
> 
> I'd suggest:
> 
> static inline bool

Actually, inline is silly here, no inline here.

> multiport_valid_ranges(const struct xt_multiport_v1 *multiinfo)
> {
>         unsigned int i;
>  
>         for (i = 0; i < multiinfo->count; i++) {
>                 if (!multiinfo->pflags[i])
>                         continue;
> 
>                 if (++i >= multiinfo->count)
>                         return false;
>          
>                 if (multiinfo->pflags[i])
>                         return false;
>          
>                 if (multiinfo->ports[i - 1] > multiinfo->ports[i])
>                         return false;
>         }
>  
>         return true;
> }
> 
> Then, this validate non-sense ports array too.

You can also mention in the patch description that this leads to
off-by-one read after the array that is reported via UBSAN.

Thanks.

