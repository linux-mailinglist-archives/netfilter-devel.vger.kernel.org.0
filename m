Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D8F31541A
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Feb 2021 17:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhBIQlO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Feb 2021 11:41:14 -0500
Received: from correo.us.es ([193.147.175.20]:46648 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232978AbhBIQki (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:40:38 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BC4EF39626C
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Feb 2021 17:39:56 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A73C5DA78F
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Feb 2021 17:39:56 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9C140DA704; Tue,  9 Feb 2021 17:39:56 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C674ADA78D;
        Tue,  9 Feb 2021 17:39:53 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Feb 2021 17:39:53 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A87D742DC6DD;
        Tue,  9 Feb 2021 17:39:53 +0100 (CET)
Date:   Tue, 9 Feb 2021 17:39:53 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: skip identical origin tuple in
 same zone only
Message-ID: <20210209163953.GA7351@salvia>
References: <20210205115643.25739-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210205115643.25739-1-fw@strlen.de>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 05, 2021 at 12:56:43PM +0100, Florian Westphal wrote:
> The origin skip check needs to re-test the zone. Else, we might skip
> a colliding tuple in the reply direction.
> 
> This only occurs when using 'directional zones' where origin tuples
> reside in different zones but the reply tuples share the same zone.
> 
> This causes the new conntrack entry to be dropped at confirmation time
> because NAT clash resolution was elided.

Applied, thanks Florian.

> 
> Fixes: 4e35c1cb9460240 ("netfilter: nf_nat: skip nat clash resolution for same-origin entries")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  I have a selftest to trigger this bug, but it depends on
>  https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210203165707.21781-4-fw@strlen.de/
>  and
>  https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210203165707.21781-5-fw@strlen.de/
> 
>  so I will only send it once a new nft release with those patches is
>  out.

Looking into these patches now.
