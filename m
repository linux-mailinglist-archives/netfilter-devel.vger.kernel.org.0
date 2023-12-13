Return-Path: <netfilter-devel+bounces-331-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A82781210C
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Dec 2023 22:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07491F21919
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Dec 2023 21:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB37FBBF;
	Wed, 13 Dec 2023 21:57:17 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FE2F4
	for <netfilter-devel@vger.kernel.org>; Wed, 13 Dec 2023 13:57:13 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rDXE6-0003Zz-Tn; Wed, 13 Dec 2023 22:57:10 +0100
Date: Wed, 13 Dec 2023 22:57:10 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl RFC 2/2] expr: Introduce struct expr_ops::attr_policy
Message-ID: <20231213215710.GA11700@breakpoint.cc>
References: <20231213190222.3681-1-phil@nwl.cc>
 <20231213190222.3681-2-phil@nwl.cc>
 <20231213202035.GA6601@breakpoint.cc>
 <ZXonUyedK70ZMkFY@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXonUyedK70ZMkFY@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Phil Sutter <phil@nwl.cc> wrote:
> > Something like:
> > 
> > !attr_policy -> return -1;
> 
> Which means I can't procrastinate writing the policies for all 40
> expressions. ;)

Oh, right.

> > type > nftnl_max_attr -> return -1:
> > data_len > maxlen -> return -1.
> 
> I wanted to make this an opt-in approach, so I'd rather go with
> maxlen && maxlen < data_len -> return -1.

Alright, it could be made more strict later
once all have been converted.

> > But I admit that this might break compatibility
> > or otherwise leak internals into the api.
> 
> It's not entirely straightforward, anyway. NFTNL_EXPR_IMM_CHAIN for
> instance accepts literally anything as long as it's a NUL-terminated
> string. I was unsure whether libnftnl should enforce
> NFT_CHAIN_MAXNAMELEN there or not.

Good point.  ATM libnftnl and nftables are more tightly coupled,
so I don't see why enforcing NFT_CHAIN_MAXNAMELEN would bite us
at some point.

We could also cap to 65528 which is what netlink would permit
(nla attr header plus playload).

