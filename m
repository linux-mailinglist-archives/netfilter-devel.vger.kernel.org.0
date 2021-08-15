Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D193EC98E
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Aug 2021 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhHOO2K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Aug 2021 10:28:10 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53434 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhHOO2J (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Aug 2021 10:28:09 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9A18B60052;
        Sun, 15 Aug 2021 16:26:52 +0200 (CEST)
Date:   Sun, 15 Aug 2021 16:27:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Jan Engelhardt <jengelh@inai.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptabes-nft] iptables-nft: allow removal of empty builtin
 chains
Message-ID: <20210815142734.GA31050@salvia>
References: <20210814174643.130760-1-fw@strlen.de>
 <84q02320-o5pp-8q8q-q646-473ssq92n552@vanv.qr>
 <20210814205314.GF607@breakpoint.cc>
 <20210815131223.GA30503@salvia>
 <20210815132733.GI607@breakpoint.cc>
 <20210815134922.GA10659@salvia>
 <20210815141414.GJ607@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210815141414.GJ607@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Aug 15, 2021 at 04:14:14PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > But we really do not need NLM_F_NONREC for this new feature, right? I
> > mean, a quick shortcut to remove the basechain and its content should
> > be fine.
> 
> Would deviate a lot from iptables behaviour.

It's a new feature: you could still keep NLM_F_NONREC in place, and
only allow to remove one chain (with no rules) at a time if you
prefer, ie.

iptables-nft -K INPUT -t filter

or -X if you prefer to overload the existing command.

> > > No, I don't think so.  I would prefer if
> > > iptables-nft -F -t filter
> > > iptables-nft -X -t filter
> > > 
> > > ... would result in an empty "filter" table.
> > 
> > Your concern is that this would change the default behaviour?
> 
> Yes, maybe ok to change it though.  After all, a "iptables-nft -A INPUT
> ..." will continue to work just fine (its auto-created again).
> 
> We could check if policy is still set to accept before implicit
> removal in the "iptables-nft -X" case.

That's possible yes, but why force the user to change the policy from
DROP to ACCEPT to delete an empty basechain right thereafter?
