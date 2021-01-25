Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967A4302593
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Jan 2021 14:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbhAYNfZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Jan 2021 08:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbhAYNfF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:35:05 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73168C061574
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Jan 2021 05:34:18 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1l420L-0000Pr-AT; Mon, 25 Jan 2021 14:34:05 +0100
Date:   Mon, 25 Jan 2021 14:34:05 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Lukas Wunner <lukas@wunner.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Laura Garcia Liebana <nevola@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, Thomas Graf <tgraf@suug.ch>
Subject: Re: [netfilter-core] [PATCH nft v4] src: Support netdev egress hook
Message-ID: <20210125133405.GR19605@breakpoint.cc>
References: <4b3c95a0449591c97f68be15d8d17bda298a7b5e.1611498014.git.lukas@wunner.de>
 <20210125132238.GG3158@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125132238.GG3158@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> > diff --git a/tests/py/inet/ip.t.payload.netdev b/tests/py/inet/ip.t.payload.netdev
> > index 95be919..38ed0ad 100644
> > --- a/tests/py/inet/ip.t.payload.netdev
> > +++ b/tests/py/inet/ip.t.payload.netdev
> > @@ -12,3 +12,17 @@ netdev test-netdev ingress
> >    [ payload load 6b @ link header + 6 => reg 10 ]
> >    [ lookup reg 1 set __set%d ]
> >  
> > +# meta protocol ip ip saddr . ip daddr . ether saddr { 1.1.1.1 . 2.2.2.2 . ca:fe:ca:fe:ca:fe }
> > +__set%d test-netdev 3
> > +__set%d test-netdev 0
> > +	element 01010101 02020202 fecafeca 0000feca  : 0 [end]
> > +netdev test-netdev egress 
> > +  [ meta load protocol => reg 1 ]
> > +  [ cmp eq reg 1 0x00000008 ]
> > +  [ meta load iiftype => reg 1 ]
                   ~~~~~~~

shouldn't nft add oiftype for egress?

[ That being said, its fine to wait until kernel patches
are in net-next before spending more time on this ].
