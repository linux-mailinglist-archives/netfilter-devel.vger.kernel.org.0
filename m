Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD135C582
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jul 2019 00:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGAWKC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Jul 2019 18:10:02 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:39586 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfGAWKC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Jul 2019 18:10:02 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hi4Uo-0008K0-E6; Tue, 02 Jul 2019 00:09:58 +0200
Date:   Tue, 2 Jul 2019 00:09:58 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] nft_meta: Introduce new conditions 'time', 'day' and
 'hour'
Message-ID: <20190701220958.j544fbscpgrtplxv@breakpoint.cc>
References: <20190623160758.10925-1-a@juaristi.eus>
 <20190623225647.2s6m74t4y5pkj5pk@breakpoint.cc>
 <9e7b514c-8b00-85b7-93d0-9eea4304596e@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e7b514c-8b00-85b7-93d0-9eea4304596e@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ander Juaristi <a@juaristi.eus> wrote:
> I don't think this would make sense.
> 
> Would require statements such as "meta time 1562005920098458691". That
> is totally unfriendly to the end user.

We do not necessarily need to expose this on nft side.

e.g. user says
meta time 1562018374

and nft converts this to 1562018374000000000 internally.

Or did you mean that this might cause confusion as this
might never match at all?

In such a case, we'd have to internally rewrite
meta time 1562018374
to
meta time 1562018374-1562018375

(reg1 >= 1562018374000000000 and <= 1562018375000000000).

We could also expose/support the suffixes we support for timeouts, e.g.:
3512312s, 1000ms and so on.

> But maybe I didn't understand what you meant here. Maybe you meant to
> replace get_seconds() with ktime_get_real_ns(), and divide the result by
> 10e-9 to get seconds?

No, thats not what I meant.

I was just thinking that having ns-resolution exposed to registers
might allow to use this for e.g. sampling packet arrival time.

Its not a big deal, we can add this later when such a use case pops up
and keep seconds resolution.
