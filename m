Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9185350881
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Mar 2021 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhCaUwM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Mar 2021 16:52:12 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48998 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCaUvz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:51:55 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 55F8963E47;
        Wed, 31 Mar 2021 22:51:39 +0200 (CEST)
Date:   Wed, 31 Mar 2021 22:51:51 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: iptables-nft fails to restore huge rulesets
Message-ID: <20210331205151.GA4773@salvia>
References: <20210331091331.GE7863@orbyte.nwl.cc>
 <20210331133510.GF17285@breakpoint.cc>
 <20210331144140.GV3158@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210331144140.GV3158@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Mar 31, 2021 at 04:41:40PM +0200, Phil Sutter wrote:
> On Wed, Mar 31, 2021 at 03:35:10PM +0200, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > I'm currently trying to fix for an issue in Kubernetes realm[1]:
> > > Baseline is they are trying to restore a ruleset with ~700k lines and it
> > > fails. Needless to say, legacy iptables handles it just fine.
> > > 
> > > Meanwhile I found out there's a limit of 1024 iovecs when submitting the
> > > batch to kernel, and this is what they're hitting.
> > > 
> > > I can work around that limit by increasing each iovec (via
> > > BATCH_PAGE_SIZE) but keeping pace with legacy seems ridiculous:
> > > 
> > > With a scripted binary-search I checked the maximum working number of
> > > restore items of:
> > > 
> > > (1) User-defined chains
> > > (2) rules with merely comment match present
> > > (3) rules matching on saddr, daddr, iniface and outiface
> > > 
> > > Here's legacy compared to nft with different factors in BATCH_PAGE_SIZE:
> > > 
> > > legacy		32 (stock)	  64		   128          256
> > > ----------------------------------------------------------------------
> > > 1'636'799	1'602'202	- NC -		  - NC -       - NC -
> > > 1'220'159	  302'079	604'160		1'208'320      - NC -
> > > 3'532'040	  242'688	485'376		  971'776    1'944'576
> > 
> > Can you explain that table? What does 1'636'799 mean? NC?
> 
> Ah, sorry: NC is "not care", I didn't consider those numbers relevant
> given that iptables-nft has caught up to legacy previously already.
> 
> 1'636'799 is the max number of user-defined chains I can successfully
> restore using iptables-legacy-restore. Looks like I dropped the rows'
> description while reformatting by accident: the first row of that table
> corresponds with test (1), second with test (2) and third with test (3).
> 
> So legacy may restore at once ~1.6M chains or ~1.2M comment rules or
> ~3.5M rules with {s,d}{addr,iface} matches.
> 
> The following columns are for iptables-nft with varying BATCH_PAGE_SIZE
> values. Each of the (max 1024) iovecs passed to kernel via sendmsg() is
> 'N * getpagesize()' large.

Did you measure any slow down in the ruleset load time after selecting
a larger batch chunk size?
