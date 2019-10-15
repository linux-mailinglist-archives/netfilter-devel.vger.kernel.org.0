Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4115AD7BB1
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfJOQco (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 12:32:44 -0400
Received: from correo.us.es ([193.147.175.20]:39678 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbfJOQcn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:32:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 921EBFC5E9
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Oct 2019 18:32:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 83604B8001
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Oct 2019 18:32:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 790CEB7FFB; Tue, 15 Oct 2019 18:32:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 705D0DA7B6;
        Tue, 15 Oct 2019 18:32:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 15 Oct 2019 18:32:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4FF9F42EE38F;
        Tue, 15 Oct 2019 18:32:37 +0200 (CEST)
Date:   Tue, 15 Oct 2019 18:32:39 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 4/6] set: Don't bypass checks in
 nftnl_set_set_u{32,64}()
Message-ID: <20191015163239.apk3ziszz56irbtv@salvia>
References: <20191015141658.11325-1-phil@nwl.cc>
 <20191015141658.11325-5-phil@nwl.cc>
 <20191015155346.qgd55w7iypj44q6m@salvia>
 <20191015161134.GY12661@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015161134.GY12661@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 15, 2019 at 06:11:34PM +0200, Phil Sutter wrote:
> Hi,
> 
> On Tue, Oct 15, 2019 at 05:53:46PM +0200, Pablo Neira Ayuso wrote:
> > On Tue, Oct 15, 2019 at 04:16:56PM +0200, Phil Sutter wrote:
> > > By calling nftnl_set_set(), any data size checks are effectively
> > > bypassed. Better call nftnl_set_set_data() directly, passing the real
> > > size for validation.
> > > 
> > > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > 
> > Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > 
> > Probably attribute((deprecated)) is better so we don't forget. Anyway,
> > we can probably nuke this function in the next release.
> 
> But if we drop it, we break ABI, no? Sadly, nftables use(d) the symbol,
> so we would break older nftables versions with the new libnftnl release.
>
> Should I send a v2 setting attribute((deprecated))? I think it's worth
> doing it.

OK.
