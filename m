Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD618C158
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Aug 2019 21:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfHMTPX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Aug 2019 15:15:23 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:57402 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfHMTPX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:15:23 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hxcGP-0003sh-FQ; Tue, 13 Aug 2019 21:15:21 +0200
Date:   Tue, 13 Aug 2019 21:15:21 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Ander Juaristi <a@juaristi.eus>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] netfilter: nft_meta: support for time matching
Message-ID: <20190813191521.k3smpru2sf2rvewf@breakpoint.cc>
References: <20190813183820.6659-1-a@juaristi.eus>
 <20190813183820.6659-2-a@juaristi.eus>
 <20190813191406.lhsz3y4bbmuzixxi@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813191406.lhsz3y4bbmuzixxi@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> Ander Juaristi <a@juaristi.eus> wrote:
> > +++ b/net/netfilter/nft_meta.c
> > @@ -28,6 +28,27 @@
> >  
> >  static DEFINE_PER_CPU(struct rnd_state, nft_prandom_state);
> >  
> > +static u8 nft_meta_weekday(unsigned long secs)
> > +{
> > +	u8 wday;
> > +	unsigned int dse;
> > +
> > +	secs -= 60 * sys_tz.tz_minuteswest;
> > +	dse = secs / 86400;
> 
> This will probably fail to compile (link) on 32bit arches.
> You need to use do_div() here.

Scratch that, this will work fine (unsigned long is not a 64 bit
type in that case).
