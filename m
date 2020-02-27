Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818101724CE
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Feb 2020 18:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgB0RRE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Feb 2020 12:17:04 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:43560 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbgB0RRE (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:17:04 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1j7MmS-0005H4-Od; Thu, 27 Feb 2020 18:17:00 +0100
Date:   Thu, 27 Feb 2020 18:17:00 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>
Cc:     Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: Ipv6 address in concatenation
Message-ID: <20200227171700.GF9532@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        "Serguei Bezverkhi (sbezverk)" <sbezverk@cisco.com>,
        Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
References: <54A7EDF2-F83D-44D7-994C-2C8E35E586AD@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54A7EDF2-F83D-44D7-994C-2C8E35E586AD@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Thu, Feb 27, 2020 at 04:21:40PM +0000, Serguei Bezverkhi (sbezverk) wrote:
> I started testing  nfproxy in ipv6 enabled kubernetes cluster and it seems ipv6 address cannot be a part of concatenation expression. Is there a known issue or it is me doing something incorrect?
> From my side the code is the same, I just change ip4_addr to ip6_addr when I build sets.
> 
>         map no-endpoints {
>                 type inet_proto . ipv6_addr . inet_service : verdict
>         }
> 
>         map do-mark-masq {
>                 type inet_proto . ipv6_addr . inet_service : verdict
>         }
> 
>         map cluster-ip {
>                 type inet_proto . ipv6_addr . inet_service : verdict
>         }

Works fine for me. Wrong table family?

Cheers, Phil
