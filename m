Return-Path: <netfilter-devel+bounces-4366-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66275999FE5
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Oct 2024 11:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1871F23740
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Oct 2024 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C21F942E;
	Fri, 11 Oct 2024 09:15:14 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C6209F51
	for <netfilter-devel@vger.kernel.org>; Fri, 11 Oct 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638113; cv=none; b=mz1gPvvutpNMsL5csVEL8EIcQsAznKbZBirJbiX2170NQApmSveYkCc84xWSk/7jrSlG0rzQ+IGet7M9ry8M1qied9K4pfLkhrW6SJIOYJrJ+ztPTWSmG0fuH7B22fuUvBnJeBiYUVDuIwo8gqCJQERmrqSIZnhNzuBiM8Wh04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638113; c=relaxed/simple;
	bh=FoSECjR/1N06avgIXgqkPbluUarT+aCaFioSw8lzI9g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUSwVWIh5vxlR6fH8wrB5s24laetoTGrmmeHeGeVHI4wJG8BpSOIm/HCJp13frnXW4W66/RjrFAXZc78hJPgsw1fc3vTcyndPetiLoT+HUB7KZAxEkV+bEdS1rMA8k+291u3nLa2QbbyZtJxJM1E4zMD4Qk20BdBHgywj8ZAy8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1szBjo-00029C-9N; Fri, 11 Oct 2024 11:15:08 +0200
Date: Fri, 11 Oct 2024 11:15:08 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: fix spurious dump failure in vmap
 timeout test
Message-ID: <20241011091508.GA8212@breakpoint.cc>
References: <20241011003211.4780-1-fw@strlen.de>
 <ZwjkK0IXn0GGVCfm@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwjkK0IXn0GGVCfm@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Phil Sutter <phil@nwl.cc> wrote:
> >  		utimeout=$((RANDOM%5))
> > -		utimeout=$((timeout+1))
> > +		utimeout=$((utimeout+1))
> 
> How about merging the statements?
>
> | utimeout=$((RANDOM % 5 + 1))

Sure, that works too.  I applied the patch as-is, you can munge this as
a followup if you like.

