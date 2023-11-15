Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F57DF0FD
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Nov 2023 12:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjKBLO6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Nov 2023 07:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjKBLO5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:14:57 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ADCE7
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Nov 2023 04:14:51 -0700 (PDT)
Received: from [78.30.35.151] (port=54810 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qyVev-008aIs-7w; Thu, 02 Nov 2023 12:14:49 +0100
Date:   Thu, 2 Nov 2023 12:14:44 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>, fw@strlen.de
Subject: Re: [PATCH nft v2 4/7] build: no recursive make for
 "files/**/Makefile.am"
Message-ID: <ZUOEpOU96ai+dmT7@calendula>
References: <20231019130057.2719096-1-thaller@redhat.com>
 <20231019130057.2719096-5-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019130057.2719096-5-thaller@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:00:03PM +0200, Thomas Haller wrote:
> diff --git a/Makefile.am b/Makefile.am
> index 8b8de7bd141a..83f25dd8574b 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -2,6 +2,8 @@ ACLOCAL_AMFLAGS = -I m4
>  
>  EXTRA_DIST =
>  
> +###############################################################################

This marker shows that this Makefile.am is really getting too big.

Can we find a middle point?

I understand that a single Makefile for something as little as
examples/Makefile.am is probably too much.

No revert please, something incremental, otherwise this looks like
iptables' Makefile.

Thanks.
