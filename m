Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4E4F47BF
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Apr 2022 01:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiDEVU2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Apr 2022 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384142AbiDEPOx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:14:53 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309C7A7750
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Apr 2022 06:28:54 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nbjEq-0003xu-Bp; Tue, 05 Apr 2022 15:28:52 +0200
Date:   Tue, 5 Apr 2022 15:28:52 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] meta time: use uint64_t instead of time_t
Message-ID: <YkxEFBVsHnC738pA@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Lukas Straub <lukasstraub2@web.de>, netfilter-devel@vger.kernel.org
References: <20220405101016.855221490@web.de>
 <20220405101026.867817071@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405101026.867817071@web.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:41:14AM +0000, Lukas Straub wrote:
> time_t may be 32 bit on some platforms and thus can't fit a timestamp
> with nanoseconds resolution. This causes overflows and ultimatively
> breaks meta time expressions on such platforms.
> 
> Fix this by using uint64_t instead.
> 
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1567
> Fixes: f8f32deda31df597614d9f1f64ffb0c0320f4d54 
> ("meta: Introduce new conditions 'time', 'day' and 'hour'")
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> 
> Index: b/src/meta.c
> ===================================================================
> --- a/src/meta.c
> +++ b/src/meta.c
> @@ -444,7 +444,7 @@ static struct error_record *date_type_pa
>  					    struct expr **res)
>  {
>  	const char *endptr = sym->identifier;
> -	time_t tstamp;
> +	uint64_t tstamp;
>  
>  	if ((tstamp = parse_iso_date(sym->identifier)) != -1)

Doesn't this introduce a warning due to signed/unsigned comparison?

I guess you'll have to cast -1 to uint64_t as well.

Cheers, Phil
