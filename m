Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811C2299293
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Oct 2020 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786132AbgJZQgq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Oct 2020 12:36:46 -0400
Received: from correo.us.es ([193.147.175.20]:45190 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785979AbgJZQgp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:36:45 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 015ED504C23
        for <netfilter-devel@vger.kernel.org>; Mon, 26 Oct 2020 17:36:44 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E6EB3DA78E
        for <netfilter-devel@vger.kernel.org>; Mon, 26 Oct 2020 17:36:43 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DC591DA730; Mon, 26 Oct 2020 17:36:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CC38DDA78E;
        Mon, 26 Oct 2020 17:36:41 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 26 Oct 2020 17:36:41 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AE33A4301DE2;
        Mon, 26 Oct 2020 17:36:41 +0100 (CET)
Date:   Mon, 26 Oct 2020 17:36:41 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH 3/3] nft: Fix for concurrent noflush restore
 calls
Message-ID: <20201026163641.GA31480@salvia>
References: <20201005144858.11578-1-phil@nwl.cc>
 <20201005144858.11578-4-phil@nwl.cc>
 <20201012125450.GA26934@salvia>
 <20201013100803.GW13016@orbyte.nwl.cc>
 <20201013101502.GA29142@salvia>
 <20201014094640.GA13016@orbyte.nwl.cc>
 <20201016152850.GA1416@salvia>
 <20201026163102.GB5098@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026163102.GB5098@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:31:02PM +0100, Phil Sutter wrote:
> On Fri, Oct 16, 2020 at 05:28:50PM +0200, Pablo Neira Ayuso wrote:
> [...]
> > Makes sense. Thanks a lot for explaining. Probably you can include
> > this in the commit description for the record.
> > 
> > > I realize the test case is not quite effective, ruleset should be
> > > emptied upon each iteration of concurrent restore job startup.
> > 
> > Please, update the test and revamp.
> 
> I pushed the commit already when you wrote "LGTM" in your first reply,
> sorry. Yet to cover for the above, I just submitted a patch which adds a
> bit of documentation to the test case (apart from improving its
> effectiveness).

No problem. Thanks for following up.
