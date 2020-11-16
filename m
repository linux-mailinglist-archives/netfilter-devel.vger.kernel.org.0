Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353EA2B4C1A
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Nov 2020 18:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbgKPREo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Nov 2020 12:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKPREn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:04:43 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE96DC0613CF
        for <netfilter-devel@vger.kernel.org>; Mon, 16 Nov 2020 09:04:43 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kehvk-0007U2-QU; Mon, 16 Nov 2020 18:04:40 +0100
Date:   Mon, 16 Nov 2020 18:04:40 +0100
From:   Florian Westphal <fw@strlen.de>
To:     subashab@codeaurora.org
Cc:     Florian Westphal <fw@strlen.de>, pablo@netfilter.org,
        Sean Tranchetti <stranche@codeaurora.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] x_tables: Properly close read section with
 read_seqcount_retry
Message-ID: <20201116170440.GA26150@breakpoint.cc>
References: <1605320516-17810-1-git-send-email-stranche@codeaurora.org>
 <20201114165330.GM23619@breakpoint.cc>
 <2ab4bcb63cbacba12ad927621fb56aab@codeaurora.org>
 <20201116141810.GB22792@breakpoint.cc>
 <8256f40ba9b73181f121baafe12cac61@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8256f40ba9b73181f121baafe12cac61@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

subashab@codeaurora.org <subashab@codeaurora.org> wrote:
> > Is that to order wrt. seqcount_sequence?
> 
> Correct, we want to ensure that the table->private is updated and is
> in sync on all CPUs beyond that point.
> 
> > Do you have a way to reproduce such crashes?
> > 
> > I tried to no avail but I guess thats just because amd64 is more
> > forgiving.
> > 
> > Thanks!
> 
> Unfortunately we are seeing it on ARM64 regression systems which runs a
> variety of
> usecases so the exact steps are not known.

Ok.  Would you be willing to run some of those with your suggested
change to see if that resolves the crashes or is that so rare that this
isn't practical?
