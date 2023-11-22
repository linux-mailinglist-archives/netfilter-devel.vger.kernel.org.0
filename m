Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE47F44DA
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Nov 2023 12:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjKVLXH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Nov 2023 06:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjKVLXF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:23:05 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2132C18E
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Nov 2023 03:23:00 -0800 (PST)
Received: from [78.30.43.141] (port=50912 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r5lJn-00COyE-Om; Wed, 22 Nov 2023 12:22:58 +0100
Date:   Wed, 22 Nov 2023 12:22:54 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>,
        Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH nft v3 1/1] tests/shell: sanitize "handle" in JSON output
Message-ID: <ZV3kjlO+DmfWm9DH@calendula>
References: <ZVymYDwWLQBQUAAg@calendula>
 <20231121132331.3401846-1-thaller@redhat.com>
 <ZV3ZkD0Yi15ICNZT@calendula>
 <8a1e3a2451a770d49a9e130103b8a657e9c23c18.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a1e3a2451a770d49a9e130103b8a657e9c23c18.camel@redhat.com>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:44:54AM +0100, Thomas Haller wrote:
> On Wed, 2023-11-22 at 11:36 +0100, Pablo Neira Ayuso wrote:
> > On Tue, Nov 21, 2023 at 02:22:54PM +0100, Thomas Haller wrote:
> > > The "handle" in JSON output is not stable. Sanitize/normalize to
> > > zero.
> > > 
> > > Adjust the sanitize code, and regenerate the .json-nft files.
> > 
> > Applied, thanks.
> > 
> > I had to adjust a json dump, this diff is not so difficult:
> 
> Hi,
> 
> Hm. The json dump of the patch was generated.
> 
> If you had to "adjust" a dump, does that mean that the output is not
> stable?

I had to adjust json output after my recent series for 4.19 -stable
kernels:

https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=383354

(note I splitted a few tests there)

with your patch output looks stable now here after this patch with
different kernel versions, so all good, thanks!

> In that case, the .json-nft file should be removed instead (and the
> cause for the difference investigated, fixed, and the dump-re-added).

Agreed, but this different case as explained above.

BTW, I am intentionally missing .json-nft files in my series because I
am focusing on making progress on 4.19 backports, if you can help me
with with missing .json-nft that I am living on my way, I'd appreciate.
I promise to make a more careful look on missing .json-nft in the next
series.

Thanks.
