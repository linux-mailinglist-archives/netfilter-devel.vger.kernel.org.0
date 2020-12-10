Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562992D5B7B
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Dec 2020 14:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgLJNUC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Dec 2020 08:20:02 -0500
Received: from correo.us.es ([193.147.175.20]:42476 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733083AbgLJNTz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:19:55 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3F83CDA705
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Dec 2020 14:18:59 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2BF2611510F
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Dec 2020 14:18:59 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 21913115104; Thu, 10 Dec 2020 14:18:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F1A8CDA72F;
        Thu, 10 Dec 2020 14:18:56 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 10 Dec 2020 14:18:56 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D73CE41E4804;
        Thu, 10 Dec 2020 14:18:56 +0100 (CET)
Date:   Thu, 10 Dec 2020 14:19:06 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: ctnetlink: always include remaining
 timeout
Message-ID: <20201210131906.GA18962@salvia>
References: <20201210112022.7793-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210112022.7793-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:20:22PM +0100, Florian Westphal wrote:
> DESTROY events do not include the remaining timeout.
> 
> Unconditionally including the timeout allows to see if the entry timed
> timed out or was removed explicitly.
> 
> The latter case can happen when a conntrack gets deleted prematurely,
> e.g. due to a tcp reset, module removal, netdev notifier (nat/masquerade
> device went down), ctnetlink and so on.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Might make sense to further extend nf_ct_delete and also pass a
>  reason code in the future.

IIRC, TCP state is not included in the event, right?

This has been requested many times in the past, to debug connectivity
issues too.

Probably extending .to_nlattr to take a bool parameter to specify if
this is the destroy event path, then _only_ include the TCP state
information there (other TCP information is not relevant and netlink
bandwidth is limited from the event path).

Thanks.
