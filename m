Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0816FF0A
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Feb 2020 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgBZMbX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Feb 2020 07:31:23 -0500
Received: from correo.us.es ([193.147.175.20]:46714 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZMbW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:31:22 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A3C0AE8B90
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Feb 2020 13:31:13 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8EFF3FC544
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Feb 2020 13:31:13 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 84E794EA64; Wed, 26 Feb 2020 13:31:13 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0F847DA7B2;
        Wed, 26 Feb 2020 13:31:11 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 26 Feb 2020 13:31:11 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id DECA842EF42B;
        Wed, 26 Feb 2020 13:31:10 +0100 (CET)
Date:   Wed, 26 Feb 2020 13:31:18 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 1/2] expressions: concat: add typeof support
Message-ID: <20200226123118.7hpzwr32vteabvrt@salvia>
References: <20200226122627.27835-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226122627.27835-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 26, 2020 at 01:26:26PM +0100, Florian Westphal wrote:
> Previous patches allow to pass concatenations as the mapped-to
> data type.
> 
> This doesn't work with typeof() because the concat expression has
> no support to store the typeof data in the kernel, leading to:
> 
> map t2 {
>     typeof numgen inc mod 2 : ip daddr . tcp dport
> 
> being shown as
>      type 0 : ipv4_addr . inet_service
> 
> ... which can't be parsed back by nft.
> 
> This allows the concat expression to store the sub-expressions
> in set of nested attributes.

LGTM, thanks Florian.
