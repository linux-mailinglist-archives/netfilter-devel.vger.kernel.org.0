Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2232D254B65
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Aug 2020 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgH0RCG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Aug 2020 13:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0RCG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:02:06 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42AAC061264
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Aug 2020 10:02:05 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kBLHn-0005gP-O3; Thu, 27 Aug 2020 19:02:03 +0200
Date:   Thu, 27 Aug 2020 19:02:03 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Quentin Armitage <quentin@armitage.org.uk>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH] netfilter: nftables: fix documentation for dup statement
Message-ID: <20200827170203.GM23632@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Quentin Armitage <quentin@armitage.org.uk>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <f9bc9e191b03728fe233ca7a75fdc40ede0fde8e.camel@armitage.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9bc9e191b03728fe233ca7a75fdc40ede0fde8e.camel@armitage.org.uk>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Thu, Aug 27, 2020 at 04:42:00PM +0100, Quentin Armitage wrote:
> The dup statement requires an address, and the device is optional,
> not the other way round.
> 
> Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
> ---
>  doc/statements.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/statements.txt b/doc/statements.txt
> index 9155f286..835db087 100644
> --- a/doc/statements.txt
> +++ b/doc/statements.txt
> @@ -648,7 +648,7 @@ The dup statement is used to duplicate a packet and send the
> copy to a different
>  destination.
>  
>  [verse]
> -*dup to* 'device'
> +*dup to* 'address'
>  *dup to* 'address' *device* 'device'
>  
>  .Dup statement values

The examples are wrong, too. I wonder if this is really just a mistake
and all three examples given (including the "advanced" usage using a
map) are just wrong or if 'dup' actually was meant to support
duplicating to a device in mirror port fashion.

Florian, you wrote the docs. What's your take here?

Thanks, Phil
