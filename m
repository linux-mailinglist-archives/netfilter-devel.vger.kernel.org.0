Return-Path: <netfilter-devel+bounces-173-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CE1805529
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888E01F21442
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C83DB92;
	Tue,  5 Dec 2023 12:50:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B148124
	for <netfilter-devel@vger.kernel.org>; Tue,  5 Dec 2023 04:50:14 -0800 (PST)
Received: from [78.30.43.141] (port=47420 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rAUsN-0006dZ-5O; Tue, 05 Dec 2023 13:50:13 +0100
Date: Tue, 5 Dec 2023 13:50:09 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: Re: [PATCH v2 nft] parser: tcpopt: fix tcp option parsing with NUM +
 length field
Message-ID: <ZW8cgUtUjMGS/apR@calendula>
References: <20231205115610.19791-1-fw@strlen.de>
 <ZW8Sl6M+1bkLihy9@calendula>
 <20231205122026.GA13832@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205122026.GA13832@breakpoint.cc>
X-Spam-Score: -1.9 (-)

On Tue, Dec 05, 2023 at 01:20:26PM +0100, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > >  	if (!desc) {
> > > -		if (field != TCPOPT_COMMON_KIND || kind > 255)
> > > +		if (kind > 255)
> > >  			return NULL;
> > 
> > Another suggestion: Remove this NULL, it leaves lhs as NULL in the
> > relational. kind > 255 cannot ever happen, parser rejects numbers over
> > 255.
> 
> We can also feed this via input from udata (typeof).
> So I'd rather not assert() or rely on bison checks.

OK, but then NULL does not help either, that will crash on evaluation too.

You could narrow down kind and field in tcpopt_expr_alloc() to uint8_t.

