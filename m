Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD133BB9A9
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Jul 2021 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhGEI6u (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Jul 2021 04:58:50 -0400
Received: from mail.netfilter.org ([217.70.188.207]:47390 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhGEI6u (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:58:50 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 086EC6164E;
        Mon,  5 Jul 2021 10:56:03 +0200 (CEST)
Date:   Mon, 5 Jul 2021 10:56:10 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: Documentation question
Message-ID: <20210705085610.GB16975@salvia>
References: <YOJINLIUz9fFAxa2@slk1.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YOJINLIUz9fFAxa2@slk1.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 05, 2021 at 09:45:56AM +1000, Duncan Roe wrote:
> Hi Pablo,
> 
> Did you follow the email thread
> https://www.spinics.net/lists/netfilter/msg60278.html?
> 
> In summary, OP asked:
> > Good morning! I am using the nf-queue.c example from
> > libnetfilter_queue repo. In the queue_cb() function, I am trying to
> > get the conntrack info but this condition is always false.
> >
> > if(attr[NFQA_CT])
> >
> > I can see the flow in conntrack -L output. Anyone know what I am
> > missing? Appreciate your help!
> 
> and Florian replied:
> > IIRC you need to set NFQA_CFG_F_CONNTRACK in NFQA_CFG_FLAGS when setting
> > up the queue.  The example only sets F_GSO, so no conntrack info is
> > added.
> 
> My question is, where should all this have been documented?
> 
> `man nfq_set_queue_flags` documents NFQA_CFG_F_CONNTRACK, but
> nfq_set_queue_flags() is deprecated and OP was not using it.
> 
> The modern approach is to code
> > mnl_attr_put_u32(nlh, NFQA_CFG_MASK, htonl(NFQA_CFG_F_GSO));
>
> NFQA_CFG_MASK is supplied by a libnetfilter_queue header, while
> mnl_attr_put_u32() is a libmnl function. What to do?

NFQA_CFG_MASK is supplied by linux/netfilter/nfnetlink_queue.h

The UAPI header is the main reference, it provides the kernel
definitions for the netlink attributes.

libnetfilter_queue provides a "cache copy" of this header too, that
is: libnetfilter_queue/linux_nfnetlink_queue.h
