Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626CA1728E7
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Feb 2020 20:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgB0Tnu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Feb 2020 14:43:50 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43874 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729611AbgB0Tnu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:43:50 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1j7P4W-00070m-T3; Thu, 27 Feb 2020 20:43:49 +0100
Date:   Thu, 27 Feb 2020 20:43:48 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>,
        Phil Sutter <phil@nwl.cc>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Ipv6 address in concatenation
Message-ID: <20200227194348.GQ19559@breakpoint.cc>
References: <54A7EDF2-F83D-44D7-994C-2C8E35E586AD@cisco.com>
 <20200227194229.GP19559@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227194229.GP19559@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> Serguei Bezverkhi (sbezverk) <sbezverk@cisco.com> wrote:
> > Hello,
> > 
> > I started testing  nfproxy in ipv6 enabled kubernetes cluster and it seems ipv6 address cannot be a part of concatenation expression. Is there a known issue or it is me doing something incorrect?
> > From my side the code is the same, I just change ip4_addr to ip6_addr when I build sets.
> 
> types are irrelvant for the kernel.  They are ONLY used by the nft tool
> so it knows how to format output.
> 
> I suspect you need to fix up the generated payload expressions
> for ipv6.  Essentially, in the ipv6 case, you have a concatenation
> 
> ipv4_addr . ipv4_addr . ip4_addr . ipv4_addr . inet_service
> 
> (ipv6 address needs 4 32-bit registers)
> 
> i.e., you need to use a different destination register when you store
> the tcp/udp port, else you will clobber a part of the ipv6 address.

Addendum: you can check with

nft --debug=netlink list ruleset

to make sure the registers get populated as expected by lookup
expression.
