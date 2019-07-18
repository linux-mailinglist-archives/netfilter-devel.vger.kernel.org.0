Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A27D56CBC4
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jul 2019 11:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbfGRJVb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Jul 2019 05:21:31 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:38870 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727731AbfGRJVa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:21:30 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1ho2bQ-0001UI-GG; Thu, 18 Jul 2019 11:21:28 +0200
Date:   Thu, 18 Jul 2019 11:21:28 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: userspace conntrack helper and confirming the master conntrack
Message-ID: <20190718092128.zbw4qappq6jsb4ja@breakpoint.cc>
References: <20190718084943.GE24551@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718084943.GE24551@unicorn.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Michal Kubecek <mkubecek@suse.cz> wrote:
> Hello,
> 
> to clean up some skeletons in the closet of our distribution kernels,
> I'm trying to add a userspace conntrack helper for SLP into conntrackd.
> 
> A helper is needed to handle SLP queries which are sent as multicast UDP
> packets but replied to with unicast packets so that reply's source
> address does not much request's destination. This is exactly the same
> problem as for mDNS so that I started by copying existing mdns helper in
> conntrackd and changing the default timeout. But I found that it does
> not work with 5.2 kernel.
> 
> The setup looks like this (omitting some log rules):
> 
>   nfct helper add slp inet udp
>   iptables -t raw -A OUTPUT -m addrtype --dst-type MULTICAST \
>       -p udp --dport 427 -j CT --helper slp
>   iptables -t raw -A OUTPUT -m addrtype --dst-type BROADCAST
>       -p udp --dport 427 -j CT --helper slp
>   iptables -A INPUT -i lo -j ACCEPT
>   iptables -A INPUT -p tcp --dport 22 -j ACCEPT
>   iptables -A INPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT
>   iptables -A INPUT -m conntrack --ctstate RELATED -j ACCEPT
>   iptables -P INPUT DROP
>   iptables -P OUTPUT ACCEPT
> 
> The helper rules apply, outgoing multicast packet is sent away but the
> unicast reply is not recognized as related and rejected. Monitring with
> "conntrack -E expect" shows that an expectation is created but it is
> immediately destroyed and "conntrack -E" does not show the conntrack for
> the original multicast packet (which is created when I omit the helper
> rules in raw table). Kernel side tracing confirms that the conntrack is
> never confirmed and inserted into the hash table so that the expectation
> is destroyed once the request packet is sent out (and skb_consume()-ed).
> 
> I added some more tracing and this is what seems to happen:
> 
>   - ipv4_confirm() is called for the conntrack from ip_output() via hook
>   - nf_confirm() calls attached helper and calls its help() function
>     which is nfnl_userspace_cthelper(), that returns 0x78003
>   - nf_confirm() returns that without calling nf_confirm_conntrack()
>   - verdict 0x78003 is returned to nf_hook_slow() which therefore calls
>     nf_queue() to pass this to userspace helper on queue 7
>   - nf_queue() returns 0 which is also returned by nf_hook_slow()
>   - the packet reappears in nf_reinject() where it passes through
>     nf_reroute() and nf_iterate() to the main switch statement
>   - it takes NF_ACCEPT branch to call okfn which is ip_finish_output()
>   - unless I missed something, there is nothing that could confirm the
>     conntrack after that

I broke this with
commit 827318feb69cb07ed58bb9b9dd6c2eaa81a116ad
("netfilter: conntrack: remove helper hook again").

Seems we have to revert, i see no other solution at this time.
