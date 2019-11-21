Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA77E1053E3
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 15:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKUODh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 09:03:37 -0500
Received: from correo.us.es ([193.147.175.20]:33162 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfKUODh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:03:37 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CFE8E1C0223
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 15:03:33 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C36B6DA3A9
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 15:03:33 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B7DC6DA4CA; Thu, 21 Nov 2019 15:03:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D8D93B7FF2;
        Thu, 21 Nov 2019 15:03:31 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 21 Nov 2019 15:03:31 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B51CA42EF4E0;
        Thu, 21 Nov 2019 15:03:31 +0100 (CET)
Date:   Thu, 21 Nov 2019 15:03:33 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v2] src: Fix IPv4 checksum calculation
 in AF_BRIDGE packet buffer
Message-ID: <20191121140333.jjgeut3w26hn5k6n@salvia>
References: <20191116031834.13445-1-duncan_roe@optusnet.com.au>
 <20191117023540.23332-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117023540.23332-1-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Nov 17, 2019 at 01:35:40PM +1100, Duncan Roe wrote:
> Updated:
> 
>  src/extra/pktbuff.c: If pktb was created in family AF_BRIDGE, then pktb->len
>                       will include the bytes in the network header.
>                       So set the IPv4 length to "tail - network_header"
>                       rather than len

Applied, thanks.
