Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5D30E641
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Feb 2021 23:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhBCWuO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Feb 2021 17:50:14 -0500
Received: from correo.us.es ([193.147.175.20]:39522 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhBCWuO (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:50:14 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6126C505535
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 23:49:31 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3B141DA704
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 23:49:31 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2FFB0DA78F; Wed,  3 Feb 2021 23:49:31 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.1 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,USER_IN_WELCOMELIST,
        USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 48D31DA704;
        Wed,  3 Feb 2021 23:49:29 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 03 Feb 2021 23:49:29 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2B076426CC84;
        Wed,  3 Feb 2021 23:49:29 +0100 (CET)
Date:   Wed, 3 Feb 2021 23:49:28 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jozsef Kadlecsik <kadlec@mail.kfki.hu>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: Fix attempt to update deleted entry in
 xt_recent
Message-ID: <20210203224928.GA8567@salvia>
References: <4347729e-9cf2-bda9-19d7-ad3338f6baaa@mail.kfki.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4347729e-9cf2-bda9-19d7-ad3338f6baaa@mail.kfki.hu>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jan 29, 2021 at 08:57:43PM +0100, Jozsef Kadlecsik wrote:
> Hi Pablo,
> 
> Please review the next patch and consider applying it in the nf branch:
> 
> When both --reap and --update flag are specified, there's a code
> path at which the entry to be updated is reaped beforehand,
> which then leads to kernel crash. Reap only entries which won't be
> updated.
> 
> Fixes kernel bugzilla #207773.

Applied, thanks Jozsef.
