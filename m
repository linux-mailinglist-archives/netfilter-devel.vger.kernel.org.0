Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC87DF89D
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Nov 2023 18:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjKBRX3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Nov 2023 13:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKBRX3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:23:29 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0BD123
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Nov 2023 10:23:23 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qybPd-0007aG-T8; Thu, 02 Nov 2023 18:23:21 +0100
Date:   Thu, 2 Nov 2023 18:23:21 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tproxy: Drop artificial port printing restriction
Message-ID: <ZUPbCSg6rW8yYRVW@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20231102135258.17214-1-phil@nwl.cc>
 <ZUPGsLWmneAY6QGF@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUPGsLWmneAY6QGF@calendula>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 02, 2023 at 04:56:32PM +0100, Pablo Neira Ayuso wrote:
> On Thu, Nov 02, 2023 at 02:52:58PM +0100, Phil Sutter wrote:
> > It does not make much sense to omit printing the port expression if it's
> > not a value expression: On one hand, input allows for more advanced
> > uses. On the other, if it is in-kernel, best nft can do is to try and
> > print it no matter what. Just ignoring ruleset elements can't be
> > correct.
> > 
> > Fixes: 2be1d52644cf7 ("src: Add tproxy support")
> > Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1721
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> 
> Great work Phil.

Hey, I'm just deleting code which gets in the way. ;)

> Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

Patch applied, thanks for your review.
