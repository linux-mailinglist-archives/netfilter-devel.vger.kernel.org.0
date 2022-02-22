Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845924BFD4C
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Feb 2022 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiBVPpF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Feb 2022 10:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiBVPpE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:45:04 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEA11119425
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Feb 2022 07:44:37 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 12E0F64369;
        Tue, 22 Feb 2022 16:43:35 +0100 (CET)
Date:   Tue, 22 Feb 2022 16:44:31 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [ANNOUNCE] nftables 1.0.2 release
Message-ID: <YhUE38mgAKGV1WZn@salvia>
References: <YhO5Pn+6+dgAgSd9@salvia>
 <7c75325e-f7c0-2354-3217-2735d8c3bbb6@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c75325e-f7c0-2354-3217-2735d8c3bbb6@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:28:39PM +0100, Arturo Borrero Gonzalez wrote:
> 
> 
> On 2/21/22 17:09, Pablo Neira Ayuso wrote:
> > Hi!
> > 
> > The Netfilter project proudly presents:
> > 
> >          nftables 1.0.2
> > 
> 
> 
> Hi there,
> 
> this release doesn't build out of the box:
> 
> [..]
> Making all in examples
> make[3]: Entering directory '/<<PKGBUILDDIR>>/examples'
> gcc -DHAVE_CONFIG_H -I. -I..   -Wdate-time -D_FORTIFY_SOURCE=2  -g -O2
> -ffile-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -Wformat
> -Werror=format-security -c -o nft-buffer.o nft-buffer.c
> gcc -DHAVE_CONFIG_H -I. -I..   -Wdate-time -D_FORTIFY_SOURCE=2  -g -O2
> -ffile-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -Wformat
> -Werror=format-security -c -o nft-json-file.o nft-json-file.c
> nft-json-file.c:3:10: fatal error: nftables/libnftables.h: No such file or
> directory
>     3 | #include <nftables/libnftables.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> nft-buffer.c:3:10: fatal error: nftables/libnftables.h: No such file or
> directory
>     3 | #include <nftables/libnftables.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> [..]
> 
> 
> Some options:
> * make the missing header file properly available to the example files
> * don't build the examples unless explicitly requested, not as part of the
> main program build
> 
> What do you suggest?

It is fixed here, both things you mentioned:

http://git.netfilter.org/nftables/commit/?id=18a08fb7f0443f8bde83393bd6f69e23a04246b3
