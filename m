Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86F75DA0A
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 02:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGCA7c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Jul 2019 20:59:32 -0400
Received: from mail.us.es ([193.147.175.20]:46686 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfGCA7a (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:59:30 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5BCC07FC36
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 02:59:28 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4BC1FDA801
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 02:59:28 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 41088DA7B6; Wed,  3 Jul 2019 02:59:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 51C10DA732;
        Wed,  3 Jul 2019 02:59:26 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 03 Jul 2019 02:59:26 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 326704265A31;
        Wed,  3 Jul 2019 02:59:26 +0200 (CEST)
Date:   Wed, 3 Jul 2019 02:59:25 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] meta: Introduce new conditions 'time', 'day' and
 'hour'
Message-ID: <20190703005925.nx4aqox4cwbbledq@salvia>
References: <20190701201646.7040-1-a@juaristi.eus>
 <20190702232649.tfpuy2pkrotxtkfm@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702232649.tfpuy2pkrotxtkfm@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 03, 2019 at 01:26:49AM +0200, Pablo Neira Ayuso wrote:
> On Mon, Jul 01, 2019 at 10:16:43PM +0200, Ander Juaristi wrote:
> > diff --git a/include/nftables/libnftables.h b/include/nftables/libnftables.h
> > index e39c588..87d4ff5 100644
> > --- a/include/nftables/libnftables.h
> > +++ b/include/nftables/libnftables.h
> > @@ -52,6 +52,7 @@ enum {
> >  	NFT_CTX_OUTPUT_NUMERIC_PROTO	= (1 << 7),
> >  	NFT_CTX_OUTPUT_NUMERIC_PRIO     = (1 << 8),
> >  	NFT_CTX_OUTPUT_NUMERIC_SYMBOL	= (1 << 9),
> > +	NFT_CTX_OUTPUT_SECONDS          = (1 << 10),
> 
> I'd rename this to:
> 
>         NFT_CTX_OUTPUT_NUMERIC_TIME

NFT_CTX_OUTPUT_SECONDS is also fine.

I let you choose.

> 
> >  	NFT_CTX_OUTPUT_NUMERIC_ALL	= (NFT_CTX_OUTPUT_NUMERIC_PROTO |
> >  					   NFT_CTX_OUTPUT_NUMERIC_PRIO |
> >  					   NFT_CTX_OUTPUT_NUMERIC_SYMBOL),
> 
> You have to update NFT_CTX_OUTPUT_NUMERIC_ALL.

But you still have to update this :-)
