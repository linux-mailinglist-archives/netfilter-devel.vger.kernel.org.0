Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BADF7696B5
	for <lists+netfilter-devel@lfdr.de>; Mon, 31 Jul 2023 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjGaMrX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Jul 2023 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGaMrF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:47:05 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E49E1997
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Jul 2023 05:46:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qQSIH-0005VR-AD; Mon, 31 Jul 2023 14:46:37 +0200
Date:   Mon, 31 Jul 2023 14:46:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: nftables: syntax ambiguity with objref map and ct helper objects
Message-ID: <20230731124637.GA7056@breakpoint.cc>
References: <20230728195614.GA18109@breakpoint.cc>
 <ZMenriLfu+luvh9i@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMenriLfu+luvh9i@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Hi Florian,
> 
> On Fri, Jul 28, 2023 at 09:56:14PM +0200, Florian Westphal wrote:
> > Hi,
> > 
> > I wanted to allow creating objref maps that
> > return "ct timeout" or "ct helper" templates.
> > 
> > However:
> >   map .. {
> >     type ipv4_addr : ct timeout
> > 
> >   The above is fine, but this is not:
> > 
> >   map .. {
> >     type ipv4_addr : ct helper
> 
> This is type, not typeof, is it intentional?

Yes, but doesn't matter for this problem.
Same ambiguity with

typeof ip saddr : ct helper

> This works fine with typeof:
> 
> table ip x {
>         map x {
>                 typeof ip saddr : ct helper
>         }
> }

My point is how nft should differentiate between

ct helper "bla" {

rule add ct helper "foo"

In above map declaration.  What does

"typeof ip saddr : ct helper" declare?
As far as I can see its arbitrary 16-byte strings, so the
above doesn't delcare an objref map that maps ip addresses
to conntrack helper templates.
