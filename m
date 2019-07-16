Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A9B6A768
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jul 2019 13:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfGPLXw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Jul 2019 07:23:52 -0400
Received: from mail.us.es ([193.147.175.20]:45550 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbfGPLXw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:23:52 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 64A7EE34CD
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Jul 2019 13:23:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 55085A59B
        for <netfilter-devel@vger.kernel.org>; Tue, 16 Jul 2019 13:23:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4AA7691F4; Tue, 16 Jul 2019 13:23:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5255A1150B9;
        Tue, 16 Jul 2019 13:23:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 16 Jul 2019 13:23:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2FAE94265A31;
        Tue, 16 Jul 2019 13:23:48 +0200 (CEST)
Date:   Tue, 16 Jul 2019 13:23:47 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: don't fail when updating base
 chain policy
Message-ID: <20190716112347.xvyucevt4bhbebc5@salvia>
References: <20190713215921.18696-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190713215921.18696-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jul 13, 2019 at 11:59:21PM +0200, Florian Westphal wrote:
> The following nftables test case fails on nf-next:
> 
> tests/shell/run-tests.sh tests/shell/testcases/transactions/0011chain_0
> 
> The test case contains:
> add chain x y { type filter hook input priority 0; }
> add chain x y { policy drop; }"
> 
> The new test
> if (chain->flags ^ flags)
> 	return -EOPNOTSUPP;
> 
> triggers here, because chain->flags has NFT_BASE_CHAIN set, but flags
> is 0 because no flag attribute was present in the policy update.
> 
> Just fetch the current flag settings of a pre-existing chain in case
> userspace did not provide any.

Applied, thanks for fixing up this, this is my fault.
