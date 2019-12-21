Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBBB1288AF
	for <lists+netfilter-devel@lfdr.de>; Sat, 21 Dec 2019 11:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfLUKoD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 21 Dec 2019 05:44:03 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:49597 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbfLUKoC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 21 Dec 2019 05:44:02 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id A111143F997
        for <netfilter-devel@vger.kernel.org>; Sat, 21 Dec 2019 21:43:47 +1100 (AEDT)
Received: (qmail 17877 invoked by uid 501); 21 Dec 2019 10:43:45 -0000
Date:   Sat, 21 Dec 2019 21:43:45 +1100
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: Documentation question
Message-ID: <20191221104345.GA10475@dimstar.local.net>
Mail-Followup-To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
References: <20191215020220.GA10616@dimstar.local.net>
 <20191220002953.gv25rcn7kvv43zk4@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220002953.gv25rcn7kvv43zk4@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=RSmzAf-M6YYA:10 a=RfsCFiYAUiaG-KS9dkgA:9 a=CjuIK1q_8ugA:10
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 20, 2019 at 01:29:53AM +0100, Pablo Neira Ayuso wrote:
> On Sun, Dec 15, 2019 at 01:02:20PM +1100, Duncan Roe wrote:
> > Hi Pablo,
> >
> > In pktbuff.c, the doc for pktb_mangle states that "It is appropriate to use
> > pktb_mangle to change the MAC header".
> >
> > This is not true. pktb_mangle always mangles from the network header onwards.
> >
> > I can either:
> >
> > Whithdraw the offending doc items
> >
> > OR:
> >
> > Adjust pktb_mangle to make the doc correct. This involves changing pktb_mangle,
> > nfq_ip_mangle and (soon) nfq_ip6_mangle. The changes would be a no-op for
> > AF_INET and AF_INET6 packet buffers.
> >
> > What do you think?
>
> You could fix it through signed int dataoff. So the users could
> specify a negative offset to mangle the MAC address.
>
> This function was made to update layer 7 payload information to
> implement the helpers. So dataoff usually contains the transport
> header size.
>
> Let me know, thanks.
>
-ve offsets? There has to be a better way.

When I added documentation for pktb_mangle, I assumed it mangled from
pktb->data, rather than checking the source.

That is the function I documented, and I think we need a function like that.

Rather than change the behaviour of pktb_mangle when a MAC header is present, I
propose a new function pktb_mangle2 which mangles from pktb->data onwards.

pktb_mangle would call this new function, with dataoff incremented by
pktb->network_header - pktb->data (only nonzero for AF_BRIDGE)

Ok?

Cheers ... Duncan.
