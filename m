Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2944E6554
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Mar 2022 15:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350821AbiCXOgY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Mar 2022 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348570AbiCXOgX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:36:23 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6ABAE
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Mar 2022 07:34:50 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nXOY5-0003RM-0N; Thu, 24 Mar 2022 15:34:49 +0100
Date:   Thu, 24 Mar 2022 15:34:49 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH 2/2] netfilter: nf_log_syslog: Don't ignore
 unknown protocols
Message-ID: <YjyBiYbwhvUSqLJc@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20220324140341.24259-1-phil@nwl.cc>
 <20220324140341.24259-2-phil@nwl.cc>
 <20220324141614.GC24666@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324141614.GC24666@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 24, 2022 at 03:16:14PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > With netdev and bridge nfprotos, loggers may see arbitrary ethernet
> > frames. Print at least basic info like interfaces and MAC header data.
> 
> Makes sense to me.
> 
> > +	/* FIXME: Disabled from containers until syslog ns is supported */
> > +	if (!net_eq(net, &init_net) && !sysctl_nf_log_all_netns)
> > +		return;
> 
> Hmm, this is now the 3rd incarnation of this comment + check,
> perhaps create another patch that adds a helper?

Yes, I thought about that already but found it not worth it. OTOH,
copying outdated comments is a sin so I'll submit a follow-up.

Thanks, Phil
