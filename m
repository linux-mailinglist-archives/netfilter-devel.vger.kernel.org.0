Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4169C75C8A7
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Jul 2023 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjGUN6M (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Jul 2023 09:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjGUN6J (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:58:09 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4601BE2
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Jul 2023 06:57:42 -0700 (PDT)
Received: from [46.222.37.117] (port=10278 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qMqRE-00AAKO-Rv; Fri, 21 Jul 2023 15:44:59 +0200
Date:   Fri, 21 Jul 2023 15:44:54 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Leah Neukirchen <leah@vuxu.org>
Cc:     arturo@netfilter.org, netfilter-devel@vger.kernel.org,
        Jan Engelhardt <jengelh@inai.de>, phil@nwl.cc
Subject: Re: [ANNOUNCE] nftables 1.0.8 release
Message-ID: <ZLqL1g6YAbNOloRN@calendula>
References: <cc7b9429-540e-967d-1c50-7475b28a0973@netfilter.org>
 <87351i8unw.fsf@vuxu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87351i8unw.fsf@vuxu.org>
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

Hi,

Thanks for your patch.

On Thu, Jul 20, 2023 at 05:33:23PM +0200, Leah Neukirchen wrote:
> For Void Linux, I have applied this fix, which results in installing
> the same way was for 1.0.7 (else it creates a .egg directory which isn't
> loaded properly on a plain Python):
> 
> --- a/py/Makefile.am
> +++ b/py/Makefile.am
> @@ -7,7 +7,7 @@
>  install-exec-local:
>  	cd $(srcdir) && \
>  		$(PYTHON_BIN) setup.py build --build-base $(abs_builddir) \
> -		install --prefix $(DESTDIR)$(prefix)
> +		install --prefix $(prefix) --root $(DESTDIR)
>  
>  uninstall-local:
>  	rm -rf $(DESTDIR)$(prefix)/lib*/python*/site-packages/nftables

I proposed the following patch to remove py integration with
autotools/automake:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20230718120119.172757-2-pablo@netfilter.org/

Rationale is that this provides more flexibility to users and
packagers to deal with nftables Python support.

Python install infrastructure is a moving target, setup.py is still
left in place so you can still invoke it.

Does this make sense to you?
