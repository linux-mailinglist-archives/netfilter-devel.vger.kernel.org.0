Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A79282CE4
	for <lists+netfilter-devel@lfdr.de>; Sun,  4 Oct 2020 21:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgJDTJt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 4 Oct 2020 15:09:49 -0400
Received: from correo.us.es ([193.147.175.20]:55188 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgJDTJt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:09:49 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0F846E8623
        for <netfilter-devel@vger.kernel.org>; Sun,  4 Oct 2020 21:09:48 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 03603DA73F
        for <netfilter-devel@vger.kernel.org>; Sun,  4 Oct 2020 21:09:48 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id ED41BDA730; Sun,  4 Oct 2020 21:09:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E8855DA73D;
        Sun,  4 Oct 2020 21:09:45 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 04 Oct 2020 21:09:45 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C194742EF9E0;
        Sun,  4 Oct 2020 21:09:45 +0200 (CEST)
Date:   Sun, 4 Oct 2020 21:09:45 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nfnetlink: place subsys mutexes in
 distinct lockdep classes
Message-ID: <20201004190945.GA3806@salvia>
References: <20201002115129.22273-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002115129.22273-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:51:29PM +0200, Florian Westphal wrote:
[...]
> Time to place them in distinct classes to avoid these warnings.

Applied, thanks
