Return-Path: <netfilter-devel+bounces-5086-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2C19C7489
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Nov 2024 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AE6B2F80C
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Nov 2024 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920F45009;
	Wed, 13 Nov 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="hQuSo8hf"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D9344C7C
	for <netfilter-devel@vger.kernel.org>; Wed, 13 Nov 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507541; cv=none; b=RBlrKLRU0Jtr9IfzS6vVh9Iy83NyBDBVI16cHmGZABXLDg8Wsc9xY0YQSPqfIVrUZ/25qiaevkrfiatFCmp0ZYYevtE5nFFsXsolAxj8t587oJpNTGlGdBzHR0VTcccYzhz83h2K5OqXKFtMhd1BtjsXCj8P5NvD5QU+4EB+tVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507541; c=relaxed/simple;
	bh=2/msPS0+Tnkc06A2pDau3dk/7F0xyNyS8BHfJIvm2yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSKj248WEeh6ltHRPYNBEVLN279kibaT/0qlIS8rq+Cj1BR9I4IXN/TaIDVZ4jy9HOEjqgMJ4c5sckChjZDMpgYLO21/as/tfg3q1BR6Ouymj4aS/71DPjflsSlVheIj2EELr+RsW9iyHtPHVYmSs+TIRxQDtbmmYWBkiW0iFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=hQuSo8hf; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HXhn1ToVtED+wrzcRF7V/w8QuLpAS+kbkoa4ehQnSaw=; b=hQuSo8hfC6DBXrKPFLxaLVqKuv
	TLTRLEGwTZWrrHbUHHwsTekMDYeiWsRC6j3+oLNhGIDkPtbx6dh08RiDsMVBGwdjMLqdv6h6vn5Vw
	EWwq0u8WVQ74LVuAG3JRWhD5yaIV4GmPMZYAjTXJf2Fg2AtvIo8fogfcgdgmV0LSdCm+ftyT0R5T9
	KZV9W2MzBBmxLyD0yP6xl//Zj2ewyZKGMkG3DnAWlW+zhoSmEu0bHYn6KaBbgPsEZdv7wQPBVsglw
	yy0ZOXHNXL7VpI8LDOXW4RZGAK7TgmxyWnEQBczBiuDRmQShNzopIMSN7OOP8/v/jcZnoSETJRodo
	NPuazdVg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1tBECp-0000000082d-1cIv;
	Wed, 13 Nov 2024 15:18:51 +0100
Date: Wed, 13 Nov 2024 15:18:51 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, eric@garver.life
Subject: Re: improving json error reporting [was Re: [PATCH nft] json:
 collapse set element commands from parser]
Message-ID: <ZzS1S_iut-YSAkem@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, eric@garver.life
References: <20241031220411.165942-1-pablo@netfilter.org>
 <ZyofFLveeueZuJPH@orbyte.nwl.cc>
 <ZypNF7HzKrjl0w9s@calendula>
 <ZypQ5iMZmoPdOzlX@orbyte.nwl.cc>
 <ZzSIkcAuGeX_HoGp@calendula>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzSIkcAuGeX_HoGp@calendula>

On Wed, Nov 13, 2024 at 12:08:01PM +0100, Pablo Neira Ayuso wrote:
> Hi Phil,
> 
> On Tue, Nov 05, 2024 at 06:07:50PM +0100, Phil Sutter wrote:
> > On Tue, Nov 05, 2024 at 05:51:35PM +0100, Pablo Neira Ayuso wrote:
> > > Hi Phil,
> > > 
> > > On Tue, Nov 05, 2024 at 02:35:16PM +0100, Phil Sutter wrote:
> > > > On Thu, Oct 31, 2024 at 11:04:11PM +0100, Pablo Neira Ayuso wrote:
> > > > > Update json parser to collapse {add,create} element commands to reduce
> > > > > memory consumption in the case of large sets defined by one element per
> > > > > command:
> > > > > 
> > > > > {"nftables": [{"add": {"element": {"family": "ip", "table": "x", "name":
> > > > > "y", "elem": [{"set": ["1.1.0.0"]}]}}},...]}
> > > > 
> > > > Thanks for the fix!
> > > > 
> > > > > Add CTX_F_COLLAPSED flag to report that command has been collapsed.
> > > > 
> > > > I had come up with a similar solution (but did not find time to submit
> > > > it last week). My solution to the "what to return" problem was to
> > > > introduce a 'static struct cmd cmd_nop' and return its address. Your
> > > > flag way is fine, too from my PoV.
> > > 
> > > OK, I'm going to push it out then.
> > > 
> > > > > This patch reduces memory consumption by ~32% this case.
> > > > > 
> > > > > Fixes: 20f1c60ac8c8 ("src: collapse set element commands from parser")
> > > > > Reported-by: Eric Garver <eric@garver.life>
> > > > > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > > > > ---
> > > > > Side note: While profiling, I can still see lots json objects, this
> > > > > results in memory consumption that is 5 times than native
> > > > > representation. Error reporting is also lagging behind, it should be
> > > > > possible to add a json_t pointer to struct location to relate
> > > > > expressions and json objects.
> > > > 
> > > > I can have a look at mem use if I find spare time (TM).
> > > 
> > > I understand, that is always the issue.
> > 
> > It's on my TODO at least, let's hope for the best.
> 
> Thanks, we are already discussing this in a different thread.
> 
> > > > We already record links between struct cmd and json_t objects for echo
> > > > mode (and only then). The problem with error reporting in my opinion is
> > > > the lack of location data in json_t. You might remember, I tried to
> > > > extend libjansson to our needs but my MR[1] is being ignored for more
> > > > than a year now. Should we just ship an extended copy in nftables?
> > > 
> > > Do you still have the link with your proposal around? I don't find it
> > > in my notes anymore.
> > 
> > Ah, prolly forgot to resolve that [1] above:
> > 
> > https://github.com/akheron/jansson/pull/662
> > 
> > > IIRC the rejection came from concerns about increasing memory usage
> > > for our specific usecase, that was an extra pointer to store location,
> > > correct?
> > 
> > That and lack of interest in the feature in general. See the linked !461
> > for some feedback. The uncommented implementation in !662 hides
> > everything behind a decoder flag and avoids any memory overhead if not
> > enabled. The only remaining concern I can't address is: "we don't see
> > this as an important feature that should be included in Jansson."
> 
> Your changeset for jansson look relative small, coding style look also
> correct, and you have addressed the memory consumption issue.
> 
> It is a pity, I wonder what people do when json in this case? They
> have to scavenge in the json soup to find for non-syntactic errors as
> we have to do with it?
> 
> Having said this, I like jansson implementation, it is neat.
> 
> Caching a copy of libjansson in the nftables tree does not look like a
> way to go IMO.
> 
> Is there a chance to poke them again / refresh your pull request?

I rebased the merge request and added a comment. Let's see if someone
reacts.

> Otherwise, we will have to search for alternative path to improve the
> existing situation.

If they don't accept, I see no way other than forking their lib or
reimplementing functionality in another way.

Cheers, Phil

