Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513FD228CA2
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jul 2020 01:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgGUXUN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jul 2020 19:20:13 -0400
Received: from correo.us.es ([193.147.175.20]:55732 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGUXUN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:20:13 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 27B062EFEA9
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 01:20:10 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1AEF9DA722
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 01:20:10 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EFD31DA78C; Wed, 22 Jul 2020 01:20:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B8911DA72F;
        Wed, 22 Jul 2020 01:20:07 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 22 Jul 2020 01:20:07 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 8B7D94265A2F;
        Wed, 22 Jul 2020 01:20:07 +0200 (CEST)
Date:   Wed, 22 Jul 2020 01:20:07 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Andrew Sy Kim <kim.andrewsy@gmail.com>,
        Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] ipvs: add missing struct name in
 ip_vs_enqueue_expire_nodest_conns when CONFIG_SYSCTL is disabled
Message-ID: <20200721232007.GA6367@salvia>
References: <20200717162450.1049-1-kim.andrewsy@gmail.com>
 <alpine.LFD.2.23.451.2007172032370.4536@ja.home.ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.23.451.2007172032370.4536@ja.home.ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 17, 2020 at 08:36:36PM +0300, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Fri, 17 Jul 2020, Andrew Sy Kim wrote:
> 
> > Adds missing "*ipvs" to ip_vs_enqueue_expire_nodest_conns when
> > CONFIG_SYSCTL is disabled
> > 
> > Signed-off-by: Andrew Sy Kim <kim.andrewsy@gmail.com>
> 
> Acked-by: Julian Anastasov <ja@ssi.bg>
> 
> 	Pablo, please apply this too.

I have squashed this fix and "ipvs: ensure RCU read unlock when
connection flushing and ipvs is disabled" into the original patch:

"ipvs: queue delayed work to expire no destination connections if
expire_nodest_conn=1"
