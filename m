Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CE4282CE2
	for <lists+netfilter-devel@lfdr.de>; Sun,  4 Oct 2020 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgJDTJR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 4 Oct 2020 15:09:17 -0400
Received: from correo.us.es ([193.147.175.20]:55094 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgJDTJR (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:09:17 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0A536E862B
        for <netfilter-devel@vger.kernel.org>; Sun,  4 Oct 2020 21:09:16 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EF732DA78C
        for <netfilter-devel@vger.kernel.org>; Sun,  4 Oct 2020 21:09:15 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E517CDA704; Sun,  4 Oct 2020 21:09:15 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D25FCDA704;
        Sun,  4 Oct 2020 21:09:13 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 04 Oct 2020 21:09:13 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B75AB42EF9E0;
        Sun,  4 Oct 2020 21:09:13 +0200 (CEST)
Date:   Sun, 4 Oct 2020 21:09:13 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     netfilter-devel@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] ipset: enable memory accounting for ipset allocations
Message-ID: <20201004190913.GA3788@salvia>
References: <202009251545.3tm8FvXD%lkp@intel.com>
 <343416af-f22f-3834-7ee9-14b6dd7558ff@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <343416af-f22f-3834-7ee9-14b6dd7558ff@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 25, 2020 at 11:56:02AM +0300, Vasily Averin wrote:
> Currently netadmin inside non-trusted container can quickly allocate
> whole node's memory via request of huge ipset hashtable.
> Other ipset-related memory allocations should be restricted too.

Applied, thanks.
