Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C0E534C52
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 May 2022 11:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiEZJKX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 May 2022 05:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239996AbiEZJKV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 May 2022 05:10:21 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD011FCC0
        for <netfilter-devel@vger.kernel.org>; Thu, 26 May 2022 02:10:19 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 5FC9258725892; Thu, 26 May 2022 11:10:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 5816560C28F49;
        Thu, 26 May 2022 11:10:17 +0200 (CEST)
Date:   Thu, 26 May 2022 11:10:17 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Ben Brown <ben@demerara.io>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2] build: Fix error during out of tree build
In-Reply-To: <20220525152613.152899-1-ben@demerara.io>
Message-ID: <qnpo4s81-8s14-ps33-824p-8821sn52p825@vanv.qr>
References: <20220525152613.152899-1-ben@demerara.io>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2022-05-25 17:26, Ben Brown wrote:

>diff --git a/libxtables/Makefile.am b/libxtables/Makefile.am
>index 8ff6b0ca..3bfded85 100644
>--- a/libxtables/Makefile.am
>+++ b/libxtables/Makefile.am
>@@ -1,7 +1,7 @@
> # -*- Makefile -*-
> 
> AM_CFLAGS   = ${regular_CFLAGS}
>-AM_CPPFLAGS = ${regular_CPPFLAGS} -I${top_builddir}/include -I${top_srcdir}/include -I${top_srcdir}/iptables ${kinclude_CPPFLAGS}
>+AM_CPPFLAGS = ${regular_CPPFLAGS} -I${top_builddir}/include -I${top_srcdir}/include -I${top_srcdir}/iptables -I${top_srcdir} ${kinclude_CPPFLAGS}

I wouldn't have done it any other way.
(Looks good.)
