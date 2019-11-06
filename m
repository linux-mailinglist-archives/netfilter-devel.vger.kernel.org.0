Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0208F184E
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Nov 2019 15:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfKFOTy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Nov 2019 09:19:54 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:33694 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfKFOTy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:19:54 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iSMA5-0002P3-3g; Wed, 06 Nov 2019 15:19:53 +0100
Date:   Wed, 6 Nov 2019 15:19:53 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] doc: Drop incorrect requirement for nft configs
Message-ID: <20191106141953.GR15063@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191105131439.31826-1-phil@nwl.cc>
 <20191106114724.mscqhcyttwm7ydos@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106114724.mscqhcyttwm7ydos@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 06, 2019 at 12:47:24PM +0100, Pablo Neira Ayuso wrote:
> On Tue, Nov 05, 2019 at 02:14:39PM +0100, Phil Sutter wrote:
> > The shebang is not needed in files to be used with --file parameter.
> > 
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> 
> Right, this is actually handled as a comment right now, not as an
> indication of what binary the user would like to use.
> 
> It should be possible to implement the shebang for nft if you think
> this is useful.

Well, it works already? If I make a config having the shebang
executable, I can execute it directly. It's just not needed when passed
to 'nft -f'. And in that use-case, I don't see a point in interpreting
it, the user already chose which binary to use by calling it. :)

Cheers, Phil
