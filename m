Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC770A5C
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 22:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfGVUKT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 16:10:19 -0400
Received: from mail.us.es ([193.147.175.20]:58786 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfGVUKT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:10:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 912A381400
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jul 2019 22:10:17 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 82F391150CC
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jul 2019 22:10:17 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 783A41150B9; Mon, 22 Jul 2019 22:10:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8A5D6DA704;
        Mon, 22 Jul 2019 22:10:15 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 22 Jul 2019 22:10:15 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.183.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 129E04265A2F;
        Mon, 22 Jul 2019 22:10:14 +0200 (CEST)
Date:   Mon, 22 Jul 2019 22:10:11 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH conntrack-tools] conntrackd: cthelper: Add new SLP helper
Message-ID: <20190722201011.5bmpzw46zesm57g2@salvia>
References: <20190719073124.7E803E00A9@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719073124.7E803E00A9@unicorn.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:31:24AM +0200, Michal Kubecek wrote:
> Service Location Protocol (SLP) uses multicast requests for DA (Directory
> agent) and SA (Service agent) discovery. Replies to these requests are
> unicast and their source address does not match destination address of the
> request so that we need a conntrack helper. A kernel helper was submitted
> back in 2013 but was rejected as userspace helper infrastructure is
> preferred. This adds an SLP helper to conntrackd.
> 
> As the function of SLP helper is the same as what existing mDNS helper
> does, src/helpers/slp.c is essentially just a copy of src/helpers/mdns.c,
> except for the default timeout and example usage. As with mDNS helper,
> there is no NAT support for the time being as that would probably require
> kernel side changes and certainly further study (and could possibly work
> only for source NAT).

Applied, thanks.
