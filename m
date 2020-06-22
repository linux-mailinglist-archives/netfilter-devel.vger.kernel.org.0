Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01720370D
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2020 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgFVMmN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jun 2020 08:42:13 -0400
Received: from correo.us.es ([193.147.175.20]:40866 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbgFVMmM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:42:12 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A826BB6329
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jun 2020 14:42:10 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9A958DA78D
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jun 2020 14:42:10 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8FE2EDA78C; Mon, 22 Jun 2020 14:42:10 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 21E29DA78E;
        Mon, 22 Jun 2020 14:42:08 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 22 Jun 2020 14:42:08 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 05D9E42EF4E1;
        Mon, 22 Jun 2020 14:42:07 +0200 (CEST)
Date:   Mon, 22 Jun 2020 14:42:07 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: iptables user space performance benchmarks published
Message-ID: <20200622124207.GA25671@salvia>
References: <20200619141157.GU23632@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619141157.GU23632@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Fri, Jun 19, 2020 at 04:11:57PM +0200, Phil Sutter wrote:
> Hi Pablo,
> 
> I remember you once asked for the benchmark scripts I used to compare
> performance of iptables-nft with -legacy in terms of command overhead
> and caching, as detailed in a blog[1] I wrote about it. I meanwhile
> managed to polish the scripts a bit and push them into a public repo,
> accessible here[2]. I'm not sure whether they are useful for regular
> runs (or even CI) as a single run takes a few hours and parallel use
> likely kills result precision.

So what is the _technical_ incentive for using the iptables blob
interface (a.k.a. legacy) these days then?

The iptables-nft frontend is transparent and it outperforms the legacy
code for dynamic rulesets.

Thanks.

> [1] https://developers.redhat.com/blog/2020/04/27/optimizing-iptables-nft-large-ruleset-performance-in-user-space/
> [2] http://nwl.cc/cgi-bin/git/gitweb.cgi?p=ipt-sbs-bench.git;a=summary
