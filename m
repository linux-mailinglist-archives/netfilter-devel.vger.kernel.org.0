Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A24B855F2
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Aug 2019 00:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfHGWle (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Aug 2019 18:41:34 -0400
Received: from correo.us.es ([193.147.175.20]:47620 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGWle (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:41:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DD69E1031EF
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Aug 2019 00:41:31 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CF8D2DA704
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Aug 2019 00:41:31 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C53DDDA7B9; Thu,  8 Aug 2019 00:41:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7EED6DA704;
        Thu,  8 Aug 2019 00:41:29 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 08 Aug 2019 00:41:29 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (149.103.108.93.rev.vodafone.pt [93.108.103.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E5CCF4265A2F;
        Thu,  8 Aug 2019 00:41:28 +0200 (CEST)
Date:   Thu, 8 Aug 2019 00:41:26 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC nft] src: avoid re-initing core library when a second
 context struct is allocated
Message-ID: <20190807224125.ysj5qyw3xxgdouc4@salvia>
References: <20190805214917.13747-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805214917.13747-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:49:17PM +0200, Florian Westphal wrote:
> Calling nft_ctx_new() a second time leaks memory, and calling
> nft_ctx_free a second time -- on a different context -- causes
> double-free.
> 
> This patch won't work in case we assume libnftables should be
> thread-safe, in such case we either need a mutex or move all resources
> under nft_ctx scope.

These two should avoid the memleak / double free I think:

https://patchwork.ozlabs.org/patch/1143742/
https://patchwork.ozlabs.org/patch/1143743/

Not thread-safe yet, there is a bunch global variables still in place.
