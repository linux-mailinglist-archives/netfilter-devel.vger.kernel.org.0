Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B411D139DA9
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jan 2020 00:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgAMXxN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Jan 2020 18:53:13 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46968 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728802AbgAMXxN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:53:13 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ir9W9-00011t-FS; Tue, 14 Jan 2020 00:53:09 +0100
Date:   Tue, 14 Jan 2020 00:53:09 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [RFC nf-next 0/4] netfilter: conntrack: allow insertion of
 clashing entries
Message-ID: <20200113235309.GM795@breakpoint.cc>
References: <20200108134500.31727-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108134500.31727-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> This entire series isn't nice but so far I did not find a better
> solution.

I did consider getting rid of the unconfirmed list, but this is also
problematic.

At allocation time we do not know what kind of NAT transformations
will be applied by the ruleset, i.e. we'd need another locking step to
move the entries to the right location in the hash table.

Same if the skb is dropped: we need to lock the conntrack table again to
delete the newly added entry -- this isn't needed right now because the
conntrack is only on the percpu unconfirmed list in this case.

This is also a problem because of conntrack events, we would have to
seperate insertion and notification, else we'd flood userspace for every
conntrack we create in case of a packet drop flood.

Other solutions are:
1. use a ruleset that assigns the same nat mapping for both A and AAAA
   requests, or,
2. steer all packets that might have this problem (i.e. udp dport 53) to
    the same cpu core.

Yet another solution would be a variation of this patch set:

1. Only add the reply direction to the table (i.e. conntrack -L won't show
   the duplicated entry).
2. Add a new conntrack flag for the duplicate that guarantees the
   conntrack is removed immediately when first reply packet comes in.
   This would also have the effect that the conntrack can never be
   assured, i.e. the "hidden duplicates" are always early-dropable if
   conntrack table gets full.
3. change event code to never report such duplicates to userspace.
