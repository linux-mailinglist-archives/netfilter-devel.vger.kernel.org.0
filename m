Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB8B332A66
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Mar 2021 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhCIP06 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Mar 2021 10:26:58 -0500
Received: from correo.us.es ([193.147.175.20]:37820 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231985AbhCIP0n (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:26:43 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C9FA3A7E86
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 16:26:39 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BA2C5DA78B
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 16:26:39 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AF54BDA73D; Tue,  9 Mar 2021 16:26:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-105.9 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,USER_IN_WELCOMELIST,
        USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7536DDA796;
        Tue,  9 Mar 2021 16:26:37 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Mar 2021 16:26:37 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 554B642DC702;
        Tue,  9 Mar 2021 16:26:37 +0100 (CET)
Date:   Tue, 9 Mar 2021 16:26:36 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     netfilter-devel@vger.kernel.org,
        "Signed-off-by : Florian Westphal" <fw@strlen.de>
Subject: Re: [PATCH nft] nftables: xt: fix misprint in
 nft_xt_compatible_revision
Message-ID: <20210309152636.GA3622@salvia>
References: <20210309150915.8575-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309150915.8575-1-ptikhomirov@virtuozzo.com>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:09:15PM +0300, Pavel Tikhomirov wrote:
> The rev variable is used here instead of opt obviously by mistake.
> Please see iptables:nft_compatible_revision() for an example how it
> should be.
> 
> This breaks revision compatibility checks completely when reading
> compat-target rules from nft utility. That's why nftables can't work on
> "old" kernels which don't support new revisons. That's a problem for
> containers.

Applied, thanks.
