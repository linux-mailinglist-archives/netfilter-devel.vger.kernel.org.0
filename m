Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE52C51FE1
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 02:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFYAYI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Jun 2019 20:24:08 -0400
Received: from mail.us.es ([193.147.175.20]:39660 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfFYAYI (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:24:08 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EC6EEC04AF
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 02:24:06 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DD467DA707
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 02:24:06 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D1EBDDA702; Tue, 25 Jun 2019 02:24:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CD672DA702;
        Tue, 25 Jun 2019 02:24:04 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 25 Jun 2019 02:24:04 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AB5E84265A2F;
        Tue, 25 Jun 2019 02:24:04 +0200 (CEST)
Date:   Tue, 25 Jun 2019 02:24:04 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] files: Move netdev-ingress.nft to /etc/nftables as
 well
Message-ID: <20190625002404.63o7novb2ett2yoo@salvia>
References: <20190624151238.4869-1-phil@nwl.cc>
 <20190624151446.2umdf4bzem4h7yqj@breakpoint.cc>
 <20190624162406.GB9218@orbyte.nwl.cc>
 <20190624164941.dhcm57r35km3azbg@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624164941.dhcm57r35km3azbg@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 24, 2019 at 06:49:41PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > > Right.  Do you think we should also add in inet-nat.nft example,
> > > or even replace the ipvX- ones?
> > 
> > Having an inet family nat example would be wonderful! Can inet NAT
> > replace IPvX-ones completely or are there any limitations as to what is
> > possible in rules?
> 
> I'm not aware of any limitations.

Only limitation is that older kernels do not support NAT for the inet
family.
