Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA11B6FF27
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfGVMBN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 08:01:13 -0400
Received: from mail.us.es ([193.147.175.20]:51634 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbfGVMBN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:01:13 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id ADA74C1DF1
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jul 2019 14:01:11 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9DF1A11510F
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jul 2019 14:01:11 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9241B115109; Mon, 22 Jul 2019 14:01:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 23DF51150CC;
        Mon, 22 Jul 2019 14:01:09 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 22 Jul 2019 14:01:09 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.214.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DBAD040705C4;
        Mon, 22 Jul 2019 14:01:08 +0200 (CEST)
Date:   Mon, 22 Jul 2019 14:01:07 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] src: evaluate: support prefix expression in
 statements
Message-ID: <20190722120107.76yebnqhmeinhowh@salvia>
References: <20190722093740.5176-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722093740.5176-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:37:40AM +0200, Florian Westphal wrote:
> Currently nft dumps core when it encounters a prefix expression as
> part of a statement, e.g.
> iifname ens3 snat to 10.0.0.0/28
> 
> yields:
> BUG: unknown expression type prefix
> nft: netlink_linearize.c:688: netlink_gen_expr: Assertion `0' failed.
> 
> This assertion is correct -- we can't linearize a prefix because
> kernel doesn't know what that is.
> 
> For LHS prefixes, they get converted to a binary 'and' such as
> '10.0.0.0 & 255.255.255.240'.  For RHS, we can do something similar
> and convert them into a range.
> 
> snat to 10.0.0.0/28 will be converted into:
> iifname "ens3" snat to 10.0.0.0-10.0.0.15
> 
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1187
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Please, double check before pushing this out that valgrind is happy
with this (no memleaks).

Thanks.
