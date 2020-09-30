Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875D827E847
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Sep 2020 14:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgI3MNW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Sep 2020 08:13:22 -0400
Received: from correo.us.es ([193.147.175.20]:33304 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgI3MNW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:13:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0C14F1BFA99
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Sep 2020 14:13:19 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EC34CDA704
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Sep 2020 14:13:18 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E0CE0DA7B6; Wed, 30 Sep 2020 14:13:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5BE29DA791;
        Wed, 30 Sep 2020 14:13:15 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 30 Sep 2020 14:13:15 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3563342EF9E1;
        Wed, 30 Sep 2020 14:13:15 +0200 (CEST)
Date:   Wed, 30 Sep 2020 14:13:14 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Arturo Borrero Gonzalez <arturo@netfilter.org>,
        Phil Sutter <phil@nwl.cc>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: iptables-nft-restore issue
Message-ID: <20200930121314.GA21983@salvia>
References: <198c69b7-d7b2-f910-c469-199bfe2fda28@netfilter.org>
 <20200930115922.GC20140@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930115922.GC20140@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:59:22PM +0200, Florian Westphal wrote:
> Arturo Borrero Gonzalez <arturo@netfilter.org> wrote:
> > Hi Phil,
> > 
> > (CC'ing netfilter-devel)
> > 
> > I discovered my openstack neutron linuxbridge-agent malfunctioning when using
> > iptables-nft and it seems this ruleset is causing the issue:
>  
> > === 8< ===
> > *raw
> > :OUTPUT - [0:0]
> > :PREROUTING - [0:0]

If I replace these two by:

:OUTPUT ACCEPT [0:0]
:PREROUTING ACCEPT [0:0]

it works. Looks like some issue with the basechain policy?

> > :neutron-linuxbri-OUTPUT - [0:0]
> > :neutron-linuxbri-PREROUTING - [0:0]
> > -I OUTPUT 1 -j neutron-linuxbri-OUTPUT
> > -I PREROUTING 1 -j neutron-linuxbri-PREROUTING
> > -I neutron-linuxbri-PREROUTING 1 -m physdev --physdev-in brq7425e328-56 -m
> > comment --comment "Set zone for f101a28-1d" -j CT --zone 4097
> > -I neutron-linuxbri-PREROUTING 2 -i brq7425e328-56 -m comment --comment "Set
> > zone for f101a28-1d" -j CT --zone 4097
> > -I neutron-linuxbri-PREROUTING 3 -m physdev --physdev-in tap7f101a28-1d -m
> > comment --comment "Set zone for f101a28-1d" -j CT --zone 4097
> > 
> > COMMIT
