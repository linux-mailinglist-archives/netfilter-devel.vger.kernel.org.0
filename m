Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046482BBEEB
	for <lists+netfilter-devel@lfdr.de>; Sat, 21 Nov 2020 13:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgKUMbn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 21 Nov 2020 07:31:43 -0500
Received: from correo.us.es ([193.147.175.20]:58790 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgKUMbn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:31:43 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1AB34E8E90
        for <netfilter-devel@vger.kernel.org>; Sat, 21 Nov 2020 13:31:41 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0DC3ADA792
        for <netfilter-devel@vger.kernel.org>; Sat, 21 Nov 2020 13:31:41 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 022D6DA78C; Sat, 21 Nov 2020 13:31:41 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D5AC4DA722;
        Sat, 21 Nov 2020 13:31:38 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 21 Nov 2020 13:31:38 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B4BC24265A5A;
        Sat, 21 Nov 2020 13:31:38 +0100 (CET)
Date:   Sat, 21 Nov 2020 13:31:38 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Tobias Waldekranz <tobias@waldekranz.com>,
        netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, razor@blackwall.org, jeremy@azazel.net
Subject: Re: [PATCH net-next,v3 0/9] netfilter: flowtable bridge and vlan
 enhancements
Message-ID: <20201121123138.GA21560@salvia>
References: <20201111193737.1793-1-pablo@netfilter.org>
 <20201113175556.25e57856@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201114115906.GA21025@salvia>
 <87sg9cjaxo.fsf@waldekranz.com>
 <20201114090347.2e7c1457@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201116221815.GA6682@salvia>
 <20201116142844.7c492fb6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201116223615.GA6967@salvia>
 <20201116144521.771da0c6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201116225658.GA7247@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201116225658.GA7247@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:56:58PM +0100, Pablo Neira Ayuso wrote:
> On Mon, Nov 16, 2020 at 02:45:21PM -0800, Jakub Kicinski wrote:
> > On Mon, 16 Nov 2020 23:36:15 +0100 Pablo Neira Ayuso wrote:
> > > > Are you saying A -> B traffic won't match so it will update the cache,
> > > > since conntrack flows are bi-directional?  
> > > 
> > > Yes, Traffic for A -> B won't match the flowtable entry, this will
> > > update the cache.
> > 
> > That's assuming there will be A -> B traffic without B sending a
> > request which reaches A, first.
> 
> B might send packets to A but this will not get anywhere. Assuming
> TCP, this will trigger retransmissions so B -> A will kick in to
> refresh the entry.
> 
> Is this scenario that you describe a showstopper?

I have been discussing the topology update by tracking fdb updates
with the bridge maintainer, I'll be exploring extensions to the
existing fdb_notify() infrastructure to deal with this scenario you
describe. On my side this topology update scenario is not a priority
to be supported in this patchset, but it's feasible to support it
later on.
