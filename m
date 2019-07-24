Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52E472B87
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jul 2019 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfGXJhZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Jul 2019 05:37:25 -0400
Received: from mail.us.es ([193.147.175.20]:35790 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfGXJhZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:37:25 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EC68DFC5E6
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Jul 2019 11:37:22 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D5F011150DA
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Jul 2019 11:37:22 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id CB7491150B9; Wed, 24 Jul 2019 11:37:22 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CFE08115105;
        Wed, 24 Jul 2019 11:37:20 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 24 Jul 2019 11:37:20 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.183.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 782E740705C4;
        Wed, 24 Jul 2019 11:37:20 +0200 (CEST)
Date:   Wed, 24 Jul 2019 11:37:19 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: nf_tables: Make nft_meta expression more
 robust
Message-ID: <20190724093719.dfgmdlkx6igx7xrz@salvia>
References: <20190723132753.13781-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723132753.13781-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:27:52PM +0200, Phil Sutter wrote:
> nft_meta_get_eval()'s tendency to bail out setting NFT_BREAK verdict in
> situations where required data is missing leads to unexpected behaviour
> with inverted checks like so:
> 
> | meta iifname != eth0 accept
> 
> This rule will never match if there is no input interface (or it is not
> known) which is not intuitive and, what's worse, breaks consistency of
> iptables-nft with iptables-legacy.
> 
> Fix this by falling back to placing a value in dreg which never matches
> (avoiding accidental matches), i.e. zero for interface index and an
> empty string for interface name.

Applied, thanks.
