Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A486B28C6
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Mar 2023 16:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjCIPYV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Mar 2023 10:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCIPYC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:24:02 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C58B95A1A0
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Mar 2023 07:23:28 -0800 (PST)
Date:   Thu, 9 Mar 2023 16:23:25 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] doc: nft.8: Document lower priority limit for nat
 type chains
Message-ID: <ZAn57dCJmPkoBns/@salvia>
References: <20230309135246.18143-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309135246.18143-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:52:46PM +0100, Phil Sutter wrote:
> Users can't know the magic limit.
>
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  doc/nft.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/doc/nft.txt b/doc/nft.txt
> index 7de4935b4b375..0d60c7520d31e 100644
> --- a/doc/nft.txt
> +++ b/doc/nft.txt
> @@ -439,6 +439,9 @@ name which specifies the order in which chains with the same *hook* value are
>  traversed. The ordering is ascending, i.e. lower priority values have precedence
>  over higher ones.
>  
> +With *nat* type chains, there's a lower excluding limit of -200 for *priority*
> +values, because conntrack hooks at this priority and NAT requires it.

prerouting, output 		-200 	NF_IP_PRI_CONNTRACK

this should only apply in these two hooks, it should be possible to
relax this in input and postrouting in the kernel.

> +
>  Standard priority values can be replaced with easily memorizable names.  Not all
>  names make sense in every family with every hook (see the compatibility matrices
>  below) but their numerical value can still be used for prioritizing chains.
> -- 
> 2.38.0
> 
