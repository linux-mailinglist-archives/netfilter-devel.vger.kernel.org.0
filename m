Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E6B4E64E0
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Mar 2022 15:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiCXORs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Mar 2022 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiCXORr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:17:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE840AC05E
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Mar 2022 07:16:15 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nXOG6-00076m-Bw; Thu, 24 Mar 2022 15:16:14 +0100
Date:   Thu, 24 Mar 2022 15:16:14 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH 2/2] netfilter: nf_log_syslog: Don't ignore
 unknown protocols
Message-ID: <20220324141614.GC24666@breakpoint.cc>
References: <20220324140341.24259-1-phil@nwl.cc>
 <20220324140341.24259-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324140341.24259-2-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> With netdev and bridge nfprotos, loggers may see arbitrary ethernet
> frames. Print at least basic info like interfaces and MAC header data.

Makes sense to me.

> +	/* FIXME: Disabled from containers until syslog ns is supported */
> +	if (!net_eq(net, &init_net) && !sysctl_nf_log_all_netns)
> +		return;

Hmm, this is now the 3rd incarnation of this comment + check,
perhaps create another patch that adds a helper?

E.g.

if (!nf_log_allowed(net))
	return;

or similar.  Or just remove the FIXME line?  (Its not really a netfilter
todo/FIXME).
