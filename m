Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42520653ED6
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Dec 2022 12:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiLVLQ6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 22 Dec 2022 06:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiLVLQ5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:16:57 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 534991FCE0
        for <netfilter-devel@vger.kernel.org>; Thu, 22 Dec 2022 03:16:57 -0800 (PST)
Date:   Thu, 22 Dec 2022 12:16:54 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [ANNOUNCE] nftables 1.0.6 release
Message-ID: <Y6Q8plbLc8eDR9Ou@salvia>
References: <Y6OXLMinA/lCWNsB@salvia>
 <22fd9796-023f-1aac-e054-5227bc64be3d@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22fd9796-023f-1aac-e054-5227bc64be3d@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 22, 2022 at 12:14:20PM +0100, Arturo Borrero Gonzalez wrote:
> On 12/22/22 00:30, Pablo Neira Ayuso wrote:
> > 
> > To build the code, libnftnl >= 1.2.4 and libmnl >= 1.0.4 are required:
> > 
> 
> Hi,
> 
> when building nftables 1.0.6 for debian, the build system says that it
> should be fine to use libnftnl 1.2.2, which apparently is the latest release
> that added a new public symbol.
> 
> This can be a problem with the debian toolchain, or it can be for real that
> there are no new symbols since 1.2.2 and therefore the build-time dependency
> is on >= 1.2.2
> 
> No big deal, but it would be nice to clarify this.

No new symbols in libnftnl 1.2.4, the pktconfig dependency was bumped
because of minor fixes included in libnftnl.

We can stop bumping the dependency for minor fixes in the future if
you prefer it this way.
