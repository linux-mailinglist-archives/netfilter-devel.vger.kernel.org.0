Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C9752063
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jul 2023 13:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjGMLun (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 Jul 2023 07:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjGMLum (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:50:42 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0B119
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Jul 2023 04:50:41 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qJuqF-0007qI-71; Thu, 13 Jul 2023 13:50:39 +0200
Date:   Thu, 13 Jul 2023 13:50:39 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de, igor@gooddata.com
Subject: Re: [PATCH iptables] nft-bridge: pass context structure to
 ops->add() to improve anonymous set support
Message-ID: <ZK/lD2Hpfrtb0qWB@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de, igor@gooddata.com
References: <20230712095912.140792-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712095912.140792-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:59:12AM +0200, Pablo Neira Ayuso wrote:
[...]
> diff --git a/iptables/nft.c b/iptables/nft.c
> index 1cb104e75ccc..59e3fa7079c4 100644
> --- a/iptables/nft.c
> +++ b/iptables/nft.c
> @@ -1154,7 +1154,8 @@ gen_lookup(uint32_t sreg, const char *set_name, uint32_t set_id, uint32_t flags)
>  #define NFT_DATATYPE_ETHERADDR	9
>  
>  static int __add_nft_among(struct nft_handle *h, const char *table,
> -			   struct nftnl_rule *r, struct nft_among_pair *pairs,
> +			   struct nft_rule_ctx *ctx, struct nftnl_rule *r,
> +			   struct nft_among_pair *pairs,
>  			   int cnt, bool dst, bool inv, bool ip)
>  {
>  	uint32_t set_id, type = NFT_DATATYPE_ETHERADDR, len = ETH_ALEN;

Is there something missing here? Neither add_nft_among() nor
__add_nft_among() use the new parameter. Or is this left over from a
previous version of the fix?

Cheers, Phil
