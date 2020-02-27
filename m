Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417B3172A65
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Feb 2020 22:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgB0Vpl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Feb 2020 16:45:41 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:44268 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729162AbgB0Vpl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:45:41 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1j7QyQ-0007cl-U2; Thu, 27 Feb 2020 22:45:38 +0100
Date:   Thu, 27 Feb 2020 22:45:38 +0100
From:   Florian Westphal <fw@strlen.de>
To:     "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>
Cc:     Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Ipv6 address in concatenation
Message-ID: <20200227214538.GR19559@breakpoint.cc>
References: <54A7EDF2-F83D-44D7-994C-2C8E35E586AD@cisco.com>
 <20200227194229.GP19559@breakpoint.cc>
 <C3A34108-BD5F-41CB-835B-277494505E85@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <C3A34108-BD5F-41CB-835B-277494505E85@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Serguei Bezverkhi (sbezverk) <sbezverk@cisco.com> wrote:
> Ok, I figured out the map issue, it was a length of the key in bits, damn copy/paste (
> 
> Appreciate if somebody could comment about the following:
> 
> sudo nft --debug=netlink insert rule ip6 kube-nfproxy-v6 k8s-nat-services ip6 nexthdr . ip6 daddr . th dport vmap @cluster-ip-set
> ip6 kube-nfproxy-v6 k8s-nat-services 
>   [ payload load 1b @ network header + 6 => reg 1 ]
>   [ payload load 16b @ network header + 24 => reg 9 ].       < -- Is it loading reg 9 4-bytes, reg 10 4 bytes etc until reg 12? Or because the data 16 bytes long it has to skip 3 more register?
>   [ payload load 2b @ transport header + 2 => reg 13 ]

The 'registers' are adjacent in memory, so loading 16 bytes to reg9
will also store data to 10, 11 and 12.

In case there are not enough next registers kernel will reject the
transaction.

>   [ lookup reg 1 set cluster-ip-set dreg 0 ]
> 
> I am just trying to figure out how to calculate next register to use.    If there is algorithm for both ipv4 and ipv6 that would be awesome to know.

See netlink_gen_concat() in src/netlink_linearize.c in nftables.

Its basically enough to take the start register and then add the
length, rounded up to 4 (register is always 4 byte).

So for the above you need 1 + 1 * 4 + 1, i.e. 6 registers,
then pass the first/start register to the lookup expression.

The lookup expression takes the number of 'next registers' it
needs to look at from the set key length.

