Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F93DFE875
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 Nov 2019 00:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKOXI7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 18:08:59 -0500
Received: from correo.us.es ([193.147.175.20]:57568 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfKOXI6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:08:58 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 15EB011ADC8
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Nov 2019 00:08:55 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 08AC7B7FFB
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Nov 2019 00:08:55 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F2936B7FF9; Sat, 16 Nov 2019 00:08:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 26CB2DA72F;
        Sat, 16 Nov 2019 00:08:53 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 16 Nov 2019 00:08:53 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F35DE4251480;
        Sat, 16 Nov 2019 00:08:52 +0100 (CET)
Date:   Sat, 16 Nov 2019 00:08:54 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] src: Make sure pktb_alloc() works for
 IPv6 over AF_BRIDGE
Message-ID: <20191115230854.mrdkcgwlinz2g5gm@salvia>
References: <20191113230532.25178-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113230532.25178-1-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:05:32AM +1100, Duncan Roe wrote:
> At least on the local interface, the MAC header of an IPv6 packet specifies
> IPv6 protocol (rather than IP). This surprised me, since the first octet of
> the IP datagram is the IP version, but I guess it's an efficiency thing.
> 
> Without this patch, pktb_alloc() returns NULL when an IPv6 packet is
> encountered.

Applied, thanks.

> Updated:
> 
>  src/extra/pktbuff.c: - Treat ETH_P_IPV6 the same as ETH_P_IP.
>                       - Fix indenting around the affected code.

I have left indentation as is, so this becomes a oneliner.

This double closing curly brace on the same column is bizarre indeed,
but not convinced this double indentation looks better. And I like
this patch became just a oneliner. Thanks.
