Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0F2123B81
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 01:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfLRAYr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Dec 2019 19:24:47 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:33688 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfLRAYr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:24:47 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1ihN8u-00034U-Gp; Wed, 18 Dec 2019 01:24:44 +0100
Date:   Wed, 18 Dec 2019 01:24:44 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
Subject: Re: [nf PATCH] netfilter: nft_tproxy: Fix port selector on Big Endian
Message-ID: <20191218002444.GA20229@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
References: <20191217235929.32555-1-phil@nwl.cc>
 <20191218000315.GY795@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218000315.GY795@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Dec 18, 2019 at 01:03:15AM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > On Big Endian architectures, u16 port value was extracted from the wrong
> > parts of u32 sreg_port, just like commit 10596608c4d62 ("netfilter:
> > nf_tables: fix mismatch in big-endian system") describes.
> 
> I was about to debug this today, thanks for debugging/fixing this.

With that BE machine at hand, I quickly gave nftables testsuite a try -
results are a bit concerning: The mere fact that netlink debug output
for these immediates differs between BE and LE indicates we don't
seriously test on BE.

Cheers, Phil
