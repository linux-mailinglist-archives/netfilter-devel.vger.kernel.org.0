Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3DE28854E
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Oct 2020 10:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbgJIIbP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Oct 2020 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbgJIIbP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:31:15 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8BEC0613D2
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Oct 2020 01:31:15 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kQno1-0007i1-Ix; Fri, 09 Oct 2020 10:31:13 +0200
Date:   Fri, 9 Oct 2020 10:31:13 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Gopal Yadav <gopunop@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] Solves Bug 1462 - `nft -j list set` does not show
 counters
Message-ID: <20201009083113.GE13016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Gopal Yadav <gopunop@gmail.com>, netfilter-devel@vger.kernel.org
References: <20201007140337.21218-1-gopunop@gmail.com>
 <20201008170245.GC13016@orbyte.nwl.cc>
 <CAAUOv8hXEA=2fM5UBN8xGkquO9EHMzCQ=kdEyFukDK7zPSeXow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAUOv8hXEA=2fM5UBN8xGkquO9EHMzCQ=kdEyFukDK7zPSeXow@mail.gmail.com>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:15:48AM +0530, Gopal Yadav wrote:
> On Thu, Oct 8, 2020 at 10:32 PM Phil Sutter <phil@nwl.cc> wrote:
> >
> > On Wed, Oct 07, 2020 at 07:33:37PM +0530, Gopal Yadav wrote:
> > > Solves Bug 1462 - `nft -j list set` does not show counters
> > >
> > > Signed-off-by: Gopal Yadav <gopunop@gmail.com>
> >
> > Added a comment about potential clashes (json_object_update_missing()
> > hides those) and replaced the duplicate subject line by a commit
> > message, then applied the result.
> 
> Any description of those potential clashes?

AFAICT, none are possible right now. Though the design allows for it and
we might miss that.

Cheers, Phil
