Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726DA3EDA92
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Aug 2021 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhHPQKp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Aug 2021 12:10:45 -0400
Received: from mail.netfilter.org ([217.70.188.207]:55678 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhHPQKp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:10:45 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id B5EE36003C;
        Mon, 16 Aug 2021 18:09:25 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:10:09 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     alexandre.ferrieux@orange.com, Florian Westphal <fw@strlen.de>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: nfnetlink_queue -- why linear lookup ?
Message-ID: <20210816161009.GA2258@salvia>
References: <11790_1628855682_61165D82_11790_25_1_3f865faa-9fd8-40aa-6e49-5d85dd596b5b@orange.com>
 <20210814210103.GG607@breakpoint.cc>
 <14552_1628975094_61182FF6_14552_82_1_d4901cb2-0852-a524-436c-62bf06f95d0e@orange.com>
 <20210814211238.GH607@breakpoint.cc>
 <27263_1629029795_611905A3_27263_246_1_ddbb7a24-d843-9985-5833-c7c8c1aa8d29@orange.com>
 <20210815130716.GA21655@salvia>
 <4942_1629034317_6119174D_4942_150_1_d69d3f05-89f7-63b5-4759-ef1987aca476@orange.com>
 <20210815141204.GA22946@salvia>
 <YRpUauSav1HMS+hw@slk1.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRpUauSav1HMS+hw@slk1.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 16, 2021 at 10:04:58PM +1000, Duncan Roe wrote:
> On Sun, Aug 15, 2021 at 04:12:04PM +0200, Pablo Neira Ayuso wrote:
> > On Sun, Aug 15, 2021 at 03:32:30PM +0200, alexandre.ferrieux@orange.com wrote:
> > > On 8/15/21 3:07 PM, Pablo Neira Ayuso wrote:
> > > > On Sun, Aug 15, 2021 at 02:17:08PM +0200, alexandre.ferrieux@orange.com wrote:
> > > > [...]
> > > > > So, the only way forward would be a separate hashtable on ids.
> > > >
> > > > Using the rhashtable implementation is fine for this, it's mostly
> > > > boilerplate code that is needed to use it and there are plenty of
> > > > examples in the kernel tree if you need a reference.
> > >
> > > Thanks, that's indeed pretty simple. I was just worried that people would
> > > object to adding even the slightest overhead (hash_add/hash_del) to the
> > > existing code path, that satisfies 99% of uses (LIFO). What do you think ?
> >
> > It should be possible to maintain both the list and the hashtable,
> > AFAICS, the batch callback still needs the queue_list.
> >
> > > > > PS: what is the intended dominant use case for batch verdicts ?
> > > >
> > > > Issuing a batch containing several packets helps to amortize the
> > > > cost of the syscall.
> > >
> > > Yes, but that could also be achieved by passing an array of ids.
> >
> > You mean, one single sendmsg() with several netlink messages, that
> > would also work to achieve a similar batching effect.
> 
> sendmsg() can actually be slower. I gave up on a project to send verdicts using
> sendmsg() (especially with large mangled packets), because benchmarking showed:
> 
> 1. on a 3YO laptop, no discernable difference.
> 
> 2. On a 1YO Ryzen desktop, sendmsg() significantly slower.
> 
> sendmsg() sent 3 or 4 buffers: 1. leading netlink message blocks; 2. the packet;
> 3. padding to 4 bytes (if required); last: trailing netlink message blocks.
>
> sendmsg() saved moving these data blocks into a single buffer. But it introduced
> the overhead of the kernel's having to validate 4 userland buffers instead of 1.
> 
> A colleague suggested the Ryzen result is because of having 128-bit registers to
> move data. I guess that must be it.
> 
> The spreadsheets from the tests are up on GitHub:
> https://github.com/duncan-roe/nfq6/blob/main/laptop_timings.ods
> https://github.com/duncan-roe/nfq6/blob/main/timings.ods

Just a quick test creating 64K entries in the conntrack table, using
libmnl.

- With batching

# time ./batch

real    0m0,122s
user    0m0,010s
sys     0m0,112s

- Without batching

# time ./nobatch

real    0m0,195s
user    0m0,049s
sys     0m0,146s

Just a sample, repeating the tests show similar numbers.

Submitting a verdict on a packet via nfnetlink_queue is similar to
creating an ct entry through ctnetlink (both use the send syscall).

If you only have a few packets waiting for verdict in userspace, then
probably batching is not helping much.

BTW, leading and trailing netlink message blocks to the kernel are not
required for nfnetlink_queue.
