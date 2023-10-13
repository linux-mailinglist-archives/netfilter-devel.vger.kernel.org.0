Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EAB7C840D
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Oct 2023 13:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjJMLIP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Oct 2023 07:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMLIP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:08:15 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C11291
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Oct 2023 04:08:14 -0700 (PDT)
Received: from [78.30.34.192] (port=37040 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qrG1a-009QiS-J8; Fri, 13 Oct 2023 13:08:12 +0200
Date:   Fri, 13 Oct 2023 13:08:09 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] evaluate: suggest != in negation error message
Message-ID: <ZSklGaIm2BDcVANw@calendula>
References: <20231013104154.7482-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231013104154.7482-1-fw@strlen.de>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:41:49PM +0200, Florian Westphal wrote:
>   when I run sudo nft insert rule filter FORWARD iifname "ens2f1" ip saddr not @ip_macs counter drop comment \" BLOCK ALL NON REGISTERED IP/MACS \"
>   I get: Error: negation can only be used with singleton bitmask values
> 
> And even I did not spot the problem immediately.
> 
> I don't think "not" should have been added, its easily confused with
> "not equal"/"neq"/!= and hides that this is (allegedly) a bit operation.
> 
> At least suggest to use != instead in the error message, I suspect it
> might lessen the pain.

LGTM.
