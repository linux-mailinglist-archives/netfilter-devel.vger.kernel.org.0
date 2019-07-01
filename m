Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26A54BF7C
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Jun 2019 19:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFSRV5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Jun 2019 13:21:57 -0400
Received: from mail.us.es ([193.147.175.20]:34678 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfFSRV5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:21:57 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3DC00C1D51
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Jun 2019 19:21:55 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2E4DCDA70B
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Jun 2019 19:21:55 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 23EADDA702; Wed, 19 Jun 2019 19:21:55 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 19301DA707;
        Wed, 19 Jun 2019 19:21:53 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 19 Jun 2019 19:21:53 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id EBEB34265A2F;
        Wed, 19 Jun 2019 19:21:52 +0200 (CEST)
Date:   Wed, 19 Jun 2019 19:21:52 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/3] src: statement: disable reject statement type
 omission for bridge
Message-ID: <20190619172152.urek4i5373qughej@salvia>
References: <20190618184359.29760-1-fw@strlen.de>
 <20190618184359.29760-3-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618184359.29760-3-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 18, 2019 at 08:43:58PM +0200, Florian Westphal wrote:
> add rule bridge test-bridge input reject with icmp type port-unreachable
> 
> ... will be printed as 'reject', which is fine on ip family, but not on
> bridge -- 'with icmp type' adds an ipv4 dependency, but simple reject
> does not (it will use icmpx to also reject ipv6 packets with an icmpv6 error).
> 
> Add a toggle to supress short-hand versions in this case.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
