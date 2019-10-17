Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD6DA7F4
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404051AbfJQJDk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 05:03:40 -0400
Received: from correo.us.es ([193.147.175.20]:35190 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbfJQJDk (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:03:40 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3CD4C1694C5
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Oct 2019 11:03:36 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2562F21FE5
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Oct 2019 11:03:36 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5D1B7A7D6E; Thu, 17 Oct 2019 11:03:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E6E98A7D6C;
        Thu, 17 Oct 2019 11:03:32 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 17 Oct 2019 11:03:32 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AE45C4251483;
        Thu, 17 Oct 2019 11:03:32 +0200 (CEST)
Date:   Thu, 17 Oct 2019 11:03:32 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v4 0/8] Improve iptables-nft performance with
 large rulesets
Message-ID: <20191017090332.erwubv7pzxbbowjg@salvia>
References: <20191015114152.25254-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015114152.25254-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:41:44PM +0200, Phil Sutter wrote:
> Fourth try at caching optimizations implementation.
> 
> Changes since v3:
> 
> * Rebase onto current master after pushing the accepted initial three
>   patches.
> * Avoid cache inconsistency in __nft_build_cache() if kernel ruleset
>   changed since last call.

I still hesitate with this cache approach.

Can this deal with this scenario? Say you have a ruleset composed on N
rules.

* Rule 1..M starts using generation X for the evaluation, they pass
  OK.

* Generation is bumped.

* Rule M..N is evaluated with a diferent cache.

So the ruleset evaluation is inconsistent itself since it is based on
different caches for each rule in the batch.
