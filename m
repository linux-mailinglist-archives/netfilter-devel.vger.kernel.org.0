Return-Path: <netfilter-devel+bounces-139-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18F4802F05
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 10:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D91B2089E
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67A1CA9F;
	Mon,  4 Dec 2023 09:43:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E439E6
	for <netfilter-devel@vger.kernel.org>; Mon,  4 Dec 2023 01:43:53 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rA5UV-0006tM-CS; Mon, 04 Dec 2023 10:43:51 +0100
Date: Mon, 4 Dec 2023 10:43:51 +0100
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
	Netfilter Development Mailinglist <netfilter-devel@vger.kernel.org>
Subject: Re: does nft 'tcp option ... exists' work?
Message-ID: <20231204094351.GC5972@breakpoint.cc>
References: <CAHo-OozyEqHUjL2-ntATzeZOiuftLWZ_HU6TOM_js4qLfDEAJg@mail.gmail.com>
 <CAHo-Oow4CJGe-xfhweZWzWZ0kaJiwg7HOjKCU-r7HLV_TYGNLQ@mail.gmail.com>
 <20231203131344.GB5972@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231203131344.GB5972@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Florian Westphal <fw@strlen.de> wrote:
> Maciej Żenczykowski <zenczykowski@gmail.com> wrote:
> > FYI, I upgraded the router to OpenWrt 23.05.2 with 5.15.137 and it
> > doesn't appear to have changed anything, ie. 'tcp option fastopen
> > exists' still does not appear to match.
> > 
> > Also note that I'm putting this in table inet filter postrouting like
> > below... but that shouldn't matter should it?
> 
> No, this is an endianess bug, on BE the compared byte is always 0.

We could fix this from userspace too:

... exists  -> reg32 != 0
... missing -> reg32 == 0

currently nftables uses &boolean_type, so the
compare is for 1 byte.  We could switch this to
32 bit integer type, this way it will no longer
matter if the kernel stores the number at offset 0 or 3.

Phil, Pablo, what do you think?

