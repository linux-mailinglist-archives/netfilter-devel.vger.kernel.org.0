Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80327355056
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Apr 2021 11:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhDFJun (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Apr 2021 05:50:43 -0400
Received: from mail.netfilter.org ([217.70.188.207]:33782 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbhDFJun (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:50:43 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 3ECDA63E3F;
        Tue,  6 Apr 2021 11:50:15 +0200 (CEST)
Date:   Tue, 6 Apr 2021 11:50:31 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Firo Yang <firo.yang@suse.com>
Cc:     netfilter-devel@vger.kernel.org, simonf.lees@suse.com
Subject: Re: [PATCH 1/2] ebtables: processing '--concurrent' beofore other
 arguments
Message-ID: <20210406095031.GA15256@salvia>
References: <20210401040741.15672-1-firo.yang@suse.com>
 <20210401040741.15672-2-firo.yang@suse.com>
 <20210403181517.GA4624@salvia>
 <20210403182204.GA5182@salvia>
 <20210406025737.2jws5uuqz6ozncun@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210406025737.2jws5uuqz6ozncun@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 06, 2021 at 10:57:37AM +0800, Firo Yang wrote:
> The 04/03/2021 20:22, Pablo Neira Ayuso wrote:
> > On Sat, Apr 03, 2021 at 08:15:17PM +0200, Pablo Neira Ayuso wrote:
> > > Hi,
> > >
> > > On Thu, Apr 01, 2021 at 12:07:40PM +0800, Firo Yang wrote:
> > > > Our customer reported a following issue:
> > > > If '--concurrent' was passed to ebtables command behind other arguments,
> > > > '--concurrent' will not take effect sometimes; for a simple example,
> > > > ebtables -L --concurrent. This is becuase the handling of '--concurrent'
> > > > is implemented in a passing-order-dependent way.
> > > >
> > > > So we can fix this problem by processing it before other arguments.
> > >
> > > Would you instead make a patch to spew an error if --concurrent is the
> > > first argument?
> >
> > Wrong wording:
> >
> > Would you instead make a patch to spew an error if --concurrent is
> > _not_ the first argument?
>
> Hi Pablo, I think it would make more sense if we don't introduce this
> inconvenice to users. If you insist, I would go create the patch as you
> intended.

See ebtables.c line 579.

        /* The scenario induced by this loop makes that:
         * '-t'  ,'-M' and --atomic (if specified) have to come
         * before '-A' and the like */

There are other options following this approach, please align
--concurrent with those.

Have a look at 'M' and 't' for the error that is reported.

                case 'M': /* Modprobe */
                        if (OPT_COMMANDS)
                                ebt_print_error2("Please put the -M option earlier");

Thanks.
