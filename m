Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8BA9242
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2019 21:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfIDTRX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Sep 2019 15:17:23 -0400
Received: from correo.us.es ([193.147.175.20]:35144 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbfIDTRX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:17:23 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C8CF4303D02
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Sep 2019 21:17:19 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BAAAEB7FF9
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Sep 2019 21:17:19 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B0301DA72F; Wed,  4 Sep 2019 21:17:19 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 73882D2B1F;
        Wed,  4 Sep 2019 21:17:17 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 04 Sep 2019 21:17:17 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 518704265A5A;
        Wed,  4 Sep 2019 21:17:17 +0200 (CEST)
Date:   Wed, 4 Sep 2019 21:17:18 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Eric Garver <eric@garver.life>
Subject: Re: [PATCH nft] tests: shell: check that rule add with index works
 with echo
Message-ID: <20190904191718.kzgbqdsgdjctqqli@salvia>
References: <20190903232713.14394-1-eric@garver.life>
 <20190904081337.GH25650@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904081337.GH25650@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 04, 2019 at 10:13:37AM +0200, Phil Sutter wrote:
> Pablo,
> 
> On Tue, Sep 03, 2019 at 07:27:13PM -0400, Eric Garver wrote:
> > If --echo is used the rule cache will not be populated. This causes
> > rules added using the "index" keyword to be simply appended to the
> > chain. The bug was introduced in commit 3ab02db5f836 ("cache: add
> > NFT_CACHE_UPDATE and NFT_CACHE_FLUSHED flags").
> > 
> > Signed-off-by: Eric Garver <eric@garver.life>
> > ---
> > I think the issue is in cache_evaluate(). It sets the flags to
> > NFT_CACHE_FULL and then bails early, but I'm not sure of the best way to
> > fix it. So I'll start by submitting a test case. :)
> 
> In 3ab02db5f836a ("cache: add NFT_CACHE_UPDATE and NFT_CACHE_FLUSHED
> flags"), you introduced NFT_CACHE_UPDATE to control whether
> rule_evaluate() should call rule_cache_update(), probably assuming the
> latter function merely changes cache depending on current command. In
> fact, this function also links rules if needed (see call to
> link_rules()).
> 
> The old code you replaced also did not always call rule_cache_update(),
> but that was merely for sanity: If cache doesn't contain rules, there is
> no point in updating it with added/replaced/removed rules. The implicit
> logic is if we saw a rule command with 'index' reference, cache would be
> completed up to rule level (because of the necessary index to handle
> translation).
> 
> I'm not sure why you introduced NFT_CACHE_UPDATE in the first place, but
> following my logic (and it seems to serve no other purpose) I would set
> that flag whenever NFT_CACHE_RULE_BIT gets set. So IMHO,
> NFT_CACHE_UPDATE is redundant.

Please, just go ahead simplify this in case you found a way to do it.

Thanks.
