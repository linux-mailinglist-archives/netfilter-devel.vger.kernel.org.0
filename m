Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550CDE37C6
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Oct 2019 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391235AbfJXQXf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Oct 2019 12:23:35 -0400
Received: from correo.us.es ([193.147.175.20]:58998 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733261AbfJXQXe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:23:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AE86F1798A0
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 18:23:28 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9F67E66DF
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Oct 2019 18:23:28 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 942F5FB362; Thu, 24 Oct 2019 18:23:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4867AB7FFB;
        Thu, 24 Oct 2019 18:23:26 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 24 Oct 2019 18:23:26 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 173E942EE396;
        Thu, 24 Oct 2019 18:23:26 +0200 (CEST)
Date:   Thu, 24 Oct 2019 18:23:28 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 2/4] py: add missing output flags.
Message-ID: <20191024162328.m5l3sgwlm4wcjyjn@salvia>
References: <20191022205855.22507-1-jeremy@azazel.net>
 <20191022205855.22507-3-jeremy@azazel.net>
 <20191023203833.aidczbpuxokywu6i@salvia>
 <20191024092052.GP26123@orbyte.nwl.cc>
 <20191024093505.pup5mktqrdbriwpz@salvia>
 <20191024155639.GR26123@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024155639.GR26123@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 24, 2019 at 05:56:39PM +0200, Phil Sutter wrote:
> Hi,
> 
> On Thu, Oct 24, 2019 at 11:35:05AM +0200, Pablo Neira Ayuso wrote:
> > On Thu, Oct 24, 2019 at 11:20:52AM +0200, Phil Sutter wrote:
> > > Hi,
> > > 
> > > On Wed, Oct 23, 2019 at 10:38:33PM +0200, Pablo Neira Ayuso wrote:
> > > > On Tue, Oct 22, 2019 at 09:58:53PM +0100, Jeremy Sowden wrote:
> > > > > `terse` and `numeric_time` are missing from the `output_flags` dict.
> > > > > Add them and getters and setters for them.
> > > > 
> > > > LGTM.
> > > > 
> > > > @Phil, is this fine with you? I let you decide on this.
> > > 
> > > I just pushed it. Could you please update Patchwork? I'm not allowed to.
> > > 
> > > > BTW, would it make sense at some point to remove all the getter/setter
> > > > per option and use the setter/getter flags approach as in libnftables?
> > > 
> > > Well, from a compat standpoint we can't remove them. The benefit of
> > > those setter/getter methods is the clean interface (user's don't have to
> > > memorize flag names) and the semantics of returning the old value. The
> > > latter comes in handy when changing flags temporarily.
> > 
> > Probably some transitioning? ie. add the generic set/get flag
> > interface. Update clients of this (Eric's code) to use. Leave the old
> > interfaces for a while there to make sure people have time to migrate.
> > Then remove them.
> 
> Sounds good!
> 
> > Anyway, I'm fine if you prefer this more verbose interface for python,
> > no issue.
> 
> Main goal was to keep the bit-fiddling away from users, but a method
> which accepts an array of flag names (or flag values) and does the
> binary OR'ing should serve fine, too.

Good.

> > > One could change the private __{g,s}et_output_flag() methods though and
> > > make them similar to {g,s}et_debug() methods which probably resemble the
> > > syntax you're looking for.
> > 
> > Hm, not sure what you mean.
> 
> I was referring to get_debug() and set_debug() methods of class
> Nftables. The getter returns an array of debug flag names, the setter
> accepts either a single flag name/value or an array of those.

If that's the preferred way to do things in python, rather that using
flags like in C, that's fine with me.
