Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F211CCBCB
	for <lists+netfilter-devel@lfdr.de>; Sun, 10 May 2020 17:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgEJPKG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 10 May 2020 11:10:06 -0400
Received: from correo.us.es ([193.147.175.20]:38118 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgEJPKF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 10 May 2020 11:10:05 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0B90A154E83
        for <netfilter-devel@vger.kernel.org>; Sun, 10 May 2020 17:10:04 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F0B3811540B
        for <netfilter-devel@vger.kernel.org>; Sun, 10 May 2020 17:10:03 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E45C8961FF; Sun, 10 May 2020 17:10:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id ED6AA115410;
        Sun, 10 May 2020 17:10:01 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 10 May 2020 17:10:01 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D0A2442EF4E1;
        Sun, 10 May 2020 17:10:01 +0200 (CEST)
Date:   Sun, 10 May 2020 17:10:01 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue 1/1] src: add pktb_alloc2() and
 pktb_head_size()
Message-ID: <20200510151001.GA6216@salvia>
References: <20200510135317.15526-1-duncan_roe@optusnet.com.au>
 <20200510135317.15526-2-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510135317.15526-2-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, May 10, 2020 at 11:53:17PM +1000, Duncan Roe wrote:
> pktb_alloc2() avoids the malloc/free overhead in pktb_alloc() and also
> eliminates memcpy() of the payload except when mangling increases the
> packet length.
> 
>  - pktb_mangle() does the memcpy() if need be.
>    Packet metadata is altered in this case
>  - All the _mangle functions are altered to account for possible change tp
>    packet metadata
>  - Documentation is updated

Many chunks of this patchset look very much the same I posted. I'll
apply my patchset and please rebase any update on top of it.

Thanks.
