Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD98200B0F
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jun 2020 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbgFSOMC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jun 2020 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732611AbgFSOMB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:12:01 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB8BC06174E
        for <netfilter-devel@vger.kernel.org>; Fri, 19 Jun 2020 07:12:01 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1jmHkL-0006cC-GC; Fri, 19 Jun 2020 16:11:57 +0200
Date:   Fri, 19 Jun 2020 16:11:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: iptables user space performance benchmarks published
Message-ID: <20200619141157.GU23632@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

I remember you once asked for the benchmark scripts I used to compare
performance of iptables-nft with -legacy in terms of command overhead
and caching, as detailed in a blog[1] I wrote about it. I meanwhile
managed to polish the scripts a bit and push them into a public repo,
accessible here[2]. I'm not sure whether they are useful for regular
runs (or even CI) as a single run takes a few hours and parallel use
likely kills result precision.

Cheers, Phil

[1] https://developers.redhat.com/blog/2020/04/27/optimizing-iptables-nft-large-ruleset-performance-in-user-space/
[2] http://nwl.cc/cgi-bin/git/gitweb.cgi?p=ipt-sbs-bench.git;a=summary
