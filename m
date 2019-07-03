Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD15D93C
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 02:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGCAio (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Jul 2019 20:38:44 -0400
Received: from mail.us.es ([193.147.175.20]:42528 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfGCAin (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:38:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4B0EA80776
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 01:18:51 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3BDF3DA4D0
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 01:18:51 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 313E5DA704; Wed,  3 Jul 2019 01:18:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3D89CDA704;
        Wed,  3 Jul 2019 01:18:49 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 03 Jul 2019 01:18:49 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1B1084265A2F;
        Wed,  3 Jul 2019 01:18:49 +0200 (CEST)
Date:   Wed, 3 Jul 2019 01:18:48 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] meta: Introduce new conditions 'time', 'day' and
 'hour'
Message-ID: <20190702231848.2hzvua2ewvvfhz3h@salvia>
References: <20190701201646.7040-1-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701201646.7040-1-a@juaristi.eus>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 01, 2019 at 10:16:43PM +0200, Ander Juaristi wrote:
[...]
>  include/datatype.h                  |   3 +
>  include/linux/netfilter/nf_tables.h |   6 +
>  include/meta.h                      |   3 +
>  include/nftables.h                  |   5 +
>  include/nftables/libnftables.h      |   1 +
>  src/datatype.c                      |   3 +
>  src/main.c                          |  11 +-
>  src/meta.c                          | 292 ++++++++++++++++++++++++++++
>  src/parser_bison.y                  |   4 +
>  src/scanner.l                       |   4 +-
>  10 files changed, 330 insertions(+), 2 deletions(-)

I don't see any update on the json bits in this diffstat.

Please make sure you run:

        ./configure ... --with-json

then, also run json tests:

        tests/py# python nft-tests.py -j

Thanks.
