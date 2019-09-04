Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBB4A7F6A
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2019 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfIDJbS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Sep 2019 05:31:18 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:50192 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfIDJbS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:31:18 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1i5RdC-0006Yn-Rm; Wed, 04 Sep 2019 11:31:14 +0200
Date:   Wed, 4 Sep 2019 11:31:14 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [conntrack-tools PATCH] conntrack: Fix CIDR to mask conversion
 on Big Endian
Message-ID: <20190904093114.GI25650@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20190902164431.18398-1-phil@nwl.cc>
 <20190903203447.saqplkgbbxlajkqr@salvia>
 <20190904065356.GF25650@orbyte.nwl.cc>
 <20190904082128.GG13660@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904082128.GG13660@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Sep 04, 2019 at 10:21:28AM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > What we need in b is 'ff ff ff 00' for a prefix length of 24. Your
> > suggested alternative does not compile, so I tried both options for the
> > closing brace:
> > 
> > | htonl((1 << 24) - 1)
> > 
> > This turns into '00 ff ff ff' for both LE and BE, the opposite of what
> > we need.
> > 
> > | htonl((1 << 24)) - 1
> > 
> > This turns into '00 00 00 00' on LE and '00 ff ff ff' on BE.
> > 
> > My code leads to correct result on either architecture and I don't see a
> > simpler way of doing it.
> 
> htonl(~0u << (32 - i)) would work, assuming i > 0 and <= 32.

Ah, indeed! Left-shifting all-ones didn't come to mind. I'll send a v2.

Thanks, Phil
