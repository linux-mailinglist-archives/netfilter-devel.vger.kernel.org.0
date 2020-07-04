Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B00214243
	for <lists+netfilter-devel@lfdr.de>; Sat,  4 Jul 2020 02:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGDALh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Jul 2020 20:11:37 -0400
Received: from correo.us.es ([193.147.175.20]:56514 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgGDALh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:11:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 32B1EED5C0
        for <netfilter-devel@vger.kernel.org>; Sat,  4 Jul 2020 02:11:36 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 23E31DA78B
        for <netfilter-devel@vger.kernel.org>; Sat,  4 Jul 2020 02:11:36 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 19043DA73D; Sat,  4 Jul 2020 02:11:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 03551DA73D;
        Sat,  4 Jul 2020 02:11:34 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 04 Jul 2020 02:11:34 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D542742EF532;
        Sat,  4 Jul 2020 02:11:33 +0200 (CEST)
Date:   Sat, 4 Jul 2020 02:11:33 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/1 v2] netfilter: Restore the CT mark in Flow Offload
Message-ID: <20200704001133.GA1023@salvia>
References: <20200601111209.fluj44n5utfoicko@SvensMacBookAir.sven.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601111209.fluj44n5utfoicko@SvensMacBookAir.sven.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Sven,

On Mon, Jun 01, 2020 at 01:12:09PM +0200, Sven Auhagen wrote:
> The skb mark is often used in TC action at egress.
> In order to have the skb mark set we can add it to the
> skb when we do a flow offload lookup from the CT mark.

Thanks for your patch.

I can see a use case for this, however, enabling the skb->mark =
ct->mark restoration is not very flexible.

Every time a default behaviour like this is introduced in the
netfilter codebase, there is someone following up to request a toggle
to enable / to disable it.
