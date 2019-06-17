Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3ADD4949F
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 23:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfFQVzW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 17:55:22 -0400
Received: from mail.us.es ([193.147.175.20]:50782 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfFQVzW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:55:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AC325F26E2
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 23:55:17 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9AEB6DA704
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 23:55:17 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 905FCDA702; Mon, 17 Jun 2019 23:55:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DFEF6DA702;
        Mon, 17 Jun 2019 23:55:14 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 17 Jun 2019 23:55:14 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BCC444265A2F;
        Mon, 17 Jun 2019 23:55:14 +0200 (CEST)
Date:   Mon, 17 Jun 2019 23:55:14 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next WIP] netfilter: nf_tables: Add SYNPROXY support
Message-ID: <20190617215514.6zpkgww7a3wjhsj3@salvia>
References: <20190617103234.1357-1-ffmancera@riseup.net>
 <20190617103234.1357-2-ffmancera@riseup.net>
 <20190617154545.pr2nhk4itydcya3e@salvia>
 <94f3c031-9952-f65a-6f8a-ef58de848217@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f3c031-9952-f65a-6f8a-ef58de848217@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 17, 2019 at 09:49:43PM +0200, Fernando Fernandez Mancera wrote:
> Hi Pablo, comments below.
> 
> On 6/17/19 5:45 PM, Pablo Neira Ayuso wrote:
> > On Mon, Jun 17, 2019 at 12:32:35PM +0200, Fernando Fernandez Mancera wrote:
> >> Add SYNPROXY module support in nf_tables. It preserves the behaviour of the
> >> SYNPROXY target of iptables but structured in a different way to propose
> >> improvements in the future.
> >>
> >> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> >> ---
> >>  include/uapi/linux/netfilter/nf_SYNPROXY.h |   4 +
> >>  include/uapi/linux/netfilter/nf_tables.h   |  16 +
> >>  net/netfilter/Kconfig                      |  11 +
> >>  net/netfilter/Makefile                     |   1 +
> >>  net/netfilter/nft_synproxy.c               | 328 +++++++++++++++++++++
> >>  5 files changed, 360 insertions(+)
> >>  create mode 100644 net/netfilter/nft_synproxy.c
> >>
> [...]
> >> +
> >> +static void nft_synproxy_eval(const struct nft_expr *expr,
> >> +			      struct nft_regs *regs,
> >> +			      const struct nft_pktinfo *pkt)
> >> +{
> > 
> > You have to check if this is TCP traffic in first place, otherwise UDP
> > packets may enter this path :-).
> > 
> >> +	switch (nft_pf(pkt)) {
> >> +	case NFPROTO_IPV4:
> >> +		nft_synproxy_eval_v4(expr, regs, pkt);
> >> +		return;
> >> +#if IS_ENABLED(CONFIG_NF_TABLES_IPV6)
> >> +	case NFPROTO_IPV6:
> >> +		nft_synproxy_eval_v6(expr, regs, pkt);
> >> +		return;
> >> +#endif
> > 
> > Please, use skb->protocol instead of nft_pf(), I would like we can use
> > nft_synproxy from NFPROTO_NETDEV (ingress) and NFPROTO_BRIDGE families
> > too.
> > 
> 
> If I use skb->protocol no packet enters in the path. What do you
> recommend me? Other than that, the rest of the suggestions are done and
> it has been tested and it worked as expected. Thanks :-)

skb->protocol uses big endian representation, you have to check for:

        switch (skb->protocol) {
        case htons(ETH_P_IP):
                ...
                break;
        case htons(ETH_P_IPV6):
                ...
                break;
        }
