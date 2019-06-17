Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1330D48828
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 18:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfFQQAc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 12:00:32 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:33416 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQQAc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:00:32 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hcu3a-0001fq-CA; Mon, 17 Jun 2019 18:00:30 +0200
Date:   Mon, 17 Jun 2019 18:00:30 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft 2/5] tests: shell: cannot use handle for non-existing
 rule in kernel
Message-ID: <20190617160030.GS31548@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de
References: <20190617122518.10486-1-pablo@netfilter.org>
 <20190617122518.10486-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617122518.10486-2-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Mon, Jun 17, 2019 at 02:25:15PM +0200, Pablo Neira Ayuso wrote:
> This test invokes the 'replace rule ... handle 2' command. However,
> there are no rules in the kernel, therefore it always fails.

This guesses the previously inserted rule's handle. Does this start
failing with your flags conversion in place? My initial implementation
of intra-transaction rule references made this handle guessing
impossible, but your single point cache fetching still allowed for it
(hence why I dropped my patch with a similar change).

Cheers, Phil
