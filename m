Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260F7F76F
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Apr 2019 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfD3L7J (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Apr 2019 07:59:09 -0400
Received: from mail.us.es ([193.147.175.20]:48708 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbfD3Lqt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:46:49 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B558D9A7BD
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Apr 2019 13:46:47 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A6512DA70F
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Apr 2019 13:46:47 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9BED4DA704; Tue, 30 Apr 2019 13:46:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 12024DA70C;
        Tue, 30 Apr 2019 13:46:45 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 30 Apr 2019 13:46:45 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (129.166.216.87.static.jazztel.es [87.216.166.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BC7904265A31;
        Tue, 30 Apr 2019 13:46:44 +0200 (CEST)
Date:   Tue, 30 Apr 2019 13:46:44 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, Jann Haber <jann.haber@selfnet.de>
Subject: Re: [PATCH nf] netfilter: nf_tables: delay chain policy update until
 transaction is complete
Message-ID: <20190430114644.hnoz5ec2557gs6nf@salvia>
References: <20190412090925.8668-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412090925.8668-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:09:25AM +0200, Florian Westphal wrote:
> When we process a long ruleset of the form
> 
> chain input {
>    type filter hook input priority filter; policy drop;
>    ...
> }
> 
> Then the base chain gets registered early on, we then continue to
> process/validate the next messages coming in the same transaction.
> 
> Problem is that if the base chain policy is 'drop', it will take effect
> immediately, which causes all traffic to get blocked until the
> transaction completes or is aborted.
> 
> Fix this by deferring the policy until the transaction has been
> processed and all of the rules have been flagged as active.

Applied to nf, thanks Florian.
