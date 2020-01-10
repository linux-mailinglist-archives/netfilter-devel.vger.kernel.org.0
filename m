Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4D136BCA
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jan 2020 12:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgAJLQV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Jan 2020 06:16:21 -0500
Received: from correo.us.es ([193.147.175.20]:52578 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgAJLQS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:16:18 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0853D18FCE3
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jan 2020 12:16:17 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EE987DA718
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Jan 2020 12:16:16 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E42DADA715; Fri, 10 Jan 2020 12:16:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EDC00DA70F;
        Fri, 10 Jan 2020 12:16:14 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 10 Jan 2020 12:16:14 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D25C442EF4E0;
        Fri, 10 Jan 2020 12:16:14 +0100 (CET)
Date:   Fri, 10 Jan 2020 12:16:14 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] src: doc: Final polish for current
 round
Message-ID: <20200110111614.vu6whtasuxmq5b7h@salvia>
References: <20200110005443.32000-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110005443.32000-1-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:54:43AM +1100, Duncan Roe wrote:
> - Ensure all functions that return something have a \returns
> - Demote more checksum functions to their own groups
>   (reduces number of functions on main pages)
> - Clarify wording where appropriate
> - Add \sa (see also) where appropriate
> - Fix documented function name for nfq_tcp_get_hdr
>   (no other mismatches noticed, but there may be some)
> - Add warnings regarding changing length of tcp packet
> - Make group names unique within libnetfilter_queue
>   (else man pages would be overwritten)

Applied, thanks.
