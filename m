Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB812D10A0
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Dec 2020 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgLGMfz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Dec 2020 07:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgLGMfz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:35:55 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45DC0613D0;
        Mon,  7 Dec 2020 04:35:15 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kmFjT-00008H-VU; Mon, 07 Dec 2020 13:35:12 +0100
Date:   Mon, 7 Dec 2020 13:35:11 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     linux-crypto@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: XFRM interface and NF_INET_LOCAL_OUT hook
Message-ID: <20201207123511.GN4647@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, netfilter-devel@vger.kernel.org
References: <20201125112342.GA11766@orbyte.nwl.cc>
 <20201126094021.GK8805@gauss3.secunet.de>
 <20201126131200.GH4647@orbyte.nwl.cc>
 <20201127095511.GD9390@gauss3.secunet.de>
 <20201127141048.GL4647@orbyte.nwl.cc>
 <20201202131847.GB85961@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202131847.GB85961@gauss3.secunet.de>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Steffen,

On Wed, Dec 02, 2020 at 02:18:47PM +0100, Steffen Klassert wrote:
> On Fri, Nov 27, 2020 at 03:10:48PM +0100, Phil Sutter wrote:
[...]
> > diff --git a/net/xfrm/xfrm_interface.c b/net/xfrm/xfrm_interface.c
> > index aa4cdcf69d471..24af61c95b4d4 100644
> > --- a/net/xfrm/xfrm_interface.c
> > +++ b/net/xfrm/xfrm_interface.c
> > @@ -317,7 +317,8 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
> >         skb_dst_set(skb, dst);
> >         skb->dev = tdev;
> >  
> > -       err = dst_output(xi->net, skb->sk, skb);
> > +       err = NF_HOOK(skb_dst(skb)->ops->family, NF_INET_LOCAL_OUT, xi->net,
> > +                     skb->sk, skb, NULL, skb_dst(skb)->dev, dst_output);
> >         if (net_xmit_eval(err) == 0) {
> >                 struct pcpu_sw_netstats *tstats = this_cpu_ptr(dev->tstats);
> 
> I don't mind that change, but we have to be carefull on namespace transition.
> xi->net is the namespace 'behind' the xfrm interface. I guess this is the
> namespace where you want to do the match because that is the namespace
> that has the policies and states for the xfrm interface. So I think that
> change is correct, I just wanted to point that out explicitely.

Thanks for the heads-up, I didn't consider this at all! But indeed I
think it makes sense. I can move the xfrm interface into a netns after
setting things up, then inside that netns netfilter only sees the plain
"inner" packets and no associated ipsec context. This is correct as the
netns doesn't have any knowledge of the policies pesent in initial
netns.

I'll submit the patch formally.

Thanks, Phil
