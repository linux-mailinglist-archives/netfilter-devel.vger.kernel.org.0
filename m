Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E101F218C
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2020 23:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgFHVh7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Jun 2020 17:37:59 -0400
Received: from correo.us.es ([193.147.175.20]:42320 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgFHVh7 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:37:59 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3C3BDC2FE4
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Jun 2020 23:37:58 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2DB1ADA72F
        for <netfilter-devel@vger.kernel.org>; Mon,  8 Jun 2020 23:37:58 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2356FDA73D; Mon,  8 Jun 2020 23:37:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 16FA7DA72F;
        Mon,  8 Jun 2020 23:37:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 08 Jun 2020 23:37:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id EC5BD426CCB9;
        Mon,  8 Jun 2020 23:37:55 +0200 (CEST)
Date:   Mon, 8 Jun 2020 23:37:55 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue 0/2] Force 'make distcheck' to pass
Message-ID: <20200608213755.GA11703@salvia>
References: <20200607184716.GA20705@salvia>
 <20200608071501.14448-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608071501.14448-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 08, 2020 at 05:14:59PM +1000, Duncan Roe wrote:
> Hi Pablo,
> 
> Patch 1 below is the same as I sent previously.
> 
> Patch 2 forces 'make distcheck' to pass. The generated tar.bz2 is good.
> The patch is not pretty, but the best I could do.

Thanks. I also spent a bit of time and I failed to make this work
without the hacks.

I decided to:

* Disable doxygen by default, as it was in the <= 1.0.3 releases.
  Users can still enable this via --with-doxygen.

* Add this manpage fixup script to EXTRA_DIST.

Patch are already upstream.
