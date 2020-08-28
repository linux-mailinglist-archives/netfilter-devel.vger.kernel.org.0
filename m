Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8FC255EC5
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Aug 2020 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgH1QaV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Aug 2020 12:30:21 -0400
Received: from correo.us.es ([193.147.175.20]:44374 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgH1QaU (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:30:20 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4811FDA702
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Aug 2020 18:30:19 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 38D90DA730
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Aug 2020 18:30:19 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2E82FDA72F; Fri, 28 Aug 2020 18:30:19 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1DC24DA704;
        Fri, 28 Aug 2020 18:30:17 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 28 Aug 2020 18:30:17 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 005EA42EF4E0;
        Fri, 28 Aug 2020 18:30:16 +0200 (CEST)
Date:   Fri, 28 Aug 2020 18:30:16 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: do not auto-delete clash
 entries on reply
Message-ID: <20200828163016.GA16743@salvia>
References: <20200825220718.12866-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825220718.12866-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:07:18AM +0200, Florian Westphal wrote:
> Its possible that we have more than one packet with the same ct tuple
> simultaneously, e.g. when an application emits n packets on same UDP
> socket from multiple threads.
> 
> NAT rules might be applied to those packets. With the right set of rules,
> n packets will be mapped to m destinations, where at least two packets end
> up with the same destination.
> 
> When this happens, the existing clash resolution may merge the skb that
> is processed after the first has been received with the identical tuple
> already in hash table.
> 
> However, its possible that this identical tuple is a NAT_CLASH tuple.
> In that case the second skb will be sent, but no reply can be received
> since the reply that is processed first removes the NAT_CLASH tuple.
> 
> Do not auto-delete, this gives a 1 second window for replies to be passed
> back to originator.
> 
> Packets that are coming later (udp stream case) will not be affected:
> they match the original ct entry, not a NAT_CLASH one.
> 
> Also prevent NAT_CLASH entries from getting offloaded.

Applied, thanks.
