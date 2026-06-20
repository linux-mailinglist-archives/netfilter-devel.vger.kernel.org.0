Return-Path: <netfilter-devel+bounces-13377-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6XWyNwoVN2pQJAcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13377-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 00:32:42 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B46A9D70
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jun 2026 00:32:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=jVDePQRg;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13377-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13377-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0425C3004686
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jun 2026 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104FF352027;
	Sat, 20 Jun 2026 22:32:35 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AD33EB1A;
	Sat, 20 Jun 2026 22:32:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781994755; cv=none; b=hNvp8w0MOoBuGI1qdEo3bb3WiDvwKQWre79DjElGEo0db6gjL7io1aFiggd/azgO+ZmZDPHcaRYksCy5BvSv0PRdYqoDDpgvQ8N0KUzrbql6Rs1vl7jGP8o/+rxgXO/DXVSXyJXEZxzqFVLvWqtKtutHgAY8UuFKU/MSZiA9AmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781994755; c=relaxed/simple;
	bh=0D/CxwGkasV/g6Fn4md5dHwk/sYDMeNHLsi7l27y9lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUp93C50Np41Lmesw3O4qqqtjiXQIAYHWXh4yFyth1bL5rjgSHV9w9iib911+e8EEeZNWxrJM2tc/WL17Rtq3kM2r2Qj1pHJQyJaZX/kHSRtE7LBl6bP9tUvsUSewKH0gt0RSoW9Ypb69cOIn4krHx0EC2WwkJpJlvAXPN0BoV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=jVDePQRg; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id DBB716019C;
	Sun, 21 Jun 2026 00:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1781994752;
	bh=/UWY5ZMZTpnmWtOS+qFPwx0OCK+JMtYku+LFJthRfwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVDePQRg5Aq7bO3IHTjn0IQmUtXZt1PVwW6EPzi87bwGMU4h031XD1NleyQpJvh9F
	 DAMl0j9jh0zJ12xXKchk26oSXJj5MxCwRS5E7NdqVs8ceKYrBdx2bZm3GhKNx6zKQY
	 7fo+lmaibQ7J1lObgV0WMXzW69QC8SQA0tLeAdrg+k/02R3kXZuocm/pTg3YQtwZAm
	 d5XmBfoW2XQnWfQs2tL+5eW3SFXl3Y8O4OmWXXBKu2t5769qoJ8hvGl4N9/hg/gkfN
	 SQ4IoiMwbpOS1b+xSn7sZYTvGaH3t7rG+Yh+Eiq1/aGANpRO+52vr/TpyjsdVk070T
	 /mQvrP026dpAA==
Date: Sun, 21 Jun 2026 00:32:29 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Alejandro =?utf-8?Q?Oliv=C3=A1n?= Alvarez <alejandro.olivan.alvarez@gmail.com>,
	1130336@bugs.debian.org, Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Bug#1130336: [regression] Network failure beyond first
 connection after 69894e5b4c5e ("netfilter: nft_connlimit: update the count
 if add was skipped")
Message-ID: <ajcU_VrAnnJDyL6l@chamomile>
References: <b3cbfd15-acd1-4500-ba30-eac6f48523fb@suse.de>
 <abW2MAAqLnKZm3KF@strlen.de>
 <177322336258.4376.10097494324750307114.reportbug@Desk1.simalex.iccbroadcast.com>
 <4da571ab-fa1d-4ee6-b71c-24f4a28243ed@suse.de>
 <abqfSB0TUik1kRU4@eldamar.lan>
 <e24a281622cedf9e8f4dc93c961813aeb7b6ce4c.camel@gmail.com>
 <8788e351-553f-48da-a6e6-ce082adacb8d@suse.de>
 <0b8607c8-2d29-4fca-961a-b7a677e968a1@leemhuis.info>
 <f67a985f-c6a0-4796-b255-59d99e317b6f@suse.de>
 <ajb7ugG5mYxYIPva@eldamar.lan>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajb7ugG5mYxYIPva@eldamar.lan>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:carnil@debian.org,m:fmancera@suse.de,m:regressions@leemhuis.info,m:alejandro.olivan.alvarez@gmail.com,m:1130336@bugs.debian.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,m:alejandroolivanalvarez@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13377-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.de,leemhuis.info,gmail.com,bugs.debian.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,netfilter.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:from_mime,chamomile:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE4B46A9D70

On Sat, Jun 20, 2026 at 10:44:42PM +0200, Salvatore Bonaccorso wrote:
> Hi Fernando,
> 
> On Wed, Apr 22, 2026 at 12:32:34PM +0200, Fernando Fernandez Mancera wrote:
> > On 4/22/26 11:18 AM, Thorsten Leemhuis wrote:
> > > Lo! Top-posting on purpose to make this easy to process.
> > > 
> > > What happened to this regression? It looks a bit like things stalled and
> > > fell through the cracks. Or Fernando, did you post a patch like you
> > > mentioned? I looked for one referring the commit or the reporter, but
> > > could not find anything -- but maybe I missed it.
> > > 
> > 
> > Yes, it stalled and fell through the cracks. Let me prepare a fix as I
> > mentioned.
> 
> Did that happened? On a quick chek at least 7.0.13 upstream seem still
> to exhibit the problem (or would it be fair to let this usecase rest?)

I still have to take a fix Fernando posted.

