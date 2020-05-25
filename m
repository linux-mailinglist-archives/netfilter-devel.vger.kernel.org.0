Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5B31E1215
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2020 17:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391034AbgEYPwI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 May 2020 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388739AbgEYPwI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 May 2020 11:52:08 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E04C061A0E
        for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2020 08:52:08 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jdFOX-00065P-Ux; Mon, 25 May 2020 17:52:05 +0200
Date:   Mon, 25 May 2020 17:52:05 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Matt Turner <mattst88@gmail.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] build: Fix doc build, restore A2X assignment for
 doc/Makefile
Message-ID: <20200525155205.GV17795@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Stefano Brivio <sbrivio@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Matt Turner <mattst88@gmail.com>, netfilter-devel@vger.kernel.org
References: <8ef909eedea05cdd3072bea59d664e3a52e28dcd.1590320436.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef909eedea05cdd3072bea59d664e3a52e28dcd.1590320436.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Sun, May 24, 2020 at 02:59:36PM +0200, Stefano Brivio wrote:
> Commit 4f2813a313ae ("build: Include generated man pages in dist
> tarball") skips AC_CHECK_PROG for A2X altogether if doc/nft.8 is
> already present.
> 
> Now, starting from a clean situation, we can have this sequence:
>   ./configure	# doc/nft.8 not there, A2X set in doc/Makefile
>   make		# builds doc/nft.8
>   ./configure	# doc/nft.8 is there, A2X left empty in doc/Makefile
>   make clean	# removes doc/nft.8
>   make

Thanks for your fix! I fell into that myself since my "build everything
again" script did just that. My quick "fix" was to 'make clean' before
configure, not after (which sucks, too).

[...]
> 
> Fixes: 4f2813a313ae ("build: Include generated man pages in dist tarball")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>

Acked-by: Phil Sutter <phil@nwl.cc>
