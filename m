Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A0E31EA6B
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Feb 2021 14:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhBRNWd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Feb 2021 08:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhBRMyQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:54:16 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760AC061788;
        Thu, 18 Feb 2021 04:52:50 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lCinY-0006mx-FH; Thu, 18 Feb 2021 13:52:48 +0100
Date:   Thu, 18 Feb 2021 13:52:48 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        netfilter-devel@vger.kernel.org, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, tgraf@infradead.org
Subject: Re: [PATCH ghak124 v3] audit: log nftables configuration change
 events
Message-ID: <20210218125248.GB22944@breakpoint.cc>
References: <f9da8b5dbf2396b621c77c17b5b1123be5aa484e.1591275439.git.rgb@redhat.com>
 <20210211151606.GX3158@orbyte.nwl.cc>
 <CAHC9VhTNQW9d=8GCW-70vAEMh8-LXviP+JHFC2-YkuitokLLMQ@mail.gmail.com>
 <20210211202628.GP2015948@madcap2.tricolour.ca>
 <20210211220930.GC2766@breakpoint.cc>
 <20210217234131.GN3141668@madcap2.tricolour.ca>
 <20210218082207.GJ2766@breakpoint.cc>
 <20210218124211.GO3141668@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218124211.GO3141668@madcap2.tricolour.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2021-02-18 09:22, Florian Westphal wrote:
> > No.  There is a hierarchy, e.g. you can't add a chain without first
> > adding a table, BUT in case the table was already created by an earlier
> > transaction it can also be stand-alone.
> 
> Ok, so there could be a stand-alone chain mod with one table, then a
> table add of a different one with a "higher ranking" op...

Yes, that can happen.

> > > It seems I'd need to filter out the NFT_MSG_GET_* ops.
> > 
> > No need, the GET ops do not cause changes and will not trigger a
> > generation id change.
> 
> Ah, so it could trigger on generation change.  Would GET ops be included
> in any other change

No, GET ops are standalone, they cannot be part of a transaction.
If you look at

static const struct nfnl_callback nf_tables_cb[NFT_MSG_MAX] = {

array in nf_tables_api.c, then those ops with a '.call_batch' can
appear in transaction (i.e., can cause modification).

The other ones (.call_rcu) are read-only.

If they appear in a batch tehy will be ignored, if the batch consists of
such non-modifying ops only then nf_tables_commit() returns early
because the transaction list is empty (nothing to do/change).

> such that it would be desirable to filter them out
> to reduce noise in that single log line if it is attempted to list all
> the change ops?  It almost sounds like it would be better to do one
> audit log line for each table for each family, and possibly for each op
> to avoid the need to change userspace.  This would already be a
> significant improvement picking the highest ranking op.

I think i understand what you'd like to do.  Yes, that would reduce
the log output a lot.
