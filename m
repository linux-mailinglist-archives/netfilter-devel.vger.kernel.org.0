Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C389FA75C7
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 22:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfICUzj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Sep 2019 16:55:39 -0400
Received: from correo.us.es ([193.147.175.20]:34178 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfICUzj (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:55:39 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9DBDAB6C68
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 22:55:35 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 90DBADA72F
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 22:55:35 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 75478203FE; Tue,  3 Sep 2019 22:55:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 709EED2B1F;
        Tue,  3 Sep 2019 22:55:33 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 03 Sep 2019 22:55:33 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 403494251481;
        Tue,  3 Sep 2019 22:55:33 +0200 (CEST)
Date:   Tue, 3 Sep 2019 22:55:34 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 1/2] netfilter: Terminate rule eval if protocol=IPv6
 and ipv6 module is disabled
Message-ID: <20190903205534.bxcty7pja5bvru5f@salvia>
References: <20190830181354.26279-1-leonardo@linux.ibm.com>
 <20190830181354.26279-2-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830181354.26279-2-leonardo@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 30, 2019 at 03:13:53PM -0300, Leonardo Bras wrote:
> If IPv6 is disabled on boot (ipv6.disable=1), but nft_fib_inet ends up
> dealing with a IPv6 packet, it causes a kernel panic in
> fib6_node_lookup_1(), crashing in bad_page_fault.
> 
> The panic is caused by trying to deference a very low address (0x38
> in ppc64le), due to ipv6.fib6_main_tbl = NULL.
> BUG: Kernel NULL pointer dereference at 0x00000038
> 
> The kernel panic was reproduced in a host that disabled IPv6 on boot and
> have to process guest packets (coming from a bridge) using it's ip6tables.
> 
> Terminate rule evaluation when packet protocol is IPv6 but the ipv6 module
> is not loaded.

Patch is applied, thanks.
