Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E17AE07E
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Sep 2019 00:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfIIWMX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Sep 2019 18:12:23 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:40594 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388574AbfIIWMX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:12:23 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i7RtS-0002Ga-Jk; Tue, 10 Sep 2019 00:12:19 +0200
Date:   Tue, 10 Sep 2019 00:12:18 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Eric Garver <eric@garver.life>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH nftables 3/3] src: mnl: retry when we hit -ENOBUFS
Message-ID: <20190909221218.GA2066@breakpoint.cc>
References: <20190813201246.5543-1-fw@strlen.de>
 <20190813201246.5543-4-fw@strlen.de>
 <20190909211110.2dzcta4dgengb4wy@egarver.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909211110.2dzcta4dgengb4wy@egarver.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Eric Garver <eric@garver.life> wrote:
> > +			if (errno == ENOBUFS && enobuf_restarts++ < 3) {
> > +				scale *= 2;
> > +				goto restart;
> > +			}
> 
> If this restart is triggered it causes rules to be duplicated. We send
> the same batch again.

Right :-(

> I'm hitting this on x86_64. Maybe we need find a better way to estimate
> the rcvbuffer in the case of --echo. By the time we see ENOBUFS we're
> already in a bad way - events have already be lost.

Thats correct.  Pablo, I don't see a way for dynamic probing, as Eric
explains the error occurs after the fact so we cannot recover.

I will send a best-effort fix in a bit.

