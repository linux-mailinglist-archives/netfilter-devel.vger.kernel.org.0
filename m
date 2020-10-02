Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD172812A5
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Oct 2020 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBM2y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Oct 2020 08:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgJBM2y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:28:54 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D634C0613D0
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Oct 2020 05:28:54 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kOKBA-0000RF-Lj; Fri, 02 Oct 2020 14:28:52 +0200
Date:   Fri, 2 Oct 2020 14:28:52 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Arturo Borrero Gonzalez <arturo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] iptables-nft: fix basechain policy configuration
Message-ID: <20201002122852.GC29050@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Arturo Borrero Gonzalez <arturo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <160163907669.18523.7311010971070291883.stgit@endurance>
 <20201002120732.GB29050@orbyte.nwl.cc>
 <20201002121558.GA1367@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002121558.GA1367@salvia>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:15:58PM +0200, Pablo Neira Ayuso wrote:
> On Fri, Oct 02, 2020 at 02:07:32PM +0200, Phil Sutter wrote:
> > Hi,
> > 
> > On Fri, Oct 02, 2020 at 01:44:36PM +0200, Arturo Borrero Gonzalez wrote:
> > > Previous to this patch, the basechain policy could not be properly configured if it wasn't
> > > explictly set when loading the ruleset, leading to iptables-nft-restore (and ip6tables-nft-restore)
> > > trying to send an invalid ruleset to the kernel.
> > 
> > I fear this is not sufficient: iptables-legacy-restore leaves the
> > previous chain policy in place if '-' is given in dump file. Please try
> > this snippet from a testcase I wrote:
> > 
> > $XT_MULTI iptables -P FORWARD DROP
> > 
> > diff -u -Z <($XT_MULTI iptables-save | grep '^:FORWARD') \
> >            <(echo ":FORWARD DROP [0:0]")
> > 
> > $XT_MULTI iptables-restore -c <<< "$TEST_RULESET"
> > diff -u -Z <($XT_MULTI iptables-save | grep '^:FORWARD') \
> >            <(echo ":FORWARD DROP [0:0]")
> 
> Hm, this is how it works in this patch right?
> 
> I mean, if '-' is given, chain policy attribute in the netlink message
> is not set, and the kernel sets chain policy to
> NFT_CHAIN_POLICY_UNSET.
> 
> Or am I missing anything?

This is *flushing* iptables-restore. We're dropping the chain first and
then reinstall it.

Another quirk is that iptables-legacy-restore ignores the counters if
policy is '-' even if --counters flag was given. (:

Cheers, Phil
