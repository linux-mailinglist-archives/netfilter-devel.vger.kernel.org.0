Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74871912B1
	for <lists+netfilter-devel@lfdr.de>; Sat, 17 Aug 2019 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfHQT0Z (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 17 Aug 2019 15:26:25 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:49986 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbfHQT0Z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 17 Aug 2019 15:26:25 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hz4LH-0001Xu-Iu; Sat, 17 Aug 2019 21:26:23 +0200
Date:   Sat, 17 Aug 2019 21:26:23 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 0/8] add typeof keyword
Message-ID: <20190817192623.xi3xur5dtxq5imwc@breakpoint.cc>
References: <20190816144241.11469-1-fw@strlen.de>
 <20190817102351.x2s2vj5hgvsi5vak@salvia>
 <20190817103337.omvl2bfjlxr6mb3p@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817103337.omvl2bfjlxr6mb3p@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Sat, Aug 17, 2019 at 12:23:51PM +0200, Pablo Neira Ayuso wrote:
> [...]
> > On Fri, Aug 16, 2019 at 04:42:33PM +0200, Florian Westphal wrote:
> [..]
> > P.S: patch 1/8 and 2/8 are related to this patchset? After quick
> > glance, not obvious to me or if they are again related to multiple
> > nft_ctx_new() calls.
> 
> I found it, it is in patch 6/8, it making a call to set_make_key to
> get the datatype to translate the selector to datatype using the
> parser API.

Yes, I could push patch #1 independently though.
