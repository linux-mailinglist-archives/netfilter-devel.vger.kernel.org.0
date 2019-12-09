Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC19E1179A5
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Dec 2019 23:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLIWrO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Dec 2019 17:47:14 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:42292 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbfLIWrN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:47:13 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ieRo6-0004Eu-PX; Mon, 09 Dec 2019 23:47:10 +0100
Date:   Mon, 9 Dec 2019 23:47:10 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
Subject: Re: [RFC PATCH nf-next] netfilter: conntrack: add support for
 storing DiffServ code-point as CT mark.
Message-ID: <20191209224710.GI795@breakpoint.cc>
References: <20191203160652.44396-1-ldir@darbyshire-bryant.me.uk>
 <20191209214208.852229-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209214208.852229-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> "ct dscpmark" is a method of storing the DSCP of an ip packet into the
> conntrack mark.  In combination with a suitable tc filter action
> (act_ctinfo) DSCP values are able to be stored in the mark on egress and
> restored on ingress across links that otherwise alter or bleach DSCP.
> 
> This is useful for qdiscs such as CAKE which are able to shape according
> to policies based on DSCP.
> 
> Ingress classification is traditionally a challenging task since
> iptables rules haven't yet run and tc filter/eBPF programs are pre-NAT
> lookups, hence are unable to see internal IPv4 addresses as used on the
> typical home masquerading gateway.
> 
> The "ct dscpmark" conntrack statement solves the problem of storing the
> DSCP to the conntrack mark in a way suitable for the new act_ctinfo tc
> action to restore.

Yes, but if someone else wants to store ip saddr or udp port or ifindex
or whatever we need to extend this again.

nft should be able to support:

nft add rule inet filter forward ct mark set ip dscp

(nft will reject this because types are different).

Same for

nft add rule inet filter forward ct mark set ip dscp << 16

(nft will claim the shift is unsupported for a 8 bit type).

We need a cast operator for this.  Something like

nft add rule inet filter forward ct mark set typeof(ct mark) ip dscp

or anything else that tells the parser that we really want the diffserv
value to be assigned to a mark type.

As far as I can see, no kernel changes would be reqired for this.

A cheap starting point would be to try to get rid of the sanity test
and make nft just accept the right-hand-side of 'ct mark set',
then see how to best add an 'do this anyway' override in the grammar.

I have older patches that adds a 'typeof' keyword for set definitions,
maybe it could be used for this casting too.
