Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8AB123B48
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 01:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLRADT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Dec 2019 19:03:19 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:33526 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbfLRADT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:03:19 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ihMo7-0003Wp-9q; Wed, 18 Dec 2019 01:03:15 +0100
Date:   Wed, 18 Dec 2019 01:03:15 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        =?iso-8859-15?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>
Subject: Re: [nf PATCH] netfilter: nft_tproxy: Fix port selector on Big Endian
Message-ID: <20191218000315.GY795@breakpoint.cc>
References: <20191217235929.32555-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217235929.32555-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> On Big Endian architectures, u16 port value was extracted from the wrong
> parts of u32 sreg_port, just like commit 10596608c4d62 ("netfilter:
> nf_tables: fix mismatch in big-endian system") describes.

I was about to debug this today, thanks for debugging/fixing this.

Acked-by: Florian Westphal <fw@strlen.de>
