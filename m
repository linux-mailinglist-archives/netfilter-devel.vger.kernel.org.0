Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D416FDD2
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Feb 2020 12:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgBZLew (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Feb 2020 06:34:52 -0500
Received: from correo.us.es ([193.147.175.20]:33126 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgBZLew (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:34:52 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 36D151C4388
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Feb 2020 12:34:43 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 29B6EFC5E4
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Feb 2020 12:34:43 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1F2C1FC5A6; Wed, 26 Feb 2020 12:34:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 769D6DA3A8;
        Wed, 26 Feb 2020 12:34:36 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 26 Feb 2020 12:34:20 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 556B942EF42E;
        Wed, 26 Feb 2020 12:34:36 +0100 (CET)
Date:   Wed, 26 Feb 2020 12:34:43 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH nf 0/2] nft_set_pipapo: Fix crash due to dangling entries
 in mapping table
Message-ID: <20200226113443.vudkkqzxj5qussqz@salvia>
References: <20200225123934.p3vru3tmbsjj2o7y@salvia>
 <20200225141346.7406e06b@redhat.com>
 <20200225134236.sdz5ujufvxm2in3h@salvia>
 <20200225153435.17319874@redhat.com>
 <20200225202143.tqsfhggvklvhnsvs@salvia>
 <20200225213815.3c0a1caa@redhat.com>
 <20200225205847.s5pjjp652unj6u7v@salvia>
 <20200226115924.461f2029@redhat.com>
 <20200226111056.5fultu3onan2vttd@salvia>
 <20200226121924.4194f31d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226121924.4194f31d@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:19:24PM +0100, Stefano Brivio wrote:
> On Wed, 26 Feb 2020 12:10:56 +0100
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> 
> > On Wed, Feb 26, 2020 at 11:59:24AM +0100, Stefano Brivio wrote:
> > [...]
> > > One detail, unrelated to this patch, that I should probably document in
> > > man pages and Wiki (I forgot, it occurred to me while testing): it is
> > > allowed to insert an entry if a proper subset of it, with no
> > > overlapping bounds, is already inserted. The reverse sequence is not
> > > allowed. This can be used without ambiguity due to strict guarantees
> > > about ordering. That is:
> > > 
> > > # nft add element t s '{ 1.0.0.20-1.0.0.21 . 3.3.3.3 }'
> > > # nft add element t s '{ 1.0.0.10-1.0.0.100 . 3.3.3.3 }'  
> > 
> > OK, so first element "shadows" the second one. And the first element
> > will matching in case that address is 1.0.0.20 and 10.0.0.21. Right?
> 
> Correct.

So this is happening because the result bitmap contains the pipapo
rules that represent the first element and the second. But when
iterating over the result bitmap bits, the pipapo rule that represents
the first element is taken as the matching one, right?

I mean, to catch elements that represents subsets/supersets of another
element (like in this example above), pipapo would need to make a
lookup for already matching rules for this new element?

Thanks.
