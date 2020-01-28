Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7386214BD24
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jan 2020 16:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgA1PmW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jan 2020 10:42:22 -0500
Received: from correo.us.es ([193.147.175.20]:35992 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgA1PmW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:42:22 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E66D8F258A
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 16:42:20 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D6387DA710
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 16:42:20 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C7ECDDA705; Tue, 28 Jan 2020 16:42:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CDCC4DA710;
        Tue, 28 Jan 2020 16:42:18 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Jan 2020 16:42:18 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AE34342EF4E1;
        Tue, 28 Jan 2020 16:42:18 +0100 (CET)
Date:   Tue, 28 Jan 2020 16:42:17 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [nft PATCH 4/4] segtree: Refactor ei_insert()
Message-ID: <20200128154217.zfnlvtriz575i4bb@salvia>
References: <20200123143049.13888-1-phil@nwl.cc>
 <20200123143049.13888-5-phil@nwl.cc>
 <20200128122312.2mhlwu45p6jalfsn@salvia>
 <20200128141416.GI28318@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128141416.GI28318@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jan 28, 2020 at 03:14:16PM +0100, Phil Sutter wrote:
> Hi Pablo,
> 
> On Tue, Jan 28, 2020 at 01:23:12PM +0100, Pablo Neira Ayuso wrote:
> > On Thu, Jan 23, 2020 at 03:30:49PM +0100, Phil Sutter wrote:
> [...]
> > > +	if (!merge) {
> > > +		errno = EEXIST;
> > > +		return expr_binary_error(msgs, lei->expr, new->expr,
> > > +					 "conflicting intervals specified");
> > >  	}
> > 
> > Not your fault, but I think this check is actually useless given that
> > the overlap check happens before (unless you consider to consolidate
> > the insertion and the overlap checks in ei_insert).
> 
> That's interesting, indeed. What's more interesting is how
> interval_cmp() works: I assumed it would just sort by start element when
> in fact interval size is the prominent aspect.

I overlook that this is ordered by the size.

> In practice, this means my changes work only as long as all
> intervals are of equal or decreasing size. Does it make sense to
> uphold this ordering scheme?

I think if you change the ordering scheme to use the left side
(instead of the size) your new logic will work fine. It will also make
it probably easier to check for overlaps in the end.
