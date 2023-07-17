Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59053756065
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jul 2023 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGQK2z (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jul 2023 06:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQK2y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:28:54 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF78410C0
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jul 2023 03:28:49 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:28:41 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>,
        guigom@riseup.net
Subject: Re: [ANNOUNCE] nftables 1.0.8 release
Message-ID: <ZLUX2WZCkjs1peLL@calendula>
References: <ZLEr3Eg59HyPUUSR@calendula>
 <cc7b9429-540e-967d-1c50-7475b28a0973@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc7b9429-540e-967d-1c50-7475b28a0973@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Arturo,

Thanks for the detailed report.

On Mon, Jul 17, 2023 at 12:25:33PM +0200, Arturo Borrero Gonzalez wrote:
> On 7/14/23 13:05, Pablo Neira Ayuso wrote:
> > Hi!
> > 
> > The Netfilter project proudly presents:
> > 
> >          nftables 1.0.8
> > 
> 
> It seems the python package is a bit broken.
> 
> The problem can be reproduced using the tests/build/run-tests.sh script,
> which will produce something like:
> 
> ==== 8< ====
> /usr/lib/python3/dist-packages/setuptools/_distutils/cmd.py:66:
> SetuptoolsDeprecationWarning: setup.py install is deprecated.
> !!
> 
> 
> ********************************************************************************
>         Please avoid running ``setup.py`` directly.
>         Instead, use pypa/build, pypa/installer, pypa/build or
>         other standards-based tools.
> 
>         See
> https://blog.ganssle.io/articles/2021/10/setup-py-deprecated.html for
> details.
> 
> ********************************************************************************
> 
> !!
>   self.initialize_options()
> /usr/lib/python3/dist-packages/setuptools/_distutils/cmd.py:66:
> EasyInstallDeprecationWarning: easy_install command is deprecated.
> !!
> 
> 
> ********************************************************************************
>         Please avoid running ``setup.py`` and ``easy_install``.
>         Instead, use pypa/build, pypa/installer, pypa/build or
>         other standards-based tools.
> 
>         See https://github.com/pypa/setuptools/issues/917 for details.
> 
> ********************************************************************************
> 
> !!
>   self.initialize_options()
> TEST FAILED:
> /tmp/tmp.JeA0ZINB5h/nftables-1.0.8/_inst/local/lib/python3.11/dist-packages/
> does NOT support .pth files
> bad install directory or PYTHONPATH
> 
> You are attempting to install a package to a directory that is not
> on PYTHONPATH and which Python does not read ".pth" files from.  The
> installation directory you specified (via --install-dir, --prefix, or
> the distutils default setting) was:
> 
>     /tmp/tmp.JeA0ZINB5h/nftables-1.0.8/_inst/local/lib/python3.11/dist-packages/
> 
> and your PYTHONPATH environment variable currently contains:
> 
>     ''
> 
> Here are some of your options for correcting the problem:
> 
> * You can choose a different installation directory, i.e., one that is
>   on PYTHONPATH or supports .pth files
> 
> * You can add the installation directory to the PYTHONPATH environment
>   variable.  (It must then also be on PYTHONPATH whenever you run
>   Python and want to use the package(s) you are installing.)
> 
> * You can set up the installation directory to support ".pth" files by
>   using one of the approaches described here:
> 
> 
> https://setuptools.pypa.io/en/latest/deprecated/easy_install.html#custom-installation-locations
> 
> 
> Please make the appropriate changes for your system and try again.
> error: could not create 'nftables.egg-info': Permission denied
> make[3]: *** [Makefile:462: install-exec-local] Error 1
> make[2]: *** [Makefile:349: install-am] Error 2
> make[1]: *** [Makefile:481: install-recursive] Error 1
> make: *** [Makefile:697: distcheck] Error 1
> ==== 8< ====
> 
> I ignore what the fix is at the moment, but if if distutils is truly
> deprecated then a revert of https://git.netfilter.org/nftables/commit/?id=1acc2fd48c755a8931fa87b8d0560b750316059f
> may not be the correct solution.

We can schedule a new release once this is sorted out.
