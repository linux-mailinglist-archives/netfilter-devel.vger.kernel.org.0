Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806996ADF08
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Mar 2023 13:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCGMq7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Mar 2023 07:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCGMqo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:46:44 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89547C948
        for <netfilter-devel@vger.kernel.org>; Tue,  7 Mar 2023 04:46:39 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pZWiE-0000Hc-Id; Tue, 07 Mar 2023 13:46:38 +0100
Date:   Tue, 7 Mar 2023 13:46:38 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf-next 00/13] Support for shifted port-ranges in NAT
Message-ID: <20230307124638.GE13059@breakpoint.cc>
References: <20230305121817.2234734-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305121817.2234734-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> Jeremy Sowden (13):
>   netfilter: nft_nat: correct length for loading protocol registers
>   netfilter: nft_masq: correct length for loading protocol registers
>   netfilter: nft_redir: correct value of inet type `.maxattrs`
>   netfilter: nft_redir: correct length for loading protocol registers

I think the fixess above should be routed through the 'nf' tree, I
don't see why we need to hold them in -next trees for another 3 months.

