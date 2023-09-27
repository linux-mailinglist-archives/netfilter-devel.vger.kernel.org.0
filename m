Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16927B0D32
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Sep 2023 22:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjI0UPQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Sep 2023 16:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0UPQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:15:16 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F5510E
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Sep 2023 13:15:13 -0700 (PDT)
Received: from [78.30.34.192] (port=39316 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlaw8-00EZP3-QA; Wed, 27 Sep 2023 22:15:10 +0200
Date:   Wed, 27 Sep 2023 22:15:08 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v2] doc: make the HTML main page
 available as `man 7 libnetfilter_queue`
Message-ID: <ZRSNTIRBcm6PbN4g@calendula>
References: <20230921004311.18412-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230921004311.18412-1-duncan_roe@optusnet.com.au>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Duncan,

On Thu, Sep 21, 2023 at 10:43:11AM +1000, Duncan Roe wrote:
> Without this patch, man page users can miss important general information.
> 
> The HTML display stays as it was.
> The man3 pages are updated to reference libnetfilter_queue.7.
> build_man.sh must be invoked with arguments to activate man7 generation,
> so will continue to work in other projects as before.
> build_man.sh remains generic,
> so should be able to make man7 pages for other netfilter projects.
> 
> v2: Change commit message from "how" to "why"
> 
> Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
> ---
>  doxygen/Makefile.am      |   6 +--
>  doxygen/build_man.sh     | 101 +++++++++++++++++++++++++++++++++++++--
>  doxygen/man7.extra.txt   |   1 +
>  doxygen/old_doxy_fix.txt |   5 ++
>  src/libnetfilter_queue.c |  14 +++---
>  5 files changed, 113 insertions(+), 14 deletions(-)
>  create mode 100644 doxygen/man7.extra.txt
>  create mode 100644 doxygen/old_doxy_fix.txt
> 
> diff --git a/doxygen/Makefile.am b/doxygen/Makefile.am
> index c6eeed7..e98368b 100644
> --- a/doxygen/Makefile.am
> +++ b/doxygen/Makefile.am
> @@ -10,12 +10,12 @@ doc_srcs = $(top_srcdir)/src/libnetfilter_queue.c\
>             $(top_srcdir)/src/extra/udp.c\
>             $(top_srcdir)/src/extra/icmp.c
>  
> -doxyfile.stamp: $(doc_srcs) Makefile
> +doxyfile.stamp: $(doc_srcs) Makefile build_man.sh man7.extra.txt old_doxy_fix.txt
>  	rm -rf html man
>  	doxygen doxygen.cfg >/dev/null
>  
>  if BUILD_MAN
> -	$(abs_top_srcdir)/doxygen/build_man.sh
> +	$(abs_top_srcdir)/doxygen/build_man.sh libnetfilter_queue libnetfilter_queue.c
>  endif
>  
>  	touch doxyfile.stamp
> @@ -42,4 +42,4 @@ uninstall-local:
>  	rm -rf $(DESTDIR)$(mandir) man html doxyfile.stamp $(DESTDIR)$(htmldir)
>  endif
>  
> -EXTRA_DIST = build_man.sh
> +EXTRA_DIST = build_man.sh man7.extra.txt old_doxy_fix.txt

Please, find a way to make this self-contained. We agreed to keep this
mangling to generate the API manpages and such in the build_man.sh
script, it will probably require more work on that front.

Thanks.
