Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17FA45D44
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Jun 2019 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfFNM7P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 Jun 2019 08:59:15 -0400
Received: from mail.us.es ([193.147.175.20]:59988 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbfFNM7P (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:59:15 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 35469819A2
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Jun 2019 14:59:13 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 26AE6DA70C
        for <netfilter-devel@vger.kernel.org>; Fri, 14 Jun 2019 14:59:13 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1C5BCDA70A; Fri, 14 Jun 2019 14:59:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2788EDA701;
        Fri, 14 Jun 2019 14:59:11 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 14 Jun 2019 14:59:11 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 037F94265A31;
        Fri, 14 Jun 2019 14:59:10 +0200 (CEST)
Date:   Fri, 14 Jun 2019 14:59:10 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        fw@strlen.de
Subject: Re: [PATCH nft,v2] cache: do not populate the cache in case of flush
 ruleset command
Message-ID: <20190614125910.zlpbor35toz6ewgp@salvia>
References: <20190614123630.17341-1-pablo@netfilter.org>
 <20190614125432.GO31548@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614125432.GO31548@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:54:32PM +0200, Phil Sutter wrote:
> Hi Pablo,
> 
> On Fri, Jun 14, 2019 at 02:36:30PM +0200, Pablo Neira Ayuso wrote:
> > __CMD_FLUSH_RULESET is a dummy definition that used to skip the netlink
> > dump to populate the cache. This patch is a workaround until we have a
> > better infrastructure to track the state of the cache objects.
> 
> I assumed the problem wouldn't exist anymore since we're populating the
> cache just once. Can you maybe elaborate a bit on the problem you're
> trying to solve with that workaround?

If nft segfaults to dump the cache, 'nft flush ruleset' will not work
since it always fetches the cache, it will segfault too.

The flush ruleset command was still dumping the cache before this
patch.
