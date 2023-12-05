Return-Path: <netfilter-devel+bounces-180-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B114B805711
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A57AB21002
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Dec 2023 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89F65EAD;
	Tue,  5 Dec 2023 14:19:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8DD90
	for <netfilter-devel@vger.kernel.org>; Tue,  5 Dec 2023 06:19:39 -0800 (PST)
Received: from [78.30.43.141] (port=58446 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rAWGu-000IdA-4p; Tue, 05 Dec 2023 15:19:38 +0100
Date: Tue, 5 Dec 2023 15:19:35 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] evaluate: fix double free on dtype release
Message-ID: <ZW8xd0KXzA3SiM6L@calendula>
References: <20231205120820.20346-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205120820.20346-1-fw@strlen.de>
X-Spam-Score: -1.9 (-)

On Tue, Dec 05, 2023 at 01:08:17PM +0100, Florian Westphal wrote:
> We release ->dtype twice, will either segfault or assert
> on dtype->refcount != 0 check in datatype_free().
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  src/evaluate.c                                              | 2 +-
>  .../bogons/nft-f/double-free-on-binop-dtype_assert          | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>  create mode 100644 tests/shell/testcases/bogons/nft-f/double-free-on-binop-dtype_assert
> 
> diff --git a/src/evaluate.c b/src/evaluate.c
> index 16ad6473db1a..58cc811aca9a 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
> @@ -1171,7 +1171,7 @@ static int expr_evaluate_prefix(struct eval_ctx *ctx, struct expr **expr)
>  	base = prefix->prefix;
>  	assert(expr_is_constant(base));
>  
> -	prefix->dtype	  = base->dtype;
> +	prefix->dtype	  = datatype_get(base->dtype);

I prefer datatype_clone() just in case base->dtype gets updated for
whatever reason.

>  	prefix->byteorder = base->byteorder;
>  	prefix->len	  = base->len;
>  	prefix->flags	 |= EXPR_F_CONSTANT;
> diff --git a/tests/shell/testcases/bogons/nft-f/double-free-on-binop-dtype_assert b/tests/shell/testcases/bogons/nft-f/double-free-on-binop-dtype_assert
> new file mode 100644
> index 000000000000..b7a9a1cc7e8b
> --- /dev/null
> +++ b/tests/shell/testcases/bogons/nft-f/double-free-on-binop-dtype_assert
> @@ -0,0 +1,6 @@
> +table inet t {
> +	chain c {
> +		udp length . @th,160,118 vmap { 47-63 . 0xe3731353631303331313037353532/3 : accept }
> +		jump noexist # only here so this fails to load after patch.
> +	}
> +}
> -- 
> 2.41.0
> 
> 

