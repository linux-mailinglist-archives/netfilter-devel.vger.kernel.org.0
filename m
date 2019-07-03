Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1725E353
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfGCL6A (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Jul 2019 07:58:00 -0400
Received: from mail.us.es ([193.147.175.20]:53508 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfGCL6A (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:58:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6923B15AEAA
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 13:57:58 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 596D14CA35
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 13:57:58 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4E2A8DA7B6; Wed,  3 Jul 2019 13:57:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4F1A6114D71;
        Wed,  3 Jul 2019 13:57:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 03 Jul 2019 13:57:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2BFE24265A2F;
        Wed,  3 Jul 2019 13:57:56 +0200 (CEST)
Date:   Wed, 3 Jul 2019 13:57:55 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Thomas Jarosch <thomas.jarosch@intra2net.com>,
        Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Subject: Re: [PATCH nf] netfilter: nfnetlink: avoid deadlock due to
 synchronous request_module
Message-ID: <20190703115755.oujww25hngbg7uu7@salvia>
References: <20190702194140.23764-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702194140.23764-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 02, 2019 at 09:41:40PM +0200, Florian Westphal wrote:
> Thomas and Juliana report a deadlock when running:
> 
> (rmmod nf_conntrack_netlink/xfrm_user)
> 
>   conntrack -e NEW -E &
>   modprobe -v xfrm_user
> 
> They provided following analysis:
> 
> conntrack -e NEW -E
>     netlink_bind()
>         netlink_lock_table() -> increases "nl_table_users"
>             nfnetlink_bind()
>             # does not unlock the table as it's locked by netlink_bind()
>                 __request_module()
>                     call_usermodehelper_exec()
> 
> This triggers "modprobe nf_conntrack_netlink" from kernel, netlink_bind()
> won't return until modprobe process is done.
> 
> "modprobe xfrm_user":
>     xfrm_user_init()
>         register_pernet_subsys()
>             -> grab pernet_ops_rwsem
>                 ..
>                 netlink_table_grab()
>                     calls schedule() as "nl_table_users" is non-zero
> 
> so modprobe is blocked because netlink_bind() increased
> nl_table_users while also holding pernet_ops_rwsem.
> 
> "modprobe nf_conntrack_netlink" runs and inits nf_conntrack_netlink:
>     ctnetlink_init()
>         register_pernet_subsys()
>             -> blocks on "pernet_ops_rwsem" thanks to xfrm_user module
> 
> both modprobe processes wait on one another -- neither can make
> progress.
> 
> Switch netlink_bind() to "nowait" modprobe -- this releases the netlink
> table lock, which then allows both modprobe instances to complete.

Applied, thanks.
