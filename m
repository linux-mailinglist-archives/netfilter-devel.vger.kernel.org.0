Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F98D1FD5AD
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2020 22:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFQUAn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jun 2020 16:00:43 -0400
Received: from correo.us.es ([193.147.175.20]:58312 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQUAn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:00:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6779EDBC07
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Jun 2020 22:00:40 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 59679DA78F
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Jun 2020 22:00:40 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4EE3DDA78E; Wed, 17 Jun 2020 22:00:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 29B25DA789;
        Wed, 17 Jun 2020 22:00:38 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 17 Jun 2020 22:00:38 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 09FEC42EE38E;
        Wed, 17 Jun 2020 22:00:37 +0200 (CEST)
Date:   Wed, 17 Jun 2020 22:00:37 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH nf-next] nft_set_pipapo: Drop useless assignment of
 scratch map index on insert
Message-ID: <20200617200037.GA16887@salvia>
References: <033bc756cdecd4e8cbe01be3bcd50e59a844665c.1592167414.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033bc756cdecd4e8cbe01be3bcd50e59a844665c.1592167414.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jun 14, 2020 at 11:42:07PM +0200, Stefano Brivio wrote:
> In nft_pipapo_insert(), we need to reallocate scratch maps that will
> be used for matching by lookup functions, if they have never been
> allocated or if the bucket size changes as a result of the insertion.
> 
> As pipapo_realloc_scratch() provides a pair of fresh, zeroed out
> maps, there's no need to select a particular one after reallocation.
> 
> Other than being useless, the existing assignment was also troubled
> by the fact that the index was set only on the CPU performing the
> actual insertion, as spotted by Florian.
> 
> Simply drop the assignment.

I have just refreshed nf-next to pull in your fix dependency.

Please, rebase and resubmit this patch on top of nf-next.

Thanks.
