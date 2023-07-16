Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812487550ED
	for <lists+netfilter-devel@lfdr.de>; Sun, 16 Jul 2023 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGPTXW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 16 Jul 2023 15:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjGPTXV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:23:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8098;
        Sun, 16 Jul 2023 12:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A54D860DFF;
        Sun, 16 Jul 2023 19:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E90C433C7;
        Sun, 16 Jul 2023 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689535400;
        bh=R7YtvXF0huO+jAuQOqF3y9XOt16765tBkUi3TN3cL/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5WBLBb83l6SMsiBbHVQtb9UtZ/Tsikwm16ky/1VH+LO1mU49LK5e6p1xRqOYnbTN
         SD/+8U5Dl2LzmfjaNgIeKCCvAhkPc+qL8dYuPzJ/zHbfAYyy1nkVEC4A1TQjoAZf7k
         oL/Uu/qqZ75pVipa0y24ZFb3MIOyNIR4fhLddn4s=
Date:   Sun, 16 Jul 2023 21:22:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH -stable,5.4 00/10] stable fixes for 5.4
Message-ID: <2023071633-dinner-overstate-3627@gregkh>
References: <20230705165423.50054-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705165423.50054-1-pablo@netfilter.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 05, 2023 at 06:54:13PM +0200, Pablo Neira Ayuso wrote:
> Hi Greg, Sasha,
> 
> The following list shows the backported patches, I am using original
> commit IDs for reference:
> 
> 1) 1e9451cbda45 ("netfilter: nf_tables: fix nat hook table deletion")
> 
> 2) 802b805162a1 ("netfilter: nftables: add helper function to set the base sequence number")
> 
> 3) 19c28b1374fb ("netfilter: add helper function to set up the nfnetlink header and use it")
> 
> 4) 0854db2aaef3 ("netfilter: nf_tables: use net_generic infra for transaction data")
> 
> 5) 81ea01066741 ("netfilter: nf_tables: add rescheduling points during loop detection walks")
> 
> 6) 1240eb93f061 ("netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE")
> 
> 7) 26b5a5712eb8 ("netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain")
> 
> 8) 938154b93be8 ("netfilter: nf_tables: reject unbound anonymous set before commit phase")
> 
> 9) 3e70489721b6 ("netfilter: nf_tables: unbind non-anonymous set if rule construction fails")
> 
> 10) 2024439bd5ce ("netfilter: nf_tables: fix scheduling-while-atomic splat")
> 
> Please, apply,

Sorry for the delay, now queued up.

greg k-h
