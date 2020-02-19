Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C33F416408B
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Feb 2020 10:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgBSJk2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Feb 2020 04:40:28 -0500
Received: from correo.us.es ([193.147.175.20]:37604 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgBSJk2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:40:28 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E7234EFC88
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 10:32:12 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D8B15DA3A0
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 10:32:12 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id CE4D0DA38F; Wed, 19 Feb 2020 10:32:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 04388DA736;
        Wed, 19 Feb 2020 10:32:11 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 19 Feb 2020 10:32:11 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D66A842EF4E0;
        Wed, 19 Feb 2020 10:32:10 +0100 (CET)
Date:   Wed, 19 Feb 2020 10:32:10 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH] src: Fix nftnl_assert() on data_len
Message-ID: <20200219093210.qihfks66qvfak5th@salvia>
References: <20200214173247.2wbrvcqilqfmcqq5@salvia>
 <20200214173450.GR20005@orbyte.nwl.cc>
 <20200214174200.4xrvnlb72qebtvnb@salvia>
 <20200215004311.GS20005@orbyte.nwl.cc>
 <20200215131713.5gwn4ayk2udjff33@salvia>
 <20200215225855.GU20005@orbyte.nwl.cc>
 <20200218134227.yndixbtxjzq3jznk@salvia>
 <20200218181851.GC20005@orbyte.nwl.cc>
 <20200218210611.4woiwhndyc35rzoz@salvia>
 <20200218230239.GE20005@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218230239.GE20005@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 19, 2020 at 12:02:39AM +0100, Phil Sutter wrote:
> Hi Pablo,
> 
> On Tue, Feb 18, 2020 at 10:06:11PM +0100, Pablo Neira Ayuso wrote:
> [...]
> > If I apply the patch that I'm attaching, then I use the wrong datatype
> > helper:
> > 
> >         nftnl_flowtable_get_u32(nlo, NFTNL_FLOWTABLE_DEVICES);
> > 
> > And I can see:
> > 
> > libnftnl: attribute 6 assertion failed in flowtable.c:274
> 
> Yes, that was what I meant with alternative (simpler) approach. Should I
> submit this change formally or do you want to do it?

Please submit and push it out, thanks.
