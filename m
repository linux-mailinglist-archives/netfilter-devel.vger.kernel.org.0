Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14821750F67
	for <lists+netfilter-devel@lfdr.de>; Wed, 12 Jul 2023 19:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGLRN5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Jul 2023 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGLRN4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:13:56 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACBAF1989
        for <netfilter-devel@vger.kernel.org>; Wed, 12 Jul 2023 10:13:54 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:13:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, igor@gooddata.com, phil@nwl.cc
Subject: Re: [PATCH iptables] nft-bridge: pass context structure to
 ops->add() to improve anonymous set support
Message-ID: <ZK7fTtDVp61+7byX@calendula>
References: <20230712095912.140792-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230712095912.140792-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:59:12AM +0200, Pablo Neira Ayuso wrote:
> diff --git a/iptables/nft.c b/iptables/nft.c
> index 1cb104e75ccc..59e3fa7079c4 100644
> --- a/iptables/nft.c
> +++ b/iptables/nft.c
[...]
> @@ -2878,6 +2888,9 @@ int nft_rule_zero_counters(struct nft_handle *h, const char *chain,
>  {
>  	struct iptables_command_state cs = {};
>  	struct nftnl_rule *r, *new_rule;
> +	struct nft_rule_ctx ctx = {
> +		.command = NFT_COMPAT_RULE_ZERO,

BTW. I changed this to:

                .command = NFT_COMPAT_RULE_APPEND,

before pushing it out, for the record.

> +	};
>  	struct nft_chain *c;
>  	int ret = 0;
>  
