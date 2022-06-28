Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE27055ED7D
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jun 2022 21:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiF1TEU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jun 2022 15:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiF1TDP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:03:15 -0400
Received: from janet.servers.dxld.at (unknown [5.9.225.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988C7193DA
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jun 2022 12:01:20 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 28 Jun 2022 21:01:03 +0200
Date:   Tue, 28 Jun 2022 21:01:01 +0200
From:   Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables] Allow resetting the include search path
Message-ID: <20220628190101.76cmatthftrsxbja@House>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yrs2nn/amfnaUDk8@salvia>
 <Yrs3kkbc4z5AMF+W@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Tue, Jun 28, 2022 at 07:13:02PM +0200, Pablo Neira Ayuso wrote:
> You can do
> 
> # cat x.nft
> include "./z.nft"
> # cat z.nft
> add table x
> 
> then:
> 
> # nft -f x.nft
> 
> using ./ at the beginning of the path overrides DEFAULT_INCLUDE_PATH.
> 
> Is this what you are searching for?

While that could work its rather a hassle. On my (Debian) system
nftables.service runs in the root directory so I'd have to do ugly stuff
like `include "./etc/nftables/foo.conf"` which I'd rather not. For one the
config would then depend on where `nft -f ...` is run exactly which sucks.

I think my patch is a much cleaner and general solution.

--Daniel
