Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD9EB94FC
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Sep 2019 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbfITQLy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Sep 2019 12:11:54 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:53448 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388473AbfITQLy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:11:54 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iBLVg-0000L9-Ua; Fri, 20 Sep 2019 18:11:52 +0200
Date:   Fri, 20 Sep 2019 18:11:52 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] mnl: do not cache sender buffer size
Message-ID: <20190920161152.GU6961@breakpoint.cc>
References: <20190920153154.26734-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920153154.26734-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> SO_SNDBUF never fails, this socket option just provides a hint to the
> kernel.  SO_SNDBUFFORCE sets the buffer size to zero if the value goes
> over INT_MAX. Userspace is caching the buffer hint that sends to the
> kernel, so it might leave userspace out of sync if the kernel ignores
> the hint. Do not make assumptions, fetch the sender buffer size from the
> kernel via getsockopt().
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  src/mnl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/src/mnl.c b/src/mnl.c
> index 57ff89f50e23..19631e33dc9d 100644
> --- a/src/mnl.c
> +++ b/src/mnl.c
> @@ -218,24 +218,24 @@ void mnl_err_list_free(struct mnl_err *err)
>  	xfree(err);
>  }
>  
> -static int nlbuffsiz;
> -
>  static void mnl_set_sndbuffer(const struct mnl_socket *nl,
>  			      struct nftnl_batch *batch)
>  {
> +	int sndnlbuffsiz = 0;
>  	int newbuffsiz;
> +	socklen_t len;

IIRC this needs to be

	len = sizeof(sndnlbuffsiz);
