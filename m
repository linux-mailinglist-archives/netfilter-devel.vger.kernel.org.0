Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F4430CBC
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Oct 2021 00:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbhJQWUC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 17 Oct 2021 18:20:02 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53614 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbhJQWUC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 17 Oct 2021 18:20:02 -0400
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 728BC605E1;
        Mon, 18 Oct 2021 00:16:10 +0200 (CEST)
Date:   Mon, 18 Oct 2021 00:17:47 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] main: _exit() if setuid
Message-ID: <YWyhCwDYq8zYd8Lm@salvia>
References: <20211016225623.155790-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211016225623.155790-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Oct 17, 2021 at 12:56:23AM +0200, Florian Westphal wrote:
> Apparently some people think its a good idea to make nft setuid so
> unrivilged users can change settings.
> 
> "nft -f /etc/shadow" is just one example of why this is a bad idea.
> Disable this.  Do not print anything, fd cannot be trusted.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  src/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/main.c b/src/main.c
> index 21096fc7398b..5847fc4ad514 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -363,6 +363,10 @@ int main(int argc, char * const *argv)
>  	unsigned int len;
>  	int i, val, rc;
>  
> +	/* nftables cannot be used with setuid in a safe way. */
> +	if (getuid() != geteuid())
> +		_exit(111);

Applications using libnftables would still face the same issue.

>  	if (!nft_options_check(argc, argv))
>  		exit(EXIT_FAILURE);
>  
> -- 
> 2.31.1
> 
