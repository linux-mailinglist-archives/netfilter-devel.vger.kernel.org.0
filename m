Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6869A8C
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jul 2019 20:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfGOSJK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Jul 2019 14:09:10 -0400
Received: from mail.us.es ([193.147.175.20]:41174 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729501AbfGOSJK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:09:10 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2AF3ADA738
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jul 2019 20:09:08 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1D2011150B9
        for <netfilter-devel@vger.kernel.org>; Mon, 15 Jul 2019 20:09:08 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 10C9C203F3; Mon, 15 Jul 2019 20:09:08 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 124E9DA4D1;
        Mon, 15 Jul 2019 20:09:06 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 15 Jul 2019 20:09:06 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D948C4265A32;
        Mon, 15 Jul 2019 20:09:05 +0200 (CEST)
Date:   Mon, 15 Jul 2019 20:09:05 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Laura Garcia <nevola@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Netfilter Development Mailing list 
        <netfilter-devel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 15 (HEADERS_TEST w/ netfilter tables
 offload)
Message-ID: <20190715180905.rytaht5kslpbatcy@salvia>
References: <20190715144848.4cc41e07@canb.auug.org.au>
 <ccb5b818-c191-2d9e-311f-b2c79b7f6823@infradead.org>
 <CAF90-WirEMg7arNOTmo+tyJ20rt_zeN=nr0OO6Qk0Ss8J4QrUA@mail.gmail.com>
 <20190715173341.zth4na7zekjsesaa@salvia>
 <CAK7LNAS0rX_SRXqb=N=Td-DFNWd=PytDFje12gYh2pYNRBVAJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS0rX_SRXqb=N=Td-DFNWd=PytDFje12gYh2pYNRBVAJA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 16, 2019 at 02:56:09AM +0900, Masahiro Yamada wrote:
> On Tue, Jul 16, 2019 at 2:33 AM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >
> > On Mon, Jul 15, 2019 at 07:28:04PM +0200, Laura Garcia wrote:
> > > CC'ing netfilter.
> > >
> > > On Mon, Jul 15, 2019 at 6:45 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > >
> > > > On 7/14/19 9:48 PM, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > >
> > > > > Please do not add v5.4 material to your linux-next included branches
> > > > > until after v5.3-rc1 has been released.
> > > > >
> > > > > Changes since 20190712:
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > I am seeing these build errors from HEADERS_TEST (or KERNEL_HEADERS_TEST)
> > > > for include/net/netfilter/nf_tables_offload.h.s:
> > > >
> > > >   CC      include/net/netfilter/nf_tables_offload.h.s
> > [...]
> > > > Should this header file not be tested?
> 
> This means you must endlessly exclude
> headers that include nf_tables.h
> 
> 
> > Yes, it should indeed be added.
> 
> Adding 'header-test-' is the last resort.

OK, so policy now is that all internal headers should compile
standalone, right?

I can have a look and make it compile standalone.
