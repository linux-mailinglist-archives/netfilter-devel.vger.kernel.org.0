Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D48115BFA
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Dec 2019 12:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfLGLQr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 Dec 2019 06:16:47 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34374 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbfLGLQr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 Dec 2019 06:16:47 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1idY4r-0002HP-L6; Sat, 07 Dec 2019 12:16:45 +0100
Date:   Sat, 7 Dec 2019 12:16:45 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: Documentation question (verdicts)
Message-ID: <20191207111645.GB795@breakpoint.cc>
References: <20191202102623.GA775@dimstar.local.net>
 <20191207012843.GA22674@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207012843.GA22674@dimstar.local.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Duncan Roe <duncan_roe@optusnet.com.au> wrote:
> Hi Pablo,
> 
> On Mon, Dec 02, 2019 at 09:26:23PM +1100, Duncan Roe wrote:
> > Hi Pablo,
> >
> > Queue handling [DEPRECATED] in libnetfilter_queue.c documents these 3:
> >
> > > 278  *   - NF_ACCEPT the packet passes, continue iterations
> > > 281  *   - NF_REPEAT iterate the same cycle once more
> > > 282  *   - NF_STOP accept, but don't continue iterations
> >
> > In my tests, NF_REPEAT works as documented - the input hook presents the packet
> > a second time. But, contrary to the above, the packet does not show again
> > after NF_ACCEPT.
> >
> > Is that expected behaviour nowadays?
> >
> > And if so, does that make NF_STOP redundant?
> >
> > BTW if you'd like to try it, my test program nfq6 is a subdirectory at
> > https://github.com/duncan-roe/nfq (nfq itself is an ad blocker).
> >
> > Cheers ... Duncan.
> 
> Specifically I need to know whether to document NF_STOP as obsolete (same as
> NF_ACCEPT).

They are not the same.  STOP calls the okfn directly so packet will be
done with the hook location.  NF_ACCEPT moves on to the next hook.

table ip raw {
        chain p1 {
                type filter hook prerouting priority -1000; policy accept;
                ip protocol icmp queue num 0 bypass
        }

        chain p2 {
                type filter hook prerouting priority filter; policy accept;
                ip protocol icmp meta mark 0x0000002a counter
        }
}

If nfqueue tool sets mark 42 and ACCEPT, the counter will increment.
If it uses STOP, the prerouting hook processing ends immediately
and the packet will continue stack traversal, all further prerouting
base chains are skipped.

It will eventually appear in forward or input.
