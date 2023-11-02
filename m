Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949AF7DF131
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Nov 2023 12:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjKBLar (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Nov 2023 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjKBLaq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:30:46 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2F2133
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Nov 2023 04:30:40 -0700 (PDT)
Received: from [78.30.35.151] (port=53974 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qyVuD-008f8A-PV; Thu, 02 Nov 2023 12:30:38 +0100
Date:   Thu, 2 Nov 2023 12:30:32 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>, fw@strlen.de
Subject: Re: [PATCH nft v2 4/7] build: no recursive make for
 "files/**/Makefile.am"
Message-ID: <ZUOIWNT3sjmqd8EM@calendula>
References: <20231019130057.2719096-1-thaller@redhat.com>
 <20231019130057.2719096-5-thaller@redhat.com>
 <ZUOEpOU96ai+dmT7@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUOEpOU96ai+dmT7@calendula>
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

On Thu, Nov 02, 2023 at 12:14:49PM +0100, Pablo Neira Ayuso wrote:
> On Thu, Oct 19, 2023 at 03:00:03PM +0200, Thomas Haller wrote:
> > diff --git a/Makefile.am b/Makefile.am
> > index 8b8de7bd141a..83f25dd8574b 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -2,6 +2,8 @@ ACLOCAL_AMFLAGS = -I m4
> >  
> >  EXTRA_DIST =
> >  
> > +###############################################################################
> 
> This marker shows that this Makefile.am is really getting too big.
> 
> Can we find a middle point?
> 
> I understand that a single Makefile for something as little as
> examples/Makefile.am is probably too much.
> 
> No revert please, something incremental, otherwise this looks like
> iptables' Makefile.

Correction: Actually iptables' Makefiles show a better balance in how
things are split accross Makefiles, with some possibilities to
consolidate things but it looks much better these days.
