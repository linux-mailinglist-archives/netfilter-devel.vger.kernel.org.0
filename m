Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAB830C3CD
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Feb 2021 16:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhBBP2x (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Feb 2021 10:28:53 -0500
Received: from correo.us.es ([193.147.175.20]:52106 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235074AbhBBP0k (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:26:40 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9FDFDCA6AE
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Feb 2021 16:25:58 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 92E7EDA722
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Feb 2021 16:25:58 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9235CDA73F; Tue,  2 Feb 2021 16:25:58 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 55380DA722;
        Tue,  2 Feb 2021 16:25:56 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 02 Feb 2021 16:25:56 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 38E4A426CC85;
        Tue,  2 Feb 2021 16:25:56 +0100 (CET)
Date:   Tue, 2 Feb 2021 16:25:55 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: Re: [PATCH net 0/3] Netfilter fixes for net
Message-ID: <20210202152555.GC26494@salvia>
References: <20210202152156.25979-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210202152156.25979-1-pablo@netfilter.org>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Please, scratch this.

My robot resent an old pull request that was stale on my submission
folder.

Sorry for the noise.

On Tue, Feb 02, 2021 at 04:21:52PM +0100, Pablo Neira Ayuso wrote:
> Hi,
> 
> The following patchset contains Netfilter fixes for net:
> 
> 1) Honor stateful expressions defined in the set from the dynset
>    extension. The set definition provides a stateful expression
>    that must be used by the dynset expression in case it is specified.
> 
> 2) Missing timeout extension in the set element in the dynset
>    extension leads to inconsistent ruleset listing, not allowing
>    the user to restore timeout and expiration on ruleset reload.
> 
> 3) Do not dump the stateful expression from the dynset extension
>    if it coming from the set definition.
> 
> Please, pull these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git
> 
> Thanks!
> 
> ----------------------------------------------------------------
> 
> The following changes since commit c8a8ead01736419a14c3106e1f26a79d74fc84c7:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf (2021-01-12 20:25:29 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git HEAD
> 
> for you to fetch changes up to ce5379963b2884e9d23bea0c5674a7251414c84b:
> 
>   netfilter: nft_dynset: dump expressions when set definition contains no expressions (2021-01-16 19:54:42 +0100)
> 
> ----------------------------------------------------------------
> Pablo Neira Ayuso (3):
>       netfilter: nft_dynset: honor stateful expressions in set definition
>       netfilter: nft_dynset: add timeout extension to template
>       netfilter: nft_dynset: dump expressions when set definition contains no expressions
> 
>  include/net/netfilter/nf_tables.h |  2 ++
>  net/netfilter/nf_tables_api.c     |  5 ++---
>  net/netfilter/nft_dynset.c        | 41 +++++++++++++++++++++++++--------------
>  3 files changed, 30 insertions(+), 18 deletions(-)
