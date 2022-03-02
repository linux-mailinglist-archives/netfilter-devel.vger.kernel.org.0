Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE64CA88D
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Mar 2022 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiCBOxP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Mar 2022 09:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiCBOxO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:53:14 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF6352B08
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Mar 2022 06:52:29 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nPQL6-0002pH-3d; Wed, 02 Mar 2022 15:52:28 +0100
Date:   Wed, 2 Mar 2022 15:52:28 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 0/2] Improve error messages for unsupported
 extensions
Message-ID: <Yh+ErK+pGFu4I+3U@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20220211171211.26484-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211171211.26484-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

*bump*

On Fri, Feb 11, 2022 at 06:12:09PM +0100, Phil Sutter wrote:
> Failure to load an extension leads to iptables cmdline parser
> complaining about any extension options instead of the extension itself.
> This is at least misleading.
> 
> This series eliminates the odd error message and instead adds a warning
> if a requested extension is not available at all in kernel.
> 
> Things are a bit complicated due to the fact that newer kernels not
> necessarily support revision 0 of all extensions. So change iptables
> first to only register revision 0 if no higher one was accepted earlier.
> This allows for a "not even revision 0 is supported" logic.
> 
> Phil Sutter (2):
>   libxtables: Register only the highest revision extension
>   Improve error messages for unsupported extensions
> 
>  iptables/nft.c       | 12 +++++++++---
>  libxtables/xtables.c | 17 ++++++++++++++---
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
