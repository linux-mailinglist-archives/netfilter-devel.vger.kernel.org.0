Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D74769AD7
	for <lists+netfilter-devel@lfdr.de>; Mon, 31 Jul 2023 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGaPcT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Jul 2023 11:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGaPcP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:32:15 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131111706
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Jul 2023 08:32:14 -0700 (PDT)
Received: from [46.222.105.127] (port=12914 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qQUsT-001BBs-7B; Mon, 31 Jul 2023 17:32:11 +0200
Date:   Mon, 31 Jul 2023 17:32:07 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: nftables: syntax ambiguity with objref map and ct helper objects
Message-ID: <ZMfT97SbKBov4UzD@calendula>
References: <20230728195614.GA18109@breakpoint.cc>
 <ZMenriLfu+luvh9i@calendula>
 <20230731124637.GA7056@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731124637.GA7056@breakpoint.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 31, 2023 at 02:46:37PM +0200, Florian Westphal wrote:
[...]
> My point is how nft should differentiate between
> 
> ct helper "bla" {
> 
> rule add ct helper "foo"
> 
> In above map declaration.  What does
> 
> "typeof ip saddr : ct helper" declare?
> As far as I can see its arbitrary 16-byte strings, so the
> above doesn't delcare an objref map that maps ip addresses
> to conntrack helper templates.

Oh, indeed. Selector semantics are overloaded, I proposed kernel
patches that have remained behind:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210309210134.13620-2-pablo@netfilter.org/
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210309210134.13620-3-pablo@netfilter.org/

I also proposed change to have two selectors, one for the helper type
and another for the user-defined helper name. I still have to update
libnftnl and nftables.

I don't think this is specifically related to the map definition
itself, but the fact that the selector semantics is ambiguous.
