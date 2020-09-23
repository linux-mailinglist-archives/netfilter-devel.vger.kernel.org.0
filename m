Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3412927575F
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Sep 2020 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWLpx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Sep 2020 07:45:53 -0400
Received: from correo.us.es ([193.147.175.20]:48756 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgIWLpx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:45:53 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DF628DA38B
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Sep 2020 13:45:51 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D22AEDA78D
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Sep 2020 13:45:51 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C7B3BDA73F; Wed, 23 Sep 2020 13:45:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A2C88DA789;
        Wed, 23 Sep 2020 13:45:49 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 23 Sep 2020 13:45:49 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 874C54301DE2;
        Wed, 23 Sep 2020 13:45:49 +0200 (CEST)
Date:   Wed, 23 Sep 2020 13:45:49 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org,
        Serhey Popovych <serhe.popovych@gmail.com>
Subject: Re: [iptables PATCH 0/3] libxtables: Fix for pointless socket() calls
Message-ID: <20200923114549.GA3947@salvia>
References: <20200922225341.8976-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922225341.8976-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

On Wed, Sep 23, 2020 at 12:53:38AM +0200, Phil Sutter wrote:
> The motivation for this series was a bug report claiming a near 100%
> slowdown of iptables-restore when passed a large number of rules
> containing conntrack match between two kernel versions. Turns out the
> curlprit kernel change was within SELinux and in fact a performance
> optimization, namely an introduced hash table mapping from security
> context string to SID. This hash table insert, which happened for each
> new socket, slowed iptables-restore down considerably.
> 
> The actual problem exposed by the above was that iptables-restore opens
> a surprisingly large number of sockets when restoring said ruleset. This
> stems from bugs in extension compatibility checks done during extension
> registration (actually, "full registration").
> 
> One of the problems was that incompatible older revsions of an extension
> never were never dropped from the pending list, and thus retried for
> each rule using the extension. Coincidently, conntrack revision 0
> matches this criteria.
> 
> Another problem was a (likely) accidental recursion of
> xtables_fully_register_pending_*() via xtables_find_*(). In combination
> with incompatible match revisions stuck in pending list, this caused
> even more extra compatibility checks.
> 
> Solve all these problems by making pending extension lists sorted by
> (descending) revision number. If at least one revision was compatible
> with the kernel, any following incompatible ones may safely be dropped.
> This should on one hand get rid of the repeated compatibility checks
> while on the other maintain the presumptions stated in commit
> 3b2530ce7a0d6 ("xtables: Do not register matches/targets with
> incompatible revision").
> 
> Patch 1 establishes the needed sorting in pending extension lists,
> patch 2 then simplifies xtables_fully_register_pending_*() functions.
> Patch 3 is strictly speaking not necessary but nice to have as it
> streamlines array-based extension registrators with the extension
> sorting.

Did you run iptables-tests.py with older kernel?

Thanks.
