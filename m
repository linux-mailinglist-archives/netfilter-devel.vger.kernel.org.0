Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4FA4FF94F
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Apr 2022 16:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiDMOt3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 13 Apr 2022 10:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDMOt3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:49:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4CD963BC6
        for <netfilter-devel@vger.kernel.org>; Wed, 13 Apr 2022 07:47:07 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:47:04 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft,v4 7/7] intervals: support to partial deletion with
 automerge
Message-ID: <YlbiaMsD63Hr5hmM@salvia>
References: <20220412144711.93354-1-pablo@netfilter.org>
 <20220412144711.93354-8-pablo@netfilter.org>
 <YlbICmqkYDsWN7NY@orbyte.nwl.cc>
 <YlbMeumfFKKM23ZV@salvia>
 <YlbYBfBmt3Ahptoc@orbyte.nwl.cc>
 <Ylbduy44WgQSI2o9@salvia>
 <YlbgSp+Y+gbaNEDQ@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlbgSp+Y+gbaNEDQ@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:38:02PM +0200, Phil Sutter wrote:
> On Wed, Apr 13, 2022 at 04:27:07PM +0200, Pablo Neira Ayuso wrote:
> [...]
> > > The one with EXPR_F_REMOVE comes *after* the one to be removed, right?
> > 
> > Right, the other way around actually.
> > 
> > > My question again: Is it possible for 'prev' to have EXPR_F_REMOVE set?
> > > Maybe I miss something, but to me it looks like not although the code
> > > expects it.
> > 
> > prev never has EXPR_F_REMOVE, so it points to an existing element.
> 
> So below change should be fine?

Wait.

> diff --git a/src/intervals.c b/src/intervals.c
> index 451bc4dd4dd45..c0077c06880ff 100644
> --- a/src/intervals.c
> +++ b/src/intervals.c
[...]
> @@ -360,18 +358,15 @@ static int setelem_adjust(struct set *set, struct expr *add, struct expr *purge,
>  {
>  	if (mpz_cmp(prev_range->low, range->low) == 0 &&
>  	    mpz_cmp(prev_range->high, range->high) > 0) {
> -		if (!(prev->flags & EXPR_F_REMOVE) &&
> -		    i->flags & EXPR_F_REMOVE)
> +		if (i->flags & EXPR_F_REMOVE)

This chunk is not correct.

User might ask to delete an element which does not exist.

Then, you might find two consecutive EXPR_F_REMOVE.

Only the initial chunk in this patch is fine.
