Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1255B653EFD
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Dec 2022 12:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiLVLXe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 22 Dec 2022 06:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiLVLXc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:23:32 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABE801FFA0
        for <netfilter-devel@vger.kernel.org>; Thu, 22 Dec 2022 03:23:31 -0800 (PST)
Date:   Thu, 22 Dec 2022 12:23:28 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] scanner: treat invalid octal strings as strings
Message-ID: <Y6Q+MJsfUe5oxkTF@salvia>
References: <20221216202714.1413699-1-jeremy@azazel.net>
 <Y6Qzq48e+ihIf4La@salvia>
 <Y6Q3AUkBrNbB2JBO@salvia>
 <Y6Q5PIB5ZIXFpJ40@celephais.dreamlands>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6Q5PIB5ZIXFpJ40@celephais.dreamlands>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:02:20AM +0000, Jeremy Sowden wrote:
> On 2022-12-22, at 11:52:49 +0100, Pablo Neira Ayuso wrote:
> > On Thu, Dec 22, 2022 at 11:38:39AM +0100, Pablo Neira Ayuso wrote:
> > > On Fri, Dec 16, 2022 at 08:27:14PM +0000, Jeremy Sowden wrote:
> > [...]
> > > > We get:
> > > > 
> > > >   $ sudo ./src/nft -f - <<<'
> > > >   > table x {
> > > >   >   chain y {
> > > >   >     ip saddr 0308 continue comment "error"
> > > >   >   }
> > > >   > }
> > > >   > '
> > > >   /dev/stdin:4:14-17: Error: Could not resolve hostname: Name or service not known
> > > >       ip saddr 0308 continue comment "error"
> > > >                ^^^^
> > > > 
> > > > Add a test-case.
> > > 
> > > Applied, thanks.
> > > 
> > > I am sorry I missed this patch before the release.
> > 
> > Hm. I thought this patch just fixes the parsing of octals.
> >
> > iptables and iproute seem to support for octals?
> 
> So does nft.  However, 0308 is not valid octal, and nft was silently
> truncating it to 030.
> 
> For hex and decimal, we know that the entire number string is valid in
> the base and only have to worry whether it is too long and may result in
> a out-of-range error.  For octal, there is also the possibility that the
> string may contain 8 or 9.  This patch adds a check for this and if the
> check fails the failure is handled as an error in the same way it would
> be if strtoull had reported `ERANGE`.
> 
> I did consider adding an `{octalstring}` match to handle octal
> separately from decimal, but in the end the solution in this patch
> seemed simpler.

Oh well, thanks for explaining, patch is applied.
