Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3087F748E62
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Jul 2023 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjGETyP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jul 2023 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGETyO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:54:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A98E3;
        Wed,  5 Jul 2023 12:54:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75398616FE;
        Wed,  5 Jul 2023 19:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9069DC433C8;
        Wed,  5 Jul 2023 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688586850;
        bh=I3KWroi99Ljz2pORIWX+CtiQihvDJgJepMbAwN1u1qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKf/K4QP3473DHutJOHhG8YRPsZ2OWYp/gQIQLdLX+lf1N5sUgOR2ap95tqPIrUgD
         G8Mhqlexpu6P4t/UAyJeIPRVEDfU1Z4bAN5GWvTZiOsffF4R1dlFsUoRN0rN+JwsQg
         J2V/dZN30lQfcYbX8Xf6TunMFqkVPBuyN2C4cgI8=
Date:   Wed, 5 Jul 2023 20:54:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: Re: [PATCH -stable,5.15 2/2] netfilter: nf_tables: unbind
 non-anonymous set if rule construction fails
Message-ID: <2023070533-swimwear-audition-49e8@gregkh>
References: <20230705141411.53123-1-pablo@netfilter.org>
 <20230705141411.53123-3-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705141411.53123-3-pablo@netfilter.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 05, 2023 at 04:14:11PM +0200, Pablo Neira Ayuso wrote:
> [ 3e70489721b6c870252c9082c496703677240f53 ]
> 
> Otherwise a dangling reference to a rule object that is gone remains
> in the set binding list.
> 
> Fixes: 26b5a5712eb8 ("netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  net/netfilter/nf_tables_api.c | 2 ++
>  1 file changed, 2 insertions(+)

But what about kernels newer than 5.15?  Surely this is also needed
there as this only is going to first show up in 6.5-rc1, which hasn't
been released yet.

thanks,

greg k-h
