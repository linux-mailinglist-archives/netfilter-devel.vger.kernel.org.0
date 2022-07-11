Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CEA560745
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Jun 2022 19:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiF2RUZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 29 Jun 2022 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiF2RUZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:20:25 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0FD53D4B4
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Jun 2022 10:20:23 -0700 (PDT)
Date:   Wed, 29 Jun 2022 19:20:20 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables] Allow resetting the include search path
Message-ID: <YryJ1NXNy5zZb5r+@salvia>
References: <Yrs2nn/amfnaUDk8@salvia>
 <Yrs3kkbc4z5AMF+W@salvia>
 <20220628190101.76cmatthftrsxbja@House>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628190101.76cmatthftrsxbja@House>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:01:01PM +0200, Daniel Gröber wrote:
> Hi Pablo,
> 
> On Tue, Jun 28, 2022 at 07:13:02PM +0200, Pablo Neira Ayuso wrote:
> > You can do
> > 
> > # cat x.nft
> > include "./z.nft"
> > # cat z.nft
> > add table x
> > 
> > then:
> > 
> > # nft -f x.nft
> > 
> > using ./ at the beginning of the path overrides DEFAULT_INCLUDE_PATH.
> > 
> > Is this what you are searching for?
> 
> While that could work its rather a hassle. On my (Debian) system
> nftables.service runs in the root directory so I'd have to do ugly stuff
> like `include "./etc/nftables/foo.conf"` which I'd rather not. For one the
> config would then depend on where `nft -f ...` is run exactly which sucks.

Hm, that's one way to put it, yes.

> I think my patch is a much cleaner and general solution.

I might be missing anything, could you describe your use-case?

You also consider that using absolute path in includes is suboptimal?
