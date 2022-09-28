Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906CB5EE044
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Sep 2022 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiI1PZw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Sep 2022 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiI1PZX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:25:23 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6B2367BB
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Sep 2022 08:24:51 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1odYvZ-000507-76; Wed, 28 Sep 2022 17:24:49 +0200
Date:   Wed, 28 Sep 2022 17:24:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] ebtables: Fix among match
Message-ID: <20220928152449.GL12777@breakpoint.cc>
References: <20220928135524.22822-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928135524.22822-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Fixed commit broke among match in two ways:
> 
> 1) The two lookup sizes are 12 and 6, not 12 and 4 - among supports
>    either ether+IP or ether only, not IP only.
> 
> 2) Adding two to sreg_count to get the second register is too simple: It
>    works only for four byte regs, not the 16 byte ones. The first
>    register is always a 16 byte one, though.
> 
> Fixing (1) is trivial, fix (2) by introduction of nft_get_next_reg()
> doing the right thing. For consistency, use it for among match creation,
> too.

LGTM, thanks.

Could you add a followup patch that cleans this up:

> diff --git a/iptables/nft-bridge.c b/iptables/nft-bridge.c
> index 659c5b58ba633..596dfdf8991f1 100644
> --- a/iptables/nft-bridge.c
> +++ b/iptables/nft-bridge.c
> @@ -349,7 +349,7 @@ static int lookup_analyze_payloads(struct nft_xt_ctx *ctx,
>  			return -1;
>  		}
>  
> -		sreg_count += 2;
> +		sreg_count = nft_get_next_reg(sreg_count, ETH_ALEN);


.. and renames sreg_count to 'enum nft_registers sreg' or similar?
