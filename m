Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09275DACF
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 03:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfGCB2n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Jul 2019 21:28:43 -0400
Received: from mail.us.es ([193.147.175.20]:53878 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfGCB2n (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:28:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 12BA980769
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 00:59:00 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 02863DA704
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 00:59:00 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EC40D1021A6; Wed,  3 Jul 2019 00:58:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0CC3BDA704;
        Wed,  3 Jul 2019 00:58:58 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 03 Jul 2019 00:58:58 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DF15C4265A2F;
        Wed,  3 Jul 2019 00:58:57 +0200 (CEST)
Date:   Wed, 3 Jul 2019 00:58:57 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2] nft: Set socket receive buffer
Message-ID: <20190702225857.4272nljtycs34dv6@salvia>
References: <20190702183049.21460-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702183049.21460-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 02, 2019 at 08:30:49PM +0200, Phil Sutter wrote:
> When trying to delete user-defined chains in a large ruleset,
> iptables-nft aborts with "No buffer space available". This can be
> reproduced using the following script:
> 
> | #! /bin/bash
> | iptables-nft-restore <(
> |
> | echo "*filter"
> | for i in $(seq 0 200000);do
> |         printf ":chain_%06x - [0:0]\n" $i
> | done
> | for i in $(seq 0 200000);do
> |         printf -- "-A INPUT -j chain_%06x\n" $i
> |         printf -- "-A INPUT -j chain_%06x\n" $i
> | done
> | echo COMMIT
> |
> | )
> | iptables-nft -X
> 
> The problem seems to be the sheer amount of netlink error messages sent
> back to user space (one EBUSY for each chain). To solve this, set
> receive buffer size depending on number of commands sent to kernel.

Applied, thanks.
