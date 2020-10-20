Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE51D28D3A1
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Oct 2020 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgJMS3K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Oct 2020 14:29:10 -0400
Received: from correo.us.es ([193.147.175.20]:53390 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgJMS3J (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:29:09 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DC5324A7064
        for <netfilter-devel@vger.kernel.org>; Tue, 13 Oct 2020 20:29:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CD83DDA78B
        for <netfilter-devel@vger.kernel.org>; Tue, 13 Oct 2020 20:29:08 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C27A3DA78C; Tue, 13 Oct 2020 20:29:08 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DAA29DA78F;
        Tue, 13 Oct 2020 20:29:06 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 13 Oct 2020 20:29:06 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BB2B742EFB80;
        Tue, 13 Oct 2020 20:29:06 +0200 (CEST)
Date:   Tue, 13 Oct 2020 20:29:06 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/8] conntrack: fix icmp entry creation
Message-ID: <20201013182906.GB2069@salvia>
References: <20200925124919.9389-1-mikhail.sennikovskii@cloud.ionos.com>
 <20200925124919.9389-3-mikhail.sennikovskii@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925124919.9389-3-mikhail.sennikovskii@cloud.ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 25, 2020 at 02:49:13PM +0200, Mikhail Sennikovsky wrote:
> Creating icmp ct entry with command like
> 
> conntrack -I -t 29 -u SEEN_REPLY -s 1.1.1.1 -d 2.2.2.2 -r 2.2.2.2 \
>    -q 1.1.1.1 -p icmp --icmp-type 8 --icmp-code 0 --icmp-id 1226
> 
> results in nfct_query( NFCT_Q_CREATE ) request would fail
> because reply L4 proto is not set while having reply data specified
> 
> Set reply L4 proto when reply data is given for the icmp ct entry

Also applied, thanks.
