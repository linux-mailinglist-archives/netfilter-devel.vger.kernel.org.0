Return-Path: <netfilter-devel+bounces-3863-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB84D977DF0
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2024 12:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F5B2858E2
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2024 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC61D7997;
	Fri, 13 Sep 2024 10:47:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EB1D58A8
	for <netfilter-devel@vger.kernel.org>; Fri, 13 Sep 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224453; cv=none; b=GRtbatXWDfLh32ZoL3D4pUH/CLwzjQQZVZTnDYOQzTpW32tYBxX2WRIkHE6RCtkX8at1A+3YQhSfuVYxcIFMbexzpt/CCyxOCWS41xUJWxDn74gKUbGcVg9sg8/x3hGLob+V3BxxiLmZu4ap4LWDBffj0iDELE2Bu5LwfE57h84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224453; c=relaxed/simple;
	bh=fbbEx6rw29xcH18YJwAJUM72dV8Hbf+k2VXqpcoYJWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOx+ohi2ZwBSvLOERtyKGMDYc/iu24vC1xJ/7VjWkVbEhn/6/pc8NWTByN78jZalBjCLNNYngZjFxl0Tqm3GPpsByCYkKw0PoUuXxpbh/WUJc0WzZ2QIveklHXu7L/qjJIlJQ7gfke5bpQJVwQipwQ1avlwPT/UnVfVwjX3sX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=50876 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sp3pn-00AFlA-6g; Fri, 13 Sep 2024 12:47:29 +0200
Date: Fri, 13 Sep 2024 12:47:26 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, antonio.ojea.garcia@gmail.com,
	phil@nwl.cc
Subject: Re: [PATCH nf] netfilter: nft_tproxy: make it terminal
Message-ID: <ZuQYPr3ugqG-Yz82@calendula>
References: <20240913102023.3948-1-pablo@netfilter.org>
 <20240913102347.GA15700@breakpoint.cc>
 <ZuQT60TznuVOHtZg@calendula>
 <20240913104101.GA16472@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913104101.GA16472@breakpoint.cc>
X-Spam-Score: -1.9 (-)

On Fri, Sep 13, 2024 at 12:41:01PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Fri, Sep 13, 2024 at 12:23:47PM +0200, Florian Westphal wrote:
> > > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > > tproxy action must be terminal since the intent of the user to steal the
> > > > traffic and redirect to the port.
> > > > Align this behaviour to iptables to make it easier to migrate by issuing
> > > > NF_ACCEPT for packets that are redirect to userspace process socket.
> > > > Otherwise, NF_DROP packet if socket transparent flag is not set on.
> > > 
> > > The nonterminal behaviour is intentional. This change will likely
> > > break existing setups.
> > > 
> > > nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set 1 accept
> > > 
> > > This is a documented example.
> > 
> > Ouch. Example could have been:
> > 
> >   nft add rule filter divert tcp dport 80 socket transparent meta set 1 tproxy to :50080
> 
> Yes, but its not the same.
> 
> With the statements switched, all tcp dport 80 have the mark set.
> With original example, the mark is set only if tproxy found a
> transparent sk.

Indeed, thanks for correcting me.

I'm remembering now why this was done to provide to address the ugly
mark hack that xt_TPROXY provides.

While this is making harder to migrate, making it non-terminal is
allowing to make more handling such as ct/meta marking after it.

I think we just have to document this in man nft(8).

