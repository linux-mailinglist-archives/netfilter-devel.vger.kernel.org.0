Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208B7EE5F9
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Nov 2019 18:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfKDR2v (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 4 Nov 2019 12:28:51 -0500
Received: from correo.us.es ([193.147.175.20]:59404 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfKDR2u (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:28:50 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 96B4650554A
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 18:28:46 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8795AA7E1E
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 18:28:46 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7D0CFDA72F; Mon,  4 Nov 2019 18:28:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7D743DA72F;
        Mon,  4 Nov 2019 18:28:44 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 04 Nov 2019 18:28:44 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 59BCF41E4801;
        Mon,  4 Nov 2019 18:28:44 +0100 (CET)
Date:   Mon, 4 Nov 2019 18:28:46 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnfnetlink v3 1/2] Minimally resurrect doxygen
 documentation
Message-ID: <20191104172846.55lfay2e65otarls@salvia>
References: <20191026051937.GA17407@dimstar.local.net>
 <20191027084907.24291-2-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027084907.24291-2-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Oct 27, 2019 at 07:49:06PM +1100, Duncan Roe wrote:
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

Applied, thanks.

I have kept back include/linux_list.h, although this is offering the
linux list API in libnfnetlink, this was never intended to be the
purpose of this library, so I removed that part before applying.
