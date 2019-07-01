Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDB45714C
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZTFI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 15:05:08 -0400
Received: from mail.us.es ([193.147.175.20]:54958 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfFZTFI (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:05:08 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 319C8EAA64
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Jun 2019 21:05:06 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 21436DA3F4
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Jun 2019 21:05:06 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 16671DA4CA; Wed, 26 Jun 2019 21:05:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 09485DA7B6;
        Wed, 26 Jun 2019 21:05:04 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 26 Jun 2019 21:05:04 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (barqueta.lsi.us.es [150.214.188.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id ED4E44265A31;
        Wed, 26 Jun 2019 21:05:03 +0200 (CEST)
Date:   Wed, 26 Jun 2019 21:05:03 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf v2] selftests: netfilter: add nfqueue test case
Message-ID: <20190626190503.jibrghju35bgofxx@salvia>
References: <20190626184234.3172-1-fw@strlen.de>
 <20190626185216.egekz5qpe2ggzj6j@salvia>
 <20190626185653.7xeno66crjigeyul@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626185653.7xeno66crjigeyul@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:56:53PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Wed, Jun 26, 2019 at 08:42:34PM +0200, Florian Westphal wrote:
> > > diff --git a/tools/testing/selftests/netfilter/nf-queue.c b/tools/testing/selftests/netfilter/nf-queue.c
> > > new file mode 100644
> > > index 000000000000..897274bd6f4a
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/netfilter/nf-queue.c
> > 
> > Oh well. Lots of copied and pasted code from the libraries.
> > 
> > We'll have to remind to take patches for the example in the library
> > and the kernel.
> 
> Do you have an alternative proposal?

Probably install this nf-queue tool from libraries? Then, selftest use
this binary? So we have a single copy of this code :-)
