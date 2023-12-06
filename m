Return-Path: <netfilter-devel+bounces-229-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD24807413
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 16:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4571F2100E
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F7D4597D;
	Wed,  6 Dec 2023 15:56:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5DDE
	for <netfilter-devel@vger.kernel.org>; Wed,  6 Dec 2023 07:56:13 -0800 (PST)
Received: from [78.30.43.141] (port=53790 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rAuFt-003rbd-PA; Wed, 06 Dec 2023 16:56:11 +0100
Date: Wed, 6 Dec 2023 16:56:08 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: Re: [PATCH nft v3] parser: tcpopt: fix tcp option parsing with NUM +
 length field
Message-ID: <ZXCZmBW67HbEUNw/@calendula>
References: <20231206115205.4289-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206115205.4289-1-fw@strlen.de>
X-Spam-Score: -1.9 (-)

On Wed, Dec 06, 2023 at 12:52:00PM +0100, Florian Westphal wrote:
> tcp option 254 length ge 4
> 
> ... will segfault.
> The crash bug is that tcpopt_expr_alloc() can return NULL if we cannot
> find a suitable template for the requested kind + field combination,
> so add the needed error handling in the bison parser.
> 
> However, we can handle this.  NOP and EOL have templates, all other
> options (known or unknown) must also have a length field.
> 
> So also add a fallback template to handle both kind and length, even
> if only a numeric option is given that nft doesn't recognize.
> 
> Don't bother with output, above will be printed via raw syntax, i.e.
> tcp option @254,8,8 >= 4.

Patch LGTM, please push it out.

Thanks.

