Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CA276594E
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jul 2023 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjG0Q5H (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 27 Jul 2023 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjG0Q5G (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:57:06 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7A273C
        for <netfilter-devel@vger.kernel.org>; Thu, 27 Jul 2023 09:57:05 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qP4IS-0003OL-9q; Thu, 27 Jul 2023 18:57:04 +0200
Date:   Thu, 27 Jul 2023 18:57:04 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [nft v3 PATCH 3/4] src: add input flag NFT_CTX_INPUT_JSON to
 enable JSON parsing
Message-ID: <ZMKh4DcZBqDYIaXH@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Thomas Haller <thaller@redhat.com>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <20230720143147.669250-1-thaller@redhat.com>
 <20230720143147.669250-4-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720143147.669250-4-thaller@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jul 20, 2023 at 04:27:02PM +0200, Thomas Haller wrote:
[...]
> diff --git a/doc/libnftables.adoc b/doc/libnftables.adoc
> index 77f3a0fd5659..27e230281edb 100644
> --- a/doc/libnftables.adoc
> +++ b/doc/libnftables.adoc
> @@ -87,6 +87,7 @@ The flags setting controls the input format.
>  ----
>  enum {
>          NFT_CTX_INPUT_NO_DNS = (1 << 0),
> +        NFT_CTX_INPUT_JSON   = (1 << 1),
>  };
>  ----
>  
> @@ -94,6 +95,11 @@ NFT_CTX_INPUT_NO_DNS::
>  	Avoid resolving IP addresses with blocking getaddrinfo(). In that case,
>  	only plain IP addresses are accepted.
>  
> +NFT_CTX_INPUT_JSON:
> +	When parsing the input, first try to interpret the input as JSON before
> +	falling back to the nftables format. This behavior is implied when setting
> +	the NFT_CTX_OUTPUT_JSON flag.

I would drop the last sentence here and extend NFT_CTX_OUTPUT_JSON docs
instead, illustrating that it implicitly enables NFT_CTX_INPUT_JSON. Or
keep the sentence here, if you prefer. But JSON input being enabled when
enabling JSON output is the actually unintuitive part for people aware
of input flags' existence.

[...]
> diff --git a/src/libnftables.c b/src/libnftables.c
> index 6832f0486d6d..a2e0ae6b5843 100644
> --- a/src/libnftables.c
> +++ b/src/libnftables.c
> @@ -578,7 +578,8 @@ int nft_run_cmd_from_buffer(struct nft_ctx *nft, const char *buf)
>  	nlbuf = xzalloc(strlen(buf) + 2);
>  	sprintf(nlbuf, "%s\n", buf);
>  
> -	if (nft_output_json(&nft->output))
> +	if (nft_output_json(&nft->output) ||
> +	    (nft_ctx_input_get_flags(nft) & NFT_CTX_INPUT_JSON))

As pointed out before, this reads much nicer with a getter:

|	if (nft_output_json(&nft->output) ||
|	    nft_input_json(&nft->input))

Cheers, Phil
