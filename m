Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C57A73B3
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 21:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfICTcB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Sep 2019 15:32:01 -0400
Received: from correo.us.es ([193.147.175.20]:47896 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfICTcB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:32:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 809C4E2C50
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 21:31:57 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 729EAFB362
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 21:31:57 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 67D0EDA8E8; Tue,  3 Sep 2019 21:31:57 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A3DF4B7FF2;
        Tue,  3 Sep 2019 21:31:54 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 03 Sep 2019 21:31:54 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 724554251480;
        Tue,  3 Sep 2019 21:31:54 +0200 (CEST)
Date:   Tue, 3 Sep 2019 21:31:55 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 1/2] netfilter: Terminate rule eval if protocol=IPv6
 and ipv6 module is disabled
Message-ID: <20190903193155.v74ws47zcn6zrwpr@salvia>
References: <20190830181354.26279-1-leonardo@linux.ibm.com>
 <20190830181354.26279-2-leonardo@linux.ibm.com>
 <20190830205802.GS20113@breakpoint.cc>
 <99e3ef9c5ead1c95df697d49ab9cc83a95b0ac7c.camel@linux.ibm.com>
 <20190903164948.kuvtpy7viqhcmp77@salvia>
 <20190903170550.GA13660@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903170550.GA13660@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 03, 2019 at 07:05:50PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > On Tue, Sep 03, 2019 at 01:46:50PM -0300, Leonardo Bras wrote:
> > > On Fri, 2019-08-30 at 22:58 +0200, Florian Westphal wrote:
> > > > Leonardo Bras <leonardo@linux.ibm.com> wrote:
> > > > > If IPv6 is disabled on boot (ipv6.disable=1), but nft_fib_inet ends up
> > > > > dealing with a IPv6 packet, it causes a kernel panic in
> > > > > fib6_node_lookup_1(), crashing in bad_page_fault.
> > > > > 
> > > > > The panic is caused by trying to deference a very low address (0x38
> > > > > in ppc64le), due to ipv6.fib6_main_tbl = NULL.
> > > > > BUG: Kernel NULL pointer dereference at 0x00000038
> > > > > 
> > > > > The kernel panic was reproduced in a host that disabled IPv6 on boot and
> > > > > have to process guest packets (coming from a bridge) using it's ip6tables.
> > > > > 
> > > > > Terminate rule evaluation when packet protocol is IPv6 but the ipv6 module
> > > > > is not loaded.
> > > > > 
> > > > > Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> > > > 
> > > > Acked-by: Florian Westphal <fw@strlen.de>
> > > > 
> > > 
> > > Hello Pablo,
> > > 
> > > Any trouble with this patch? 
> > > I could see the other* one got applied, but not this one.
> > > *(The other did not get acked, so i released it alone as v5)
> > > 
> > > Is there any fix I need to do in this one?
> > 
> > Hm, I see, so this one:
> > 
> > https://patchwork.ozlabs.org/patch/1156100/
> > 
> > is not enough?
> 
> No, its not.
> 
> > I was expecting we could find a way to handle this from br_netfilter
> > alone itself.
> 
> We can't because we support ipv6 fib lookups from the netdev family
> as well.
> 
> Alternative is to auto-accept ipv6 packets from the nf_tables eval loop,
> but I think its worse.

Could we add a restriction for nf_tables + br_netfilter + !ipv6. I
mean, if this is an IPv6 packet, nf_tables is on and IPv6 module if
off, then drop this packet?

By dropping packet, the user could diagnose that its setup is
incomplete. I mean, if nf_tables fib ipv6 is used, then this setup is
really wrong and the user forgots to load the ipv6 module.
