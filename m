Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1C14BCB5E
	for <lists+netfilter-devel@lfdr.de>; Sun, 20 Feb 2022 01:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243043AbiBTAin (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 19 Feb 2022 19:38:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242187AbiBTAin (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 19 Feb 2022 19:38:43 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81F6356211
        for <netfilter-devel@vger.kernel.org>; Sat, 19 Feb 2022 16:38:23 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8106560212;
        Sun, 20 Feb 2022 01:37:32 +0100 (CET)
Date:   Sun, 20 Feb 2022 01:38:19 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 03/26] scanner: Some time units are only used in
 limit scope
Message-ID: <YhGNe9XT8rgZReKf@salvia>
References: <20220219132814.30823-1-phil@nwl.cc>
 <20220219132814.30823-4-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220219132814.30823-4-phil@nwl.cc>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Feb 19, 2022 at 02:27:51PM +0100, Phil Sutter wrote:
> 'hour' and 'day' are allowed as unqualified meta expressions, so leave
> them alone.

Are you use? I can see time_type is by 'ct expiration'.

> Fixes: eae2525685252 ("scanner: limit: move to own scope")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  src/scanner.l | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/src/scanner.l b/src/scanner.l
> index ce78fcd6fa995..eaf5460870a09 100644
> --- a/src/scanner.l
> +++ b/src/scanner.l
> @@ -385,6 +385,11 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
>  <SCANSTATE_LIMIT>{
>  	"rate"			{ return RATE; }
>  	"burst"			{ return BURST; }
> +
> +	/* time_unit */
> +	"second"		{ return SECOND; }
> +	"minute"		{ return MINUTE; }
> +	"week"			{ return WEEK; }
>  }
>  <SCANSTATE_CT,SCANSTATE_LIMIT,SCANSTATE_QUOTA>"over"		{ return OVER; }
>  
> @@ -394,11 +399,8 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
>  	"until"		{ return UNTIL; }
>  }
>  
> -"second"		{ return SECOND; }
> -"minute"		{ return MINUTE; }
>  "hour"			{ return HOUR; }
>  "day"			{ return DAY; }
> -"week"			{ return WEEK; }
>  
>  "reject"		{ return _REJECT; }
>  "with"			{ return WITH; }
> -- 
> 2.34.1
> 
