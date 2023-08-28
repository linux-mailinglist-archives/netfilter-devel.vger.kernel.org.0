Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5478B4DE
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Aug 2023 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjH1Pyy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Aug 2023 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjH1Pyg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:54:36 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445F0102
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Aug 2023 08:54:33 -0700 (PDT)
Received: from [78.30.34.192] (port=34050 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qaeZQ-00AU7A-NA; Mon, 28 Aug 2023 17:54:31 +0200
Date:   Mon, 28 Aug 2023 17:54:28 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 8/8] datatype: suppress "-Wformat-nonliteral" warning
 in integer_type_print()
Message-ID: <ZOzDNFqXdftWgtTF@calendula>
References: <20230828144441.3303222-1-thaller@redhat.com>
 <20230828144441.3303222-9-thaller@redhat.com>
 <ZOy4VvjT/vxpR5iR@calendula>
 <dd5bf8c204447fa7dda1b5bfb87a830f07a55c04.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd5bf8c204447fa7dda1b5bfb87a830f07a55c04.camel@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:33:01PM +0200, Thomas Haller wrote:
> On Mon, 2023-08-28 at 17:08 +0200, Pablo Neira Ayuso wrote:
> > On Mon, Aug 28, 2023 at 04:43:58PM +0200, Thomas Haller wrote:
> > > 
> > > +       _NFT_PRAGMA_WARNING_DISABLE("-Wformat-nonliteral")
> > 
> > Maybe simply -Wno-format-nonliteral turn off in Clang so there is no
> > need for this PRAGMA in order to simplify things.
> 
> "-Wformat-nonliteral" seems a useful warning. I would rather not
> disable it at a larger scale.
> 
> Gcc also supports "-Wformat-nonliteral" warning, but for some reason it
> does not warn here (also not, when I pass "-Wformat=2"). I don't
> understand why that is.

Can you see any other way to fix this clang compilation eror without
this pragma? What makes clang unhappy with this code?
