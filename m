Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4A7550F3
	for <lists+netfilter-devel@lfdr.de>; Sun, 16 Jul 2023 21:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGPTZ1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 16 Jul 2023 15:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGPTZ0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B62698;
        Sun, 16 Jul 2023 12:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE02860E09;
        Sun, 16 Jul 2023 19:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD0FC433C8;
        Sun, 16 Jul 2023 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689535523;
        bh=B97txOmJjoVaF3TeshqjurZHgGYFSe+06Eu61giQYfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4lgOBuSgnOwhC+aaTwGI2AVSnP+mq4ZwC9l8AgalZDOpsO4p9cFECAesu7RP+K0z
         s+Z95gge3kKwa+QIrovIC309Kna5AZaNOpc+r0zJNbLNgjMAJtHJryhiIxCyoPROFy
         v2vABvaYvfz4eCMs1LXPGeYJj4DHC9FGyNG0Nho0=
Date:   Sun, 16 Jul 2023 21:24:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH -stable,4.14 0/3] stable fixes for 4.14
Message-ID: <2023071644-unwanted-attractor-74e7@gregkh>
References: <20230705165623.50304-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705165623.50304-1-pablo@netfilter.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 05, 2023 at 06:56:20PM +0200, Pablo Neira Ayuso wrote:
> Hi Greg, Sasha,
> 
> The following list shows the backported patches, I am using original
> commit IDs for reference:
> 
> 1) 1240eb93f061 ("netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE")
> 
> 2) 26b5a5712eb8 ("netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain")
> 
> 3) 3e70489721b6 ("netfilter: nf_tables: unbind non-anonymous set if rule construction fails")
> 
> Please, apply,

Now queued up, thanks.

greg k-h
