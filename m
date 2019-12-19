Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33B1267B1
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Dec 2019 18:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfLSRIS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Dec 2019 12:08:18 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43812 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbfLSRIR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:08:17 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ihzHb-00011e-ED; Thu, 19 Dec 2019 18:08:15 +0100
Date:   Thu, 19 Dec 2019 18:08:15 +0100
From:   Florian Westphal <fw@strlen.de>
To:     David Ahern <dsahern@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        Martin Willi <martin@strongswan.org>,
        David Ahern <dsahern@kernel.org>,
        Shrijeet Mukherjee <shrijeet@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Benjamin Poirier <bpoirier@cumulusnetworks.com>
Subject: Re: [PATCH nf-next 9/9] netfilter: nft_meta: add support for slave
 device ifindex matching
Message-ID: <20191219170815.GD795@breakpoint.cc>
References: <20191218110521.14048-1-fw@strlen.de>
 <20191218110521.14048-10-fw@strlen.de>
 <ce5758ce-7541-3b6b-d61c-ae59219ef898@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce5758ce-7541-3b6b-d61c-ae59219ef898@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

David Ahern <dsahern@gmail.com> wrote:
> On 12/18/19 4:05 AM, Florian Westphal wrote:
> > Allow to match on vrf slave ifindex or name.
> > 
> > In case there was no slave interface involved, store 0 in the
> > destination register just like existing iif/oif matching.
> > 
> > sdif(name) is restricted to the ipv4/ipv6 input and forward hooks,
> > as it depends on ip(6) stack parsing/storing info in skb->cb[].
> > 
> > Cc: Martin Willi <martin@strongswan.org>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: Shrijeet Mukherjee <shrijeet@gmail.com>
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> >  include/uapi/linux/netfilter/nf_tables.h |  4 ++
> >  net/netfilter/nft_meta.c                 | 76 +++++++++++++++++++++---
> >  2 files changed, 73 insertions(+), 7 deletions(-)
> > 
> 
> do you have an example that you can share?

nft add rule inet filter input meta sdifname "eth0" accept

so its similar to existing iif(name) that test for the input device.

This is the nft equivalent for the "slavedev" match that Martin proposed
here:

http://patchwork.ozlabs.org/patch/1211435/
