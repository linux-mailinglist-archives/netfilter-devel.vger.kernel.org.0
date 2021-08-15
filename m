Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98A23EC960
	for <lists+netfilter-devel@lfdr.de>; Sun, 15 Aug 2021 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhHONt5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 15 Aug 2021 09:49:57 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53358 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhHONt5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 15 Aug 2021 09:49:57 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 632F26005D;
        Sun, 15 Aug 2021 15:48:40 +0200 (CEST)
Date:   Sun, 15 Aug 2021 15:49:22 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Jan Engelhardt <jengelh@inai.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptabes-nft] iptables-nft: allow removal of empty builtin
 chains
Message-ID: <20210815134922.GA10659@salvia>
References: <20210814174643.130760-1-fw@strlen.de>
 <84q02320-o5pp-8q8q-q646-473ssq92n552@vanv.qr>
 <20210814205314.GF607@breakpoint.cc>
 <20210815131223.GA30503@salvia>
 <20210815132733.GI607@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210815132733.GI607@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Aug 15, 2021 at 03:27:33PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Sat, Aug 14, 2021 at 10:53:14PM +0200, Florian Westphal wrote:
> > > Indeed.  Since this removes the base chain, it implicitly reverts
> > > a DROP policy too.
> > 
> > User still has to iptables -F on that given chain before deleting,
> > right?
> 
> Yes, -X fails if the chain has rules.
> 
> > If NLM_F_NONREC is used, the EBUSY is reported when trying to delete
> > a chain with rules.
> 
> Yes.

But we really do not need NLM_F_NONREC for this new feature, right? I
mean, a quick shortcut to remove the basechain and its content should
be fine.

> > My assumption is that the user will perform:
> > 
> > iptables-nft -F -t filter
> > iptables-nft -D -t filter
> 
> Yes, assuminy you meant -X instead of -D.

Oh well, embarrasing, yes.

> This behaves just like before, it deletes all rules (-F) and all user-defined
> chains (-X).
>
> > I mean, by when the user has an empty basechain with default policy to
> > DROP, if they remove the chain, then they are really meaning to remove
> > the chain and this default policy to DROP.
> 
> ATM iptables -X $BUILTIN will always fail.
> In -legecy there is no kernel API to allow for its removal,
> for -nft there is an extra check that throws an error.
> 
> > Or am I missing anything else?
> 
> No, I don't think so.  I would prefer if
> iptables-nft -F -t filter
> iptables-nft -X -t filter
> 
> ... would result in an empty "filter" table.

Your concern is that this would change the default behaviour?

> I could also add a patch that requests removal
> of the table as well for the -X case; but unlike base chain the
> presence of the table alone has no impact on dataplane.

Then, probably add a new command for this?

iptables-nft -K INPUT -t filter => to remove the INPUT/filter basechain.

Then:

iptables-nft -N INPUT -t filter

to bring it back (if it was removed).
