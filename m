Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42C231E768
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Feb 2021 09:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhBRIZq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Feb 2021 03:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhBRIXF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:23:05 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAEBC061788;
        Thu, 18 Feb 2021 00:22:10 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lCeZb-0005qG-MU; Thu, 18 Feb 2021 09:22:07 +0100
Date:   Thu, 18 Feb 2021 09:22:07 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        netfilter-devel@vger.kernel.org, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, tgraf@infradead.org
Subject: Re: [PATCH ghak124 v3] audit: log nftables configuration change
 events
Message-ID: <20210218082207.GJ2766@breakpoint.cc>
References: <f9da8b5dbf2396b621c77c17b5b1123be5aa484e.1591275439.git.rgb@redhat.com>
 <20210211151606.GX3158@orbyte.nwl.cc>
 <CAHC9VhTNQW9d=8GCW-70vAEMh8-LXviP+JHFC2-YkuitokLLMQ@mail.gmail.com>
 <20210211202628.GP2015948@madcap2.tricolour.ca>
 <20210211220930.GC2766@breakpoint.cc>
 <20210217234131.GN3141668@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217234131.GN3141668@madcap2.tricolour.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2021-02-11 23:09, Florian Westphal wrote:
> > So, if just a summary is needed a single audit_log_nfcfg()
> > after 'step 3' and outside of the list_for_each_entry_safe() is all
> > that is needed.
> 
> Ok, so it should not matter if it is before or after that
> list_for_each_entry_safe(), which could be used to collect that summary.

Right, it won't matter.

> > If a summary is wanted as well one could fe. count the number of
> > transaction types in the batch, e.g. table adds, chain adds, rule
> > adds etc. and then log a summary count instead.
> 
> The current fields are "table", "family", "entries", "op".
> 
> Could one batch change more than one table?  (I think it could?)

Yes.

> It appears it can change more than one family.
> "family" is currently a single integer, so that might need to be changed
> to a list, or something to indicate multi-family.

Yes, it can also affect different families.

> Listing all the ops seems a bit onerous.  Is there a hierarchy to the
> ops and if so, are they in that order in a batch or in nf_tables_commit()?

No.  There is a hierarchy, e.g. you can't add a chain without first
adding a table, BUT in case the table was already created by an earlier
transaction it can also be stand-alone.

> It seems I'd need to filter out the NFT_MSG_GET_* ops.

No need, the GET ops do not cause changes and will not trigger a
generation id change.
