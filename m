Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432D82A1556
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Oct 2020 11:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgJaKx2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 31 Oct 2020 06:53:28 -0400
Received: from correo.us.es ([193.147.175.20]:45578 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgJaKx1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 31 Oct 2020 06:53:27 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 95574E862B
        for <netfilter-devel@vger.kernel.org>; Sat, 31 Oct 2020 11:53:26 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 86379DA730
        for <netfilter-devel@vger.kernel.org>; Sat, 31 Oct 2020 11:53:26 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7BFDBDA73F; Sat, 31 Oct 2020 11:53:26 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6C4ADDA730;
        Sat, 31 Oct 2020 11:53:24 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 31 Oct 2020 11:53:24 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4B01C42EF42B;
        Sat, 31 Oct 2020 11:53:24 +0100 (CET)
Date:   Sat, 31 Oct 2020 11:53:23 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Jose M. Guisado Gomez" <guigom@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/5] add support for reject verdict in netdev
Message-ID: <20201031105323.GA2135@salvia>
References: <20201022194355.1816-1-guigom@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201022194355.1816-1-guigom@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 22, 2020 at 09:43:50PM +0200, Jose M. Guisado Gomez wrote:
> This patch series comprises changes in kernel space and user space to
> enable the reject verdict for the netdev family.
> 
> In addition, some code refactor has been made to the nft_reject
> infrastructure in kernel, adding two new functions to create the icmp or
> tcp reset skbuffs to avoid using ip_local_out. Also, reject init and
> dump functions has been unified into nft_reject.c
> 
> This follows previous work from Laura García.
> 
> nf-next
> -------
> 
> Jose M. Guisado Gomez (3):
>   net: netfilter: add reject skbuff creation helpers
>   net: netfilter: unify reject init and dump into nft_reject
>   net: netfilter: add reject verdict support for netdev

Applied these three patches to nf-next, thanks.
