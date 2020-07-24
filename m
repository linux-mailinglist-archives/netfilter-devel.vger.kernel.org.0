Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9117422C448
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Jul 2020 13:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGXLVW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 24 Jul 2020 07:21:22 -0400
Received: from correo.us.es ([193.147.175.20]:40810 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGXLVW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:21:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7C6251878B7
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Jul 2020 13:21:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6BF13DA84A
        for <netfilter-devel@vger.kernel.org>; Fri, 24 Jul 2020 13:21:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 666FDDA72F; Fri, 24 Jul 2020 13:21:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5EB43DA78D;
        Fri, 24 Jul 2020 13:21:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 24 Jul 2020 13:21:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 39C9F42EFB80;
        Fri, 24 Jul 2020 13:21:19 +0200 (CEST)
Date:   Fri, 24 Jul 2020 13:21:18 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH v3] iptables: accept lock file name at runtime
Message-ID: <20200724112118.GA25680@salvia>
References: <20200717083940.618618-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717083940.618618-1-gscrivan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:39:40AM +0200, Giuseppe Scrivano wrote:
> allow users to override at runtime the lock file to use through the
> XTABLES_LOCKFILE environment variable.
> 
> It allows to use iptables when the user has granted enough
> capabilities (e.g. a user+network namespace) to configure the network
> but that lacks access to the XT_LOCK_NAME (by default placed under
> /run).
> 
> $ XTABLES_LOCKFILE=/tmp/xtables unshare -rn iptables ...

Applied, thanks.
