Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8693E72BE0
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jul 2019 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGXJ5a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Jul 2019 05:57:30 -0400
Received: from mail.us.es ([193.147.175.20]:45852 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfGXJ5a (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:57:30 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D1DE5B6325
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Jul 2019 11:57:28 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BF70D1150CE
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Jul 2019 11:57:28 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B2D8DAD9C; Wed, 24 Jul 2019 11:57:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7E3D41150CB;
        Wed, 24 Jul 2019 11:57:26 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 24 Jul 2019 11:57:26 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.183.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1BA114265A2F;
        Wed, 24 Jul 2019 11:57:25 +0200 (CEST)
Date:   Wed, 24 Jul 2019 11:57:24 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] doc: fib: explain example in more detail
Message-ID: <20190724095724.o6p6i3qnwdjr5lby@salvia>
References: <20190721104305.29594-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721104305.29594-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jul 21, 2019 at 12:43:05PM +0200, Florian Westphal wrote:
> As noted by Felix Dreissig, fib documentation is quite terse, so explain
> the 'saddr . iif' example with a few more words.
> 
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1220
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks Florian.
