Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A896FDD11
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 May 2023 13:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbjEJLsI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 May 2023 07:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjEJLsH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 May 2023 07:48:07 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E783E30EF
        for <netfilter-devel@vger.kernel.org>; Wed, 10 May 2023 04:48:05 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pwiIb-0001gx-Q8; Wed, 10 May 2023 13:48:01 +0200
Date:   Wed, 10 May 2023 13:48:01 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] evaluate: Reject set stmt refs to sets without
 dynamic flag
Message-ID: <ZFuEcXxYCG9U9eMQ@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20230503105022.5728-1-phil@nwl.cc>
 <ZFt35MXmXZWxcb56@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFt35MXmXZWxcb56@calendula>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Wed, May 10, 2023 at 12:54:28PM +0200, Pablo Neira Ayuso wrote:
> On Wed, May 03, 2023 at 12:50:22PM +0200, Phil Sutter wrote:
> > This is a revert of commit 8d443adfcc8c1 ("evaluate: attempt to set_eval
> > flag if dynamic updates requested"), implementing the alternative
> > mentioned in the comment it added.
> > 
> > Reason is the inconsistent behaviour when applying the same ruleset
> > twice: In the first call, the set lacking 'dynamic' flag does not exist
> > and is therefore added to the cache. Consequently, both the 'add set'
> > command and the set statement point at the same set object. In the
> > second call, a set with same name exists already, so the object created
> > for 'add set' command is not added to cache and consequently not updated
> > with the missing flag. The kernel thus rejects the NEWSET request as the
> > existing set differs from the new one.
> 
> # cat test.nft
> flush ruleset

Just remove this 'flush ruleset' call, then it should trigger.

Cheers, Phil
