Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818E05D537
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jul 2019 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfGBR0n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Jul 2019 13:26:43 -0400
Received: from mail.us.es ([193.147.175.20]:53472 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfGBR0n (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:26:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 694B6120826
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Jul 2019 19:26:41 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 57F76DA704
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Jul 2019 19:26:41 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4D776A6AC; Tue,  2 Jul 2019 19:26:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 57E02CE158;
        Tue,  2 Jul 2019 19:26:39 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 02 Jul 2019 19:26:39 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 077154265A2F;
        Tue,  2 Jul 2019 19:26:27 +0200 (CEST)
Date:   Tue, 2 Jul 2019 19:26:15 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH RFC] nft: Set socket receive buffer
Message-ID: <20190702172615.t4lwms6zu4acq63e@salvia>
References: <20190702151201.592-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702151201.592-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:12:01PM +0200, Phil Sutter wrote:
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
> Note that calling 'iptables-nft -F' before the last call avoids the
> issue. Also, correct behaviour is indicated by a different error
> message, namely:
> 
> | iptables v1.8.3 (nf_tables):  CHAIN_USER_DEL failed (Device or resource busy): chain chain_000000
> 
> The used multiplier value is a result of trial-and-error, it is the
> first one which eliminated the ENOBUFS condition.

This is triggering a lots of errors (ack messages) to userspace.

Could you estimate the buffer size based on the number of commands?

mnl_batch_talk() is called before iterating over the list of commands,
so this number is already in place. Then, pass it to
mnl_nft_socket_sendmsg().

I'd suggest you add a mnl_set_rcvbuffer() too. You could assume that
getpagesize() is the maximum size for an acknoledgment.

Thanks.
