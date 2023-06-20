Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40AB73608A
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jun 2023 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjFTAOB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Jun 2023 20:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjFTAOA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:14:00 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC7E53
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Jun 2023 17:13:56 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qBP0M-0004iF-90; Tue, 20 Jun 2023 02:13:54 +0200
Date:   Tue, 20 Jun 2023 02:13:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] cache: include set elements in "nft set list"
Message-ID: <20230620001354.GA13423@breakpoint.cc>
References: <20230618163951.408565-1-fw@strlen.de>
 <ZJAXOt+gyRssyayb@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJAXOt+gyRssyayb@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Sun, Jun 18, 2023 at 06:39:45PM +0200, Florian Westphal wrote:
> > Make "nft list sets" include set elements in listing by default.
> > In nftables 1.0.0, "nft list sets" did not include the set elements,
> > but with "--json" they were included.
> > 
> > 1.0.1 and newer never include them.
> > This causes a problem for people updating from 1.0.0 and relying
> > on the presence of the set elements.
> > 
> > Change nftables to always include the set elements.
> > The "--terse" option is honored to get the "no elements" behaviour.

I pushed this patch to master, with a minor change (removal of no-longer
needed fmt struct).
