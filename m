Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051DA7B06BE
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Sep 2023 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjI0O3F (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Sep 2023 10:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjI0O3F (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:29:05 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F8F9
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Sep 2023 07:29:03 -0700 (PDT)
Received: from [78.30.34.192] (port=52858 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlVXA-00Cs2e-4W; Wed, 27 Sep 2023 16:29:02 +0200
Date:   Wed, 27 Sep 2023 16:28:58 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 1/3] nft: add NFT_ARRAY_SIZE() helper
Message-ID: <ZRQ8Kki2ABsS+JPL@calendula>
References: <20230927122744.3434851-1-thaller@redhat.com>
 <20230927122744.3434851-2-thaller@redhat.com>
 <6298b85f20f868e97e1465f06d7e68139b57aca8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6298b85f20f868e97e1465f06d7e68139b57aca8.camel@redhat.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 27, 2023 at 04:24:19PM +0200, Thomas Haller wrote:
> On Wed, 2023-09-27 at 14:23 +0200, Thomas Haller wrote:
> > Add NFT_ARRAY_SIZE() macro, commonly known as ARRAY_SIZE() (or
> > G_N_ELEMENTS()).
> > 
> > <nft.h> is the right place for macros and static-inline functions. It
> > is
> > included in *every* C sources, as it only depends on libc headers and
> > <config.h>. NFT_ARRAY_SIZE() is part of the basic toolset, that
> > should
> > be available everywhere.
> > 
> > Signed-off-by: Thomas Haller <thaller@redhat.com>
> > ---
> >  include/nft.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/nft.h b/include/nft.h
> > index 9384054c11c8..4463b5c0fa4a 100644
> > --- a/include/nft.h
> > +++ b/include/nft.h
> > @@ -8,4 +8,6 @@
> >  #include <stdint.h>
> >  #include <stdlib.h>
> >  
> > +#define NFT_ARRAY_SIZE(arr) (sizeof(arr)/sizeof((arr)[0]))
> > +
> >  #endif /* NFTABLES_NFT_H */
> 
> oh, I just found the "array_size()" macro. Didn't expect it to be
> lower-case.
> 
> Will use that in v2.

If you read this before you post v2, then for this oneliner, I'd
suggest to squash it where it is used for the first time, otherwise it
is fine, not a deal breaker.
