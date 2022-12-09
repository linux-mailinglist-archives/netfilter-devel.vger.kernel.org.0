Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6F648962
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Dec 2022 21:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLIUKJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Dec 2022 15:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLIUKI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:10:08 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 011D475BC8
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Dec 2022 12:10:07 -0800 (PST)
Date:   Fri, 9 Dec 2022 21:10:04 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [nft PATCH 3/4] xt: Rewrite unsupported compat expression dumping
Message-ID: <Y5OWHIdRHQwNhZ+v@salvia>
References: <20221124165641.26921-1-phil@nwl.cc>
 <20221124165641.26921-4-phil@nwl.cc>
 <Y5NdNmKQrlRAKRfm@salvia>
 <Y5NmPEyyWFMe6q8P@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5NmPEyyWFMe6q8P@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Dec 09, 2022 at 05:45:48PM +0100, Phil Sutter wrote:
> On Fri, Dec 09, 2022 at 05:07:18PM +0100, Pablo Neira Ayuso wrote:
> > On Thu, Nov 24, 2022 at 05:56:40PM +0100, Phil Sutter wrote:
> > > Choose a format which provides more information and is easily parseable.
> > > Then teach parsers about it and make it explicitly reject the ruleset
> > > giving a meaningful explanation. Also update the man pages with some
> > > more details.
> > 
> > There is a bugzilla ticket related to xt and json support, you can
> > probably add a Closes: tag link.
> 
> This should be nfbz#1621, but it's about translating xt to native in
> JSON format. All my patch does is extend the xt JSON format a bit. AIUI,
> we would have to extend libxtables to provide translations into JSON.
> 
> So even with perfect two-ways translation available, JSON interface is
> unusable if iptables-nft is in use.

The output of nftables without translation cannot be restored either,
this is also going to provide a hint to the user, without allowing it
to restore the JSON file.
