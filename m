Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7A127269
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Dec 2019 01:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLTA36 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Dec 2019 19:29:58 -0500
Received: from correo.us.es ([193.147.175.20]:40488 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfLTA36 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:29:58 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 950F9F2581
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Dec 2019 01:29:55 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 85A13DA705
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Dec 2019 01:29:55 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7B50CDA703; Fri, 20 Dec 2019 01:29:55 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5AD09DA705
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Dec 2019 01:29:53 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Dec 2019 01:29:53 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3BDAD4265A5A
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Dec 2019 01:29:53 +0100 (CET)
Date:   Fri, 20 Dec 2019 01:29:53 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: Documentation question
Message-ID: <20191220002953.gv25rcn7kvv43zk4@salvia>
References: <20191215020220.GA10616@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215020220.GA10616@dimstar.local.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Dec 15, 2019 at 01:02:20PM +1100, Duncan Roe wrote:
> Hi Pablo,
> 
> In pktbuff.c, the doc for pktb_mangle states that "It is appropriate to use
> pktb_mangle to change the MAC header".
> 
> This is not true. pktb_mangle always mangles from the network header onwards.
> 
> I can either:
> 
> Whithdraw the offending doc items
>
> OR:
> 
> Adjust pktb_mangle to make the doc correct. This involves changing pktb_mangle,
> nfq_ip_mangle and (soon) nfq_ip6_mangle. The changes would be a no-op for
> AF_INET and AF_INET6 packet buffers.
> 
> What do you think?

You could fix it through signed int dataoff. So the users could
specify a negative offset to mangle the MAC address.

This function was made to update layer 7 payload information to
implement the helpers. So dataoff usually contains the transport
header size.

Let me know, thanks.
