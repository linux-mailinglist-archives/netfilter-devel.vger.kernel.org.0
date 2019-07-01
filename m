Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAC648A05
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 19:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfFQRYi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 13:24:38 -0400
Received: from mail.us.es ([193.147.175.20]:57732 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfFQRYi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:24:38 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2F40EDC9A9
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 19:24:36 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 201FCDA70A
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 19:24:36 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 15ADDDA709; Mon, 17 Jun 2019 19:24:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 129EFDA701;
        Mon, 17 Jun 2019 19:24:34 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 17 Jun 2019 19:24:34 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DFA924265A31;
        Mon, 17 Jun 2019 19:24:33 +0200 (CEST)
Date:   Mon, 17 Jun 2019 19:24:33 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        fw@strlen.de
Subject: Re: [PATCH nft 3/5] src: add cache level flags
Message-ID: <20190617172433.4bbyykwagxblwn4k@salvia>
References: <20190617122518.10486-1-pablo@netfilter.org>
 <20190617122518.10486-3-pablo@netfilter.org>
 <20190617161104.GT31548@orbyte.nwl.cc>
 <20190617162840.pqeyndnjwh4amzwx@salvia>
 <20190617164559.GV31548@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617164559.GV31548@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:45:59PM +0200, Phil Sutter wrote:
> On Mon, Jun 17, 2019 at 06:28:40PM +0200, Pablo Neira Ayuso wrote:
> > On Mon, Jun 17, 2019 at 06:11:04PM +0200, Phil Sutter wrote:
> > > Hi,
> > > 
> > > On Mon, Jun 17, 2019 at 02:25:16PM +0200, Pablo Neira Ayuso wrote:
[...]
> > 
> > We need these for references to sets, eg.
> > 
> >         add rule x y ip saddr @x
> > 
> > same for other flowtable and object.
> 
> Oh, right. I got that wrong - old code is always fetching the above
> items unless there's no ruleset in kernel (i.e., returned genid is 0).
> 
> I confused that with fetching rules which at some point started to
> happen by accident with my changes.
> 
> > We should not use NFT_CACHE_RULE in this case, if this is what you
> > suggest.
> 
> No, quite the opposite: I thought we could get by without fetching
> anything from kernel at all.
> 
> Yet now I wonder why the handle guessing stops working, because the
> above can't be the cause of it.

I think we should partial revert the changes that are doing the
handle guessing, would you submit a patch for this?

Thanks!
