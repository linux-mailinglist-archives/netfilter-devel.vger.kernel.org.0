Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C317E23BBAC
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Aug 2020 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgHDOFC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Aug 2020 10:05:02 -0400
Received: from correo.us.es ([193.147.175.20]:38986 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbgHDOFB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:05:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 45115FB369
        for <netfilter-devel@vger.kernel.org>; Tue,  4 Aug 2020 16:05:00 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 36C21DA7B6
        for <netfilter-devel@vger.kernel.org>; Tue,  4 Aug 2020 16:05:00 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2C38ADA796; Tue,  4 Aug 2020 16:05:00 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EB6F4DA789;
        Tue,  4 Aug 2020 16:04:57 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 04 Aug 2020 16:04:57 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [213.143.49.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 788C24265A2F;
        Tue,  4 Aug 2020 16:04:57 +0200 (CEST)
Date:   Tue, 4 Aug 2020 16:04:54 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Jose M. Guisado" <guigom@riseup.net>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        erig@erig.me
Subject: Re: [PATCH nft v4] src: enable json echo output when reading native
 syntax
Message-ID: <20200804140454.GA6002@salvia>
References: <20200731104944.21384-1-guigom@riseup.net>
 <20200804103846.58872-1-guigom@riseup.net>
 <20200804123744.GV13697@orbyte.nwl.cc>
 <87971ac3-ed9c-9923-ca3f-df6dfb8b94d9@riseup.net>
 <20200804131423.GW13697@orbyte.nwl.cc>
 <6bf33b55-6439-0ae5-9dbf-e18c01969d42@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bf33b55-6439-0ae5-9dbf-e18c01969d42@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 04, 2020 at 03:44:25PM +0200, Jose M. Guisado wrote:
> Hi Phil.
> 
> On 4/8/20 15:14, Phil Sutter wrote:
> > Hi,
> > 
> > On Tue, Aug 04, 2020 at 03:05:25PM +0200, Jose M. Guisado wrote:
> > > On 4/8/20 14:37, Phil Sutter wrote:
> > > > Why not just:
> > > > 
> > > > --- a/src/monitor.c
> > > > +++ b/src/monitor.c
> > > > @@ -922,8 +922,11 @@ int netlink_echo_callback(const struct nlmsghdr *nlh, void *data)
> > > >           if (!nft_output_echo(&echo_monh.ctx->nft->output))
> > > >                   return MNL_CB_OK;
> > > > -       if (nft_output_json(&ctx->nft->output))
> > > > -               return json_events_cb(nlh, &echo_monh);
> > > > +       if (nft_output_json(&ctx->nft->output)) {
> > > > +               if (ctx->nft->json_root)
> > > > +                       return json_events_cb(nlh, &echo_monh);
> > > > +               echo_monh.format = NFTNL_OUTPUT_JSON;
> > > > +       }
> > > >           return netlink_events_cb(nlh, &echo_monh);
> > > >    }
> > > > 
> > > > At a first glance, this seems to work just fine.
> > > > 
> > > > Cheers, Phil
> > > 
> > > This does not output anything on my machine. This is because json_echo
> > > is not initialized before netlink_echo_callback.
> > 
> > Please try my diff above on upstream's master without your changes. In
> > the tree I did above changes, no symbol named 'json_echo' exists.
> > 
> > Cheers, Phil
> 
> Just tested it, it works great on my machine. As it outputs the same that
> would a running nft monitor.
> 
> I'm imagining this is preferred if there's no need having the json commands
> in the output be wrapped inside list of a single json object with its
> metainfo. That's the main difference with your patch.

If it's not wrapped by the top-level nftables root then this is
unparseable.

I think your changes for the monitor are still needed, and we'll
consolidate this code sooner or later once the JSON API is fixed.

Thanks.
