Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE86557EC4
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 17:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiFWPls (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 11:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiFWPls (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:41:48 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E66DC43ACD
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 08:41:46 -0700 (PDT)
Date:   Thu, 23 Jun 2022 17:41:43 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nft PATCH 2/2] Revert "scanner: remove saddr/daddr from initial
 state"
Message-ID: <YrSJt+C+eNDZH/cl@salvia>
References: <20220623142843.32309-1-phil@nwl.cc>
 <20220623142843.32309-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220623142843.32309-3-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 23, 2022 at 04:28:43PM +0200, Phil Sutter wrote:
> This reverts commit df4ee3171f3e3c0e85dd45d555d7d06e8c1647c5 as it
> breaks ipsec expression if preceeded by a counter statement:
> 
> | Error: syntax error, unexpected string, expecting saddr or daddr
> | add rule ip ipsec-ip4 ipsec-forw counter ipsec out ip daddr 192.168.1.2
> |                                                       ^^^^^

Please add a test covering this regression case.

Thanks

> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  src/scanner.l | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/src/scanner.l b/src/scanner.l
> index 7eb74020ef848..6d6396bbb7413 100644
> --- a/src/scanner.l
> +++ b/src/scanner.l
> @@ -464,10 +464,8 @@ addrstring	({macaddr}|{ip4addr}|{ip6addr})
>  "bridge"		{ return BRIDGE; }
>  
>  "ether"			{ scanner_push_start_cond(yyscanner, SCANSTATE_ETH); return ETHER; }
> -<SCANSTATE_ARP,SCANSTATE_CT,SCANSTATE_ETH,SCANSTATE_IP,SCANSTATE_IP6,SCANSTATE_EXPR_FIB,SCANSTATE_EXPR_IPSEC>{
> -	"saddr"			{ return SADDR; }
> -	"daddr"			{ return DADDR; }
> -}
> +"saddr"			{ return SADDR; }
> +"daddr"			{ return DADDR; }
>  "type"			{ scanner_push_start_cond(yyscanner, SCANSTATE_TYPE); return TYPE; }
>  "typeof"		{ return TYPEOF; }
>  
> -- 
> 2.34.1
> 
