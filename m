Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8448382
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFQNHo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 09:07:44 -0400
Received: from mail.us.es ([193.147.175.20]:35716 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfFQNHo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:07:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 76DA7C04A6
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 15:07:42 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 64F84DA701
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 15:07:42 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5A8DDDA706; Mon, 17 Jun 2019 15:07:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B978CDA70C;
        Mon, 17 Jun 2019 15:07:39 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 17 Jun 2019 15:07:39 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 95D484265A31;
        Mon, 17 Jun 2019 15:07:39 +0200 (CEST)
Date:   Mon, 17 Jun 2019 15:07:39 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        fw@strlen.de
Subject: Re: [PATCH nft,v2] cache: do not populate the cache in case of flush
 ruleset command
Message-ID: <20190617130739.g4ufcqoirh4azhd4@salvia>
References: <20190614123630.17341-1-pablo@netfilter.org>
 <20190614125432.GO31548@orbyte.nwl.cc>
 <20190614125910.zlpbor35toz6ewgp@salvia>
 <20190614130438.y6stvoi3ydz33s55@salvia>
 <20190614134124.GP31548@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614134124.GP31548@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Fri, Jun 14, 2019 at 03:41:24PM +0200, Phil Sutter wrote:
[...]
> On Fri, Jun 14, 2019 at 03:04:38PM +0200, Pablo Neira Ayuso wrote:
> > On Fri, Jun 14, 2019 at 02:59:10PM +0200, Pablo Neira Ayuso wrote:
> > > On Fri, Jun 14, 2019 at 02:54:32PM +0200, Phil Sutter wrote:
> > > > Hi Pablo,
> > > > 
> > > > On Fri, Jun 14, 2019 at 02:36:30PM +0200, Pablo Neira Ayuso wrote:
> > > > > __CMD_FLUSH_RULESET is a dummy definition that used to skip the netlink
> > > > > dump to populate the cache. This patch is a workaround until we have a
> > > > > better infrastructure to track the state of the cache objects.
> > > > 
> > > > I assumed the problem wouldn't exist anymore since we're populating the
> > > > cache just once. Can you maybe elaborate a bit on the problem you're
> > > > trying to solve with that workaround?
> > > 
> > > If nft segfaults to dump the cache, 'nft flush ruleset' will not work
> > > since it always fetches the cache, it will segfault too.
> > > 
> > > The flush ruleset command was still dumping the cache before this
> > > patch.
> > 
> > In general, we still need to improve the cache logic, to make it finer
> > grain. Now that we have a single point to populate the cache, things
> > will get more simple. We need to replace the cache command level to
> > cache flags or our own cache level definitions. The existing approach
> > that uses of commands to define the cache level completeness has its
> > own limitations. We can discuss this during the NFWS :-).
> 
> Yes, I had the same thought already. It is quite unintuitive how we link
> cache completeness to certain commands. :)

Just sent a follow up patch to introduce cache level flags [1]. The
existing approach is rather conservative in what we fetch from the
kernel (sometimes more than needed) but it should be possible to
review this logic incrementally.

> Regarding your problem, maybe cache_update() should exit immediately if
> passed cmd is CMD_INVALID? Unless I miss something, if cache_evaluate()
> returns that value, we don't need a cache at all.

Problem is that CMD_INVALID does not mean empty cache.

With the new cache level infrastructure, now there is a
NFT_CACHE_EMPTY that provides the semantics this workaround was
providing in a clearer way I think.

[1] https://patchwork.ozlabs.org/patch/1116973/
