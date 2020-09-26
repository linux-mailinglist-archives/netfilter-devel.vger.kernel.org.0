Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1013279BD1
	for <lists+netfilter-devel@lfdr.de>; Sat, 26 Sep 2020 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgIZSTe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 26 Sep 2020 14:19:34 -0400
Received: from correo.us.es ([193.147.175.20]:44390 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgIZSTe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 26 Sep 2020 14:19:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0505DD28C7
        for <netfilter-devel@vger.kernel.org>; Sat, 26 Sep 2020 20:19:31 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EB8FDDA78B
        for <netfilter-devel@vger.kernel.org>; Sat, 26 Sep 2020 20:19:30 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EADA9DA78A; Sat, 26 Sep 2020 20:19:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B6033DA72F;
        Sat, 26 Sep 2020 20:19:28 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 26 Sep 2020 20:19:28 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9623E42EF42A;
        Sat, 26 Sep 2020 20:19:28 +0200 (CEST)
Date:   Sat, 26 Sep 2020 20:19:28 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/8] Fast bulk transfers of large sets of ct entries
Message-ID: <20200926181928.GA3598@salvia>
References: <20200925124919.9389-1-mikhail.sennikovskii@cloud.ionos.com>
 <20200925132834.GC31471@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925132834.GC31471@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:28:34PM +0200, Florian Westphal wrote:
> Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com> wrote:
> > In addition to this I have a question about the behavioural change
> > of the "conntrack -L" done after conntrack v1.4.5.
> > With the conntrack v1.4.5 used on Debian Buster the "conntrack -L"
> > dumps both ipv4 and ipv6 ct entries, while with the current master, 
> > presumably starting with the commit 2bcbae4c14b253176d7570e6f6acc56e521ceb5e 
> > "conntrack -L"  only dumps ipv4 entries.
> > 
> > So is this really the desired behavior? 
> 
> I'd like conntrack to dump both by default.

Dumping both with -L is fine, so -f behaves as a way to filter.
