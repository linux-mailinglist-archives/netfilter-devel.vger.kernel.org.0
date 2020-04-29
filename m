Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846891BE88E
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2020 22:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgD2Uae (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 29 Apr 2020 16:30:34 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45447 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgD2Uae (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:30:34 -0400
Received: from dimstar.local.net (n175-34-64-112.sun1.vic.optusnet.com.au [175.34.64.112])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id 6ADF23A3BE3
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 06:30:30 +1000 (AEST)
Received: (qmail 9360 invoked by uid 501); 29 Apr 2020 20:30:29 -0000
Date:   Thu, 30 Apr 2020 06:30:29 +1000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH libnetfilter_queue 0/3] pktbuff API updates
Message-ID: <20200429203029.GD3833@dimstar.local.net>
Mail-Followup-To: Netfilter Development <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <20200426132356.8346-1-pablo@netfilter.org>
 <20200427110614.GA15436@dimstar.local.net>
 <20200427170656.GA22296@salvia>
 <20200428043302.GB15436@dimstar.local.net>
 <20200428103407.GA1160@salvia>
 <20200428211452.GF15436@dimstar.local.net>
 <20200428225520.GA30421@salvia>
 <20200429132840.GA3833@dimstar.local.net>
 <20200429191047.GB3833@dimstar.local.net>
 <20200429191643.GA16749@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429191643.GA16749@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=keeXcwCgVCrAuxOn72dlvA==:117 a=keeXcwCgVCrAuxOn72dlvA==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=RSmzAf-M6YYA:10
        a=N5gUBDmrcLR0umzgC2wA:9 a=6LkiU943CJQfUohZ:21 a=SUqgkOog46uizMGg:21
        a=CjuIK1q_8ugA:10
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

I sent this email (explanation of how the system works) before I saw your email
asking for that explanation.

Then I replied to that email of yours before I saw this one.

On Wed, Apr 29, 2020 at 09:16:43PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Apr 30, 2020 at 05:10:47AM +1000, Duncan Roe wrote:
> [...]
> > Sorry, I should have explained a bit more how the system would work:
> >
> > struct pkt_buff has 3 new members:
> >
> >         bool    copy_done;
> >         uint32_t extra;
> >         uint8_t *copy_buf;
> >
> > When extra > 0, pktb_alloc2 verifies that buflen is >= len + extra. It then
> > stores extra and copy_buf in pktb, ready for use by pktb_mangle() (all the other
> > manglers call this eventually).
> >
> > So that's how pktb_mangle() doesn't need to allocate a buffer.
>
> Thanks for the explaining. Given this is in userspace, it is easier if

Tiny nit - this could be userspace on an embedded device where memory is really
tight. So perhaps document with "If memory is at a premium, you really only need
len + extra" otherwise a big buf is fine.

> the user allocates the maximum packet length that is possible:
>
>         0xffff + (MNL_SOCKET_BUFFER_SIZE/2);
>
> We can probably expose this to the header so they can pre-allocate a
> buffer that is large enough and, hence, _mangle() is guaranteed to
> have always enough room to add extra bytes.

Yes I saw that expression in examples/nf-queue.c. How about

#define COPY_BUF_SIZE (0xffff + (MNL_SOCKET_BUFFER_SIZE/2))

or what other name would you like?

--- Off-topic

I'm intrigued that you ccan use MNL_SOCKET_BUFFER_SIZE when dimensioning static
variables. The expansion is

#define MNL_SOCKET_BUFFER_SIZE (sysconf(_SC_PAGESIZE) < 8192L ?
sysconf(_SC_PAGESIZE) : 8192L)

and sysconf is an actual function:

unistd.h:622:extern long int sysconf (int __name) __THROW;

If I try to dimension a static variable using pktb_head_size(), the compiler
throws an error.  Why is sysconf() ok but not pktb_head_size()?

Cheers ... Duncan.
