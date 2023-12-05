Return-Path: <netfilter-devel+bounces-176-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B5B80559F
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 14:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F70328185D
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7389E5C917;
	Tue,  5 Dec 2023 13:14:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3F199
	for <netfilter-devel@vger.kernel.org>; Tue,  5 Dec 2023 05:14:49 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rAVGC-0008Np-Ai; Tue, 05 Dec 2023 14:14:48 +0100
Date: Tue, 5 Dec 2023 14:14:48 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: Re: [PATCH v2 nft] parser: tcpopt: fix tcp option parsing with NUM +
 length field
Message-ID: <20231205131448.GB13832@breakpoint.cc>
References: <20231205115610.19791-1-fw@strlen.de>
 <ZW8Sl6M+1bkLihy9@calendula>
 <20231205122026.GA13832@breakpoint.cc>
 <ZW8cgUtUjMGS/apR@calendula>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW8cgUtUjMGS/apR@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Tue, Dec 05, 2023 at 01:20:26PM +0100, Florian Westphal wrote:
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > >  	if (!desc) {
> > > > -		if (field != TCPOPT_COMMON_KIND || kind > 255)
> > > > +		if (kind > 255)
> > > >  			return NULL;
> > > 
> > > Another suggestion: Remove this NULL, it leaves lhs as NULL in the
> > > relational. kind > 255 cannot ever happen, parser rejects numbers over
> > > 255.
> > 
> > We can also feed this via input from udata (typeof).
> > So I'd rather not assert() or rely on bison checks.
> 
> OK, but then NULL does not help either, that will crash on evaluation too.
> 
> You could narrow down kind and field in tcpopt_expr_alloc() to uint8_t.

Unfortunately, no.  'kind' is overloaded, SACK blocks 1/2/3/4 use values
gt 255, see TCPOPT_KIND_SACK3 at end of enum tcpopt_kind.

