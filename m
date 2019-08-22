Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3499627
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Aug 2019 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfHVOQs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 22 Aug 2019 10:16:48 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46990 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387673AbfHVOQr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:16:47 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i0ntN-00049I-5Q; Thu, 22 Aug 2019 16:16:45 +0200
Date:   Thu, 22 Aug 2019 16:16:45 +0200
From:   Florian Westphal <fw@strlen.de>
To:     "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>
Cc:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: nft equivalent of iptables command
Message-ID: <20190822141645.GH20113@breakpoint.cc>
References: <69AAC254-AF78-4918-82B5-14B3EDB10EDB@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69AAC254-AF78-4918-82B5-14B3EDB10EDB@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Serguei Bezverkhi (sbezverk) <sbezverk@cisco.com> wrote:
> Hello,
> 
> I am trying to find an equivalent nft command for the following iptables command.  Specifically "physdev" and "addrtype", I could not find so far, some help would be very appreciated.

> -m physdev ! --physdev-is-in            

This has no equivalent.  The rule above matches when 'call-iptables' sysctl
is enabled and the packet did not enter via a bridge interface.
So, its only false when it did enter via a bridge interface.

In case the sysctl is off, the rule always matches and can be omitted.

nftables currently assumes that call-iptables is off, and that
bridges have their own filter rules in the netdev and/or
bridge families.

inet/ip/ip6 are assumed to only see packets that are routed by the ip
stack.

> -m addrtype ! --src-type LOCAL 

fib saddr type != local
