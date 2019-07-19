Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27E6E99A
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jul 2019 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfGSQrs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jul 2019 12:47:48 -0400
Received: from mail.us.es ([193.147.175.20]:50516 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSQrr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:47:47 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1423ABAEE7
        for <netfilter-devel@vger.kernel.org>; Fri, 19 Jul 2019 18:47:46 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 05631DA4D1
        for <netfilter-devel@vger.kernel.org>; Fri, 19 Jul 2019 18:47:46 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EF4BEFF6CC; Fri, 19 Jul 2019 18:47:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 047C8DA704;
        Fri, 19 Jul 2019 18:47:44 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 19 Jul 2019 18:47:44 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [47.60.47.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C51C04265A2F;
        Fri, 19 Jul 2019 18:47:43 +0200 (CEST)
Date:   Fri, 19 Jul 2019 18:47:42 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: userspace conntrack helper and confirming the master conntrack
Message-ID: <20190719164742.iasbyklx47sqpw7y@salvia>
References: <20190718084943.GE24551@unicorn.suse.cz>
 <20190718092128.zbw4qappq6jsb4ja@breakpoint.cc>
 <20190718101806.GF24551@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718101806.GF24551@unicorn.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jul 18, 2019 at 12:18:06PM +0200, Michal Kubecek wrote:
> On Thu, Jul 18, 2019 at 11:21:28AM +0200, Florian Westphal wrote:
> > > I added some more tracing and this is what seems to happen:
> > > 
> > >   - ipv4_confirm() is called for the conntrack from ip_output() via hook
> > >   - nf_confirm() calls attached helper and calls its help() function
> > >     which is nfnl_userspace_cthelper(), that returns 0x78003
> > >   - nf_confirm() returns that without calling nf_confirm_conntrack()
> > >   - verdict 0x78003 is returned to nf_hook_slow() which therefore calls
> > >     nf_queue() to pass this to userspace helper on queue 7
> > >   - nf_queue() returns 0 which is also returned by nf_hook_slow()
> > >   - the packet reappears in nf_reinject() where it passes through
> > >     nf_reroute() and nf_iterate() to the main switch statement
> > >   - it takes NF_ACCEPT branch to call okfn which is ip_finish_output()
> > >   - unless I missed something, there is nothing that could confirm the
> > >     conntrack after that
> > 
> > I broke this with
> > commit 827318feb69cb07ed58bb9b9dd6c2eaa81a116ad
> > ("netfilter: conntrack: remove helper hook again").
> > 
> > Seems we have to revert, i see no other solution at this time.
> 
> Thanks for the quick reply. I can confirm that with commit 827318feb69c
> reverted, the helper works as expected.

I'll schedule a revert in the next net batch.
