Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD24611D464
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Dec 2019 18:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfLLRpg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Dec 2019 12:45:36 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:49538 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfLLRpg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:45:36 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1ifSWt-0001DH-6f; Thu, 12 Dec 2019 18:45:35 +0100
Date:   Thu, 12 Dec 2019 18:45:35 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] main: allow for getopt parser from top-level scope
 only
Message-ID: <20191212174535.GI20005@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191212171455.83382-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212171455.83382-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Thu, Dec 12, 2019 at 06:14:55PM +0100, Pablo Neira Ayuso wrote:
[...]
> diff --git a/src/main.c b/src/main.c
> index fde8b15c5870..c96953e3cd2f 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -202,29 +202,107 @@ static const struct {
>  	},
>  };
>  
> +struct nft_opts {
> +	char		**argv;
> +	int		argc;
> +};
> +
> +static int nft_opts_init(int argc, char * const argv[], struct nft_opts *opts)
> +{
> +	uint32_t scope = 0;
> +	char *new_argv;
> +	int i;
> +
> +	opts->argv = calloc(argc + 1, sizeof(char *));
> +	if (!opts->argv)
> +		return -1;
> +
> +	for (i = 0; i < argc; i++) {
> +		if (scope > 0) {
> +			if (argv[i][0] == '-') {
> +				new_argv = malloc(strlen(argv[i]) + 2);
> +				if (!new_argv)
> +					return -1;
> +
> +				sprintf(new_argv, "\\-%s", &argv[i][1]);
> +				opts->argv[opts->argc++] = new_argv;
> +				continue;
> +			}
> +		} else if (argv[i][0] == '{') {
> +			scope++;
> +		} else if (argv[i][0] == '}') {
> +			scope--;
> +		}

This first char check is not reliable, bison accepts commands which lack
spaces in the relevant places:

| # nft add chain inet t c{ type filter hook input priority filter\; }
| # echo $?
| 0

Cheers, Phil
