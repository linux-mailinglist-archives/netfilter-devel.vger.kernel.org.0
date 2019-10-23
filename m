Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A3DE1897
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Oct 2019 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390721AbfJWLNw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Oct 2019 07:13:52 -0400
Received: from correo.us.es ([193.147.175.20]:57268 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390386AbfJWLNw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:13:52 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EB911A1A34C
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Oct 2019 13:13:47 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DBFDDD1929
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Oct 2019 13:13:47 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DB3192DC8F; Wed, 23 Oct 2019 13:13:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E9D30DA4CA;
        Wed, 23 Oct 2019 13:13:45 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 23 Oct 2019 13:13:45 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BD30341E4804;
        Wed, 23 Oct 2019 13:13:45 +0200 (CEST)
Date:   Wed, 23 Oct 2019 13:13:46 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnfnetlink 1/1] src: Minimally resurrect doxygen
 documentation
Message-ID: <20191023111346.4xoujsy6h2j7cv6y@salvia>
References: <20191014020223.21757-1-duncan_roe@optusnet.com.au>
 <20191014020223.21757-2-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014020223.21757-2-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 14, 2019 at 01:02:23PM +1100, Duncan Roe wrote:
> The documentation was written in the days before doxygen required groups or even
> doxygen.cfg, so create doxygen.cfg.in and introduce one \defgroup per source
> file, encompassing pretty-much the whole file.
> 
> Also add a tiny \mainpage.
> 
> Added:
> 
>  doxygen.cfg.in: Same as for libmnl except FILE_PATTERNS = *.c linux_list.h
> 
> Updated:
> 
>  configure.ac: Create doxygen.cfg
> 
>  include/linux_list.h: Add defgroup
> 
>  src/iftable.c: Add defgroup
> 
>  src/libnfnetlink.c: Add mainpage and defgroup

I'm ambivalent about this, it's been up on the table for a while.

This library is rather old, and new applications should probably
be based instead used libmnl, which is a better choice.

Did you already queue patches to make documentation for libnfnetlink
locally there? I would like not to discourage you in your efforts to
help us improve documentation, which is always extremely useful for
everyone.

Let me know, thanks.
