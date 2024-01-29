Return-Path: <netfilter-devel+bounces-788-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D698683FEF3
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jan 2024 08:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9329C2854D1
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jan 2024 07:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3437E4D595;
	Mon, 29 Jan 2024 07:17:08 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E44D5AC
	for <netfilter-devel@vger.kernel.org>; Mon, 29 Jan 2024 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512628; cv=none; b=mwUIP4tSq3R6iR00oW+chtSuBcAHf+h3Z3XHbGT0BWBre2bjRE7s6JDoyfiGsQdu0X8NvQsqu9I5dJqrZ36w4Y9VqN2EJj674/BxO2tNyR9TOzOAAKlBtpDA1onkvyWx3Cn2AKrPiHWE8aBRWr7DHuobQ/s7jd+Yit9p+g/o20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512628; c=relaxed/simple;
	bh=2NZ2A3xiZ4yYwsbKJGZ3J4xhSM8ZHNqJLbYteTY4BQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyroDcjDpTIiVcFPcvx2EiI4Wq6SSOehElB/HFF38RkyUerJSm0/SUkaHgLyElq8g6TnD0xJn0qk5/IRhCq9xZqj8oY5WIz7LCU6R+bjSNJV7WgIQX1tAYikdG3It/FaQ6JlTTCRYdxX5FzUy4jwJAUmBGzs+mEisIHS/UmBm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rULt2-00073u-1l; Mon, 29 Jan 2024 08:16:56 +0100
Date: Mon, 29 Jan 2024 08:16:56 +0100
From: Florian Westphal <fw@strlen.de>
To: Kyle Swenson <kyle.swenson@est.tech>
Cc: Florian Westphal <fw@strlen.de>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] netfilter: nat: restore default DNAT behavior
Message-ID: <20240129071656.GA9973@breakpoint.cc>
References: <20240126000504.3220506-1-kyle.swenson@est.tech>
 <20240126000504.3220506-2-kyle.swenson@est.tech>
 <20240126155720.GD29056@breakpoint.cc>
 <ZbP4BFXtw4SPnMjN@p620>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbP4BFXtw4SPnMjN@p620>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kyle Swenson <kyle.swenson@est.tech> wrote:
> > Can you restrict this to NF_NAT_MANIP_DST?
> > I don't want predictable src port conflict resolution.
> > 
> > Probably something like (untested):
> > 
> > find_free_id:
> >  	if (range->flags & NF_NAT_RANGE_PROTO_OFFSET)
> >  		off = (ntohs(*keyptr) - ntohs(range->base_proto.all));
> > +	else if ((range->flags & NF_NAT_RANGE_PROTO_SPECIFIED) &&
> > +	  	  maniptype == NF_NAT_MANIP_DST))
> > + 		off = 1;
> > 	else
> >   		off = get_random_u16();
> 
> Yes, absolutely.  I'll test out the change and send a v2 next week.

Thanks! Please tweak the suggestion so that --random still overrides
--range behavior.

