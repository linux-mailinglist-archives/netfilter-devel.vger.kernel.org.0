Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9782410E
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfETTVS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 15:21:18 -0400
Received: from mail.us.es ([193.147.175.20]:41600 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfETTVS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 15:21:18 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 60E57BAE82
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:21:16 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5489BDA705
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:21:16 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 4A250DA703; Mon, 20 May 2019 21:21:16 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5E0B2DA705;
        Mon, 20 May 2019 21:21:14 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 20 May 2019 21:21:14 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3CB684265A31;
        Mon, 20 May 2019 21:21:14 +0200 (CEST)
Date:   Mon, 20 May 2019 21:21:13 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: fix oops during rule dump
Message-ID: <20190520192113.izdj2jecprr4anrg@salvia>
References: <netfilter-devel>
 <20190430125311.7267-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430125311.7267-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 30, 2019 at 02:53:11PM +0200, Florian Westphal wrote:
> We can oops in nf_tables_fill_rule_info().
> 
> Its not possible to fetch previous element in rcu-protected lists
> when deletions are not prevented somehow: list_del_rcu poisons
> the ->prev pointer value.
> 
> Before rcu-conversion this was safe as dump operations did hold
> nfnetlink mutex.
> 
> Pass previous rule as argument, obtained by keeping a pointer to
> the previous rule during traversal.

Applied, thanks.
