Return-Path: <netfilter-devel+bounces-172-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419398053FC
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 13:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD0F1C209CF
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A45B1F7;
	Tue,  5 Dec 2023 12:20:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC72C9
	for <netfilter-devel@vger.kernel.org>; Tue,  5 Dec 2023 04:20:28 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rAUPa-00082S-Ut; Tue, 05 Dec 2023 13:20:26 +0100
Date: Tue, 5 Dec 2023 13:20:26 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: Re: [PATCH v2 nft] parser: tcpopt: fix tcp option parsing with NUM +
 length field
Message-ID: <20231205122026.GA13832@breakpoint.cc>
References: <20231205115610.19791-1-fw@strlen.de>
 <ZW8Sl6M+1bkLihy9@calendula>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW8Sl6M+1bkLihy9@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >  	if (!desc) {
> > -		if (field != TCPOPT_COMMON_KIND || kind > 255)
> > +		if (kind > 255)
> >  			return NULL;
> 
> Another suggestion: Remove this NULL, it leaves lhs as NULL in the
> relational. kind > 255 cannot ever happen, parser rejects numbers over
> 255.

We can also feed this via input from udata (typeof).
So I'd rather not assert() or rely on bison checks.

