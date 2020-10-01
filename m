Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8A2809FA
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Oct 2020 00:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgJAWZm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Oct 2020 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgJAWZl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:25:41 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACC0C0613D0
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Oct 2020 15:25:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kO716-0001pX-Nv; Fri, 02 Oct 2020 00:25:37 +0200
Date:   Fri, 2 Oct 2020 00:25:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [net-next PATCH 0/2] netfilter: Improve inverted IP prefix
 matches
Message-ID: <20201001222536.GB12773@breakpoint.cc>
References: <20201001165744.25466-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001165744.25466-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> The following two patches improve packet throughput in a test setup
> sending UDP packets (using iperf3) between two netns. The ruleset used
> on receiver side is like this:
> 
> | *filter
> | :test - [0:0]
> | -A INPUT -j test
> | -A INPUT -j ACCEPT
> | -A test ! -s 10.0.0.0/10 -j DROP # this line repeats 10000 times
> | COMMIT
> 
> These are the generated VM instructions for each rule:
> 
> | [ payload load 4b @ network header + 12 => reg 1 ]
> | [ bitwise reg 1 = (reg=1 & 0x0000c0ff ) ^ 0x00000000 ]

Not related to this patch, but we should avoid the bitop if the
netmask is divisble by 8 (can adjust the cmp -- adjusting the
payload expr is probably not worth it).

> | [ cmp eq reg 1 0x0000000a ]
> | [ counter pkts 0 bytes 0 ]

Out of curiosity, does omitting 'counter' help?

nft counter is rather expensive due to bh disable,
iptables does it once at the evaluation loop only.
