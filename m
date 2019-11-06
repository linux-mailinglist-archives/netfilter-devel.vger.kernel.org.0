Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D625F2018
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Nov 2019 21:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKFUuy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Nov 2019 15:50:54 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:34342 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfKFUuy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Nov 2019 15:50:54 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iSSGS-0006xB-UK; Wed, 06 Nov 2019 21:50:52 +0100
Date:   Wed, 6 Nov 2019 21:50:52 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] doc: Drop incorrect requirement for nft configs
Message-ID: <20191106205052.GV15063@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191105131439.31826-1-phil@nwl.cc>
 <20191106114724.mscqhcyttwm7ydos@salvia>
 <20191106141953.GR15063@orbyte.nwl.cc>
 <20191106202557.wkde4zm4akcjas4j@salvia>
 <20191106202720.xzyeytcaouyoo2kg@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106202720.xzyeytcaouyoo2kg@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 06, 2019 at 09:27:20PM +0100, Pablo Neira Ayuso wrote:
> On Wed, Nov 06, 2019 at 09:25:57PM +0100, Pablo Neira Ayuso wrote:
> > On Wed, Nov 06, 2019 at 03:19:53PM +0100, Phil Sutter wrote:
> > > On Wed, Nov 06, 2019 at 12:47:24PM +0100, Pablo Neira Ayuso wrote:
> > > > On Tue, Nov 05, 2019 at 02:14:39PM +0100, Phil Sutter wrote:
> > > > > The shebang is not needed in files to be used with --file parameter.
> > > > > 
> > > > > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > > > 
> > > > Right, this is actually handled as a comment right now, not as an
> > > > indication of what binary the user would like to use.
> > > > 
> > > > It should be possible to implement the shebang for nft if you think
> > > > this is useful.
> > > 
> > > Well, it works already? If I make a config having the shebang
> > > executable, I can execute it directly. It's just not needed when passed
> > > to 'nft -f'. And in that use-case, I don't see a point in interpreting
> > > it, the user already chose which binary to use by calling it. :)
> > 
> > Indeed, forget this. Thanks.
> 
> BTW, it would be good to remove this from the example files in the tree.

I'll send a patch, thanks!
