Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA3E14B380
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jan 2020 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgA1L33 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jan 2020 06:29:29 -0500
Received: from correo.us.es ([193.147.175.20]:38272 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgA1L33 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:29:29 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4BB0BEBAC8
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 12:29:28 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3D14EDA791
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 12:29:28 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 39D4BDA720; Tue, 28 Jan 2020 12:29:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1E660DA710;
        Tue, 28 Jan 2020 12:29:26 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Jan 2020 12:29:26 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F09004301DE0;
        Tue, 28 Jan 2020 12:29:25 +0100 (CET)
Date:   Tue, 28 Jan 2020 12:29:24 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nft PATCH 3/4] segtree: Simplify overlap case in ei_insert()
Message-ID: <20200128112924.z5ucdevk2rbe3zmn@salvia>
References: <20200123143049.13888-1-phil@nwl.cc>
 <20200123143049.13888-4-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123143049.13888-4-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 23, 2020 at 03:30:48PM +0100, Phil Sutter wrote:
> Since upper boundary overlaps can't happen, lower boundary overlaps may
> simply be resolved by adjusting the existing range's upper boundary to
> that of the new one instead of adding elements which are later dropped
> again.

I would append to this description that this only happens if
auto-merge is set on.

> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
