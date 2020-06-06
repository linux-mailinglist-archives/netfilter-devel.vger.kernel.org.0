Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D301F061B
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Jun 2020 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgFFKip (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Jun 2020 06:38:45 -0400
Received: from correo.us.es ([193.147.175.20]:60698 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgFFKip (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Jun 2020 06:38:45 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1F0CBC2FE6
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Jun 2020 12:38:44 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1213CDA73D
        for <netfilter-devel@vger.kernel.org>; Sat,  6 Jun 2020 12:38:44 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 07B7BDA78E; Sat,  6 Jun 2020 12:38:44 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EDBFEDA78A;
        Sat,  6 Jun 2020 12:38:41 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 06 Jun 2020 12:38:41 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D015B42EE38E;
        Sat,  6 Jun 2020 12:38:41 +0200 (CEST)
Date:   Sat, 6 Jun 2020 12:38:41 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Duncan Roe <duncan_roe@optusnet.com.au>, fw@strlen.de,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue 0/1] URGENT: libnetfilter_queue-1.0.4
 fails to build
Message-ID: <20200606103841.GA4516@salvia>
References: <20200606052510.27423-1-duncan_roe@optusnet.com.au>
 <nycvar.YFH.7.77.849.2006060806160.7334@n3.vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.77.849.2006060806160.7334@n3.vanv.qr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jun 06, 2020 at 08:08:35AM +0200, Jan Engelhardt wrote:
> On Saturday 2020-06-06 07:25, Duncan Roe wrote:
> 
> >'make' says: No rule to build ../fixmanpages.sh: stop
> >Maybe you can push out a re-release before anyone else notices?
> 
> No to rereleases. That just upsets distros and automated scripts that 
> have already downloaded the file (we're now past 23 hours anyway) and 
> would raise a "their server was hacked" flag because the 
> signatures/checksums no longer match between what's brewing in the 
> distro staging and upstream URL.

I agree a new is the way to go.
