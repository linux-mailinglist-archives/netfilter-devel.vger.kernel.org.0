Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A75580F
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFYTpe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Jun 2019 15:45:34 -0400
Received: from mail.us.es ([193.147.175.20]:48096 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFYTpe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:45:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6B64AC3310
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 21:45:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5D1775C01B
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 21:45:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 529EEDA3F4; Tue, 25 Jun 2019 21:45:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 48B39576DA;
        Tue, 25 Jun 2019 21:45:30 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 25 Jun 2019 21:45:30 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 213DA4265A32;
        Tue, 25 Jun 2019 21:45:30 +0200 (CEST)
Date:   Tue, 25 Jun 2019 21:45:29 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Felix Kaechele <felix@kaechele.ca>
Cc:     Kristian Evensen <kristian.evensen@gmail.com>,
        Netfilter Development Mailing list 
        <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH 08/13] netfilter: ctnetlink: Resolve conntrack
 L3-protocol flush regression
Message-ID: <20190625194529.m5yx4ujupjjjepog@salvia>
References: <20190513095630.32443-9-pablo@netfilter.org>
 <0a4e3cd2-82f7-8ad6-2403-9852e34c8ac3@kaechele.ca>
 <20190624235816.vw6ahepdgvxhvdej@salvia>
 <4367f30f-4602-a4b6-a96e-35d879cc7758@kaechele.ca>
 <20190625080853.d6f523cimgg2u44v@salvia>
 <0904a616-106c-91de-ed55-97973aa5c330@kaechele.ca>
 <CAKfDRXjun=cVovtn70jxwTc9pa0hhDHUSdZjLHJC1Xw2AMG+rA@mail.gmail.com>
 <04ab8f2d-2b50-8d99-2fa1-837b7acaf417@kaechele.ca>
 <CAKfDRXiwRs5kkZi3AQd4nwqvWtukbrviihH+5s4iHkDfnuW93g@mail.gmail.com>
 <25855f46-312b-b263-3cf7-7547e5ece264@kaechele.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25855f46-312b-b263-3cf7-7547e5ece264@kaechele.ca>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:16:30PM -0400, Felix Kaechele wrote:
> On 2019-06-25 11:08 a.m., Kristian Evensen wrote:
> 
> > Pablos patch implements
> > the first thing that I wanted to try (only read and use version/family
> > when flushing), and I see that Nicolas has made some suggestions. If
> > you could first try Pablo's patch with Nicolas' changes, that would be
> > great as the change should revert behavior of delete back to how it
> > was before my change.
> 
> Yes, these changes fix the issue for me.
> 
> I have attached the patch I used, which is probably the change that Pablo
> initially intended.

That's the right fix indeed, would you mind to submit it including a
patch description and Signed-off-by: tag?

This should apply via git-am.

Thanks.

> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> index d2715b4d2e72..061bdab37b1a 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -1254,7 +1254,6 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
>  	struct nf_conntrack_tuple tuple;
>  	struct nf_conn *ct;
>  	struct nfgenmsg *nfmsg = nlmsg_data(nlh);
> -	u_int8_t u3 = nfmsg->version ? nfmsg->nfgen_family : AF_UNSPEC;
>  	struct nf_conntrack_zone zone;
>  	int err;
>  
> @@ -1264,11 +1263,13 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
>  
>  	if (cda[CTA_TUPLE_ORIG])
>  		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_ORIG,
> -					    u3, &zone);
> +					    nfmsg->nfgen_family, &zone);
>  	else if (cda[CTA_TUPLE_REPLY])
>  		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_REPLY,
> -					    u3, &zone);
> +					    nfmsg->nfgen_family, &zone);
>  	else {
> +		u_int8_t u3 = nfmsg->version ? nfmsg->nfgen_family : AF_UNSPEC;
> +
>  		return ctnetlink_flush_conntrack(net, cda,
>  						 NETLINK_CB(skb).portid,
>  						 nlmsg_report(nlh), u3);

