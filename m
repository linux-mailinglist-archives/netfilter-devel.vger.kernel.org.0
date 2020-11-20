Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0622BAA99
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Nov 2020 13:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKTMyg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Nov 2020 07:54:36 -0500
Received: from correo.us.es ([193.147.175.20]:41854 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgKTMyf (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:54:35 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0C7C31C4429
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Nov 2020 13:54:34 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F07F211510F
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Nov 2020 13:54:33 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E548D115108; Fri, 20 Nov 2020 13:54:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C5A29115108;
        Fri, 20 Nov 2020 13:54:31 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Nov 2020 13:54:31 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A80084265A5A;
        Fri, 20 Nov 2020 13:54:31 +0100 (CET)
Date:   Fri, 20 Nov 2020 13:54:31 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH nf] netfilter: nf_tables: avoid false-postive lockdep
 splat
Message-ID: <20201120125431.GA32383@salvia>
References: <20201119153454.28089-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119153454.28089-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:34:54PM +0100, Florian Westphal wrote:
> There are reports wrt lockdep splat in nftables, e.g.:
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 31416 at net/netfilter/nf_tables_api.c:622
> lockdep_nfnl_nft_mutex_not_held+0x28/0x38 [nf_tables]
> ...
> 
> These are caused by an earlier, unrelated bug such as a n ABBA deadlock
> in a different subsystem.
> In such an event, lockdep is disabled and lockdep_is_held returns true
> unconditionally.  This then causes the WARN() in nf_tables.
> 
> Make the WARN conditional on lockdep still active to avoid this.

Applied, thanks.
