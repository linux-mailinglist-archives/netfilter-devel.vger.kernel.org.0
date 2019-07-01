Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A55580E
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfFYTo3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Jun 2019 15:44:29 -0400
Received: from mail.us.es ([193.147.175.20]:47878 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfFYTo3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:44:29 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A13E7C330D
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 21:44:27 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 94003203FB
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 21:44:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 89B38DA4D0; Tue, 25 Jun 2019 21:44:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8F8C8DA708;
        Tue, 25 Jun 2019 21:44:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 25 Jun 2019 21:44:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6B7974265A31;
        Tue, 25 Jun 2019 21:44:25 +0200 (CEST)
Date:   Tue, 25 Jun 2019 21:44:25 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     Felix Kaechele <felix@kaechele.ca>,
        netfilter-devel@vger.kernel.org,
        Kristian Evensen <kristian.evensen@gmail.com>
Subject: Re: [PATCH 08/13] netfilter: ctnetlink: Resolve conntrack
 L3-protocol flush regression
Message-ID: <20190625194425.jw3w4zt5ff5ewyid@salvia>
References: <20190513095630.32443-1-pablo@netfilter.org>
 <20190513095630.32443-9-pablo@netfilter.org>
 <0a4e3cd2-82f7-8ad6-2403-9852e34c8ac3@kaechele.ca>
 <20190624235816.vw6ahepdgvxhvdej@salvia>
 <d8c9e1a9-dec3-da71-49a7-d692445a5aff@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8c9e1a9-dec3-da71-49a7-d692445a5aff@6wind.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 25, 2019 at 05:01:36PM +0200, Nicolas Dichtel wrote:
> Le 25/06/2019 � 01:58, Pablo Neira Ayuso a �crit�:
> > On Sun, Jun 23, 2019 at 11:44:09PM -0400, Felix Kaechele wrote:
> > [...]
> >>   [felix@x1 utils]$ sudo ./conntrack_delete
> >>
> >>   TEST: delete conntrack (-1)(No such file or directory)
> > 
> > Could you give a try to this patch?
> > 
> > 
> > x.patch
> > 
> > diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> > index 7db79c1b8084..4886b1599014 100644
> > --- a/net/netfilter/nf_conntrack_netlink.c
> > +++ b/net/netfilter/nf_conntrack_netlink.c
> > @@ -1256,7 +1256,6 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
> >  	struct nf_conntrack_tuple tuple;
> >  	struct nf_conn *ct;
> >  	struct nfgenmsg *nfmsg = nlmsg_data(nlh);
> > -	u_int8_t u3 = nfmsg->version ? nfmsg->nfgen_family : AF_UNSPEC;
> >  	struct nf_conntrack_zone zone;
> >  	int err;
> >  
> > @@ -1266,11 +1265,13 @@ static int ctnetlink_del_conntrack(struct net *net, struct sock *ctnl,
> >  
> >  	if (cda[CTA_TUPLE_ORIG])
> >  		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_ORIG,
> > -					    u3, &zone);
> > +					    nfmsg->version, &zone);
> nfmsg->nfgen_family?
> 
> >  	else if (cda[CTA_TUPLE_REPLY])
> >  		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_REPLY,
> > -					    u3, &zone);
> > +					    nfmsg->version, &zone);
> Same here?

Right, will send v2. Thanks Nicolas.
