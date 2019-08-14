Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5CFF8CD16
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 09:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfHNHmO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 03:42:14 -0400
Received: from correo.us.es ([193.147.175.20]:41928 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfHNHmO (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:42:14 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 87BC0EDB10
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Aug 2019 09:42:11 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 78E1F1150D8
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Aug 2019 09:42:11 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6E4C8DA704; Wed, 14 Aug 2019 09:42:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 57298DA704;
        Wed, 14 Aug 2019 09:42:09 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 14 Aug 2019 09:42:09 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.218.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 30CC44265A2F;
        Wed, 14 Aug 2019 09:42:09 +0200 (CEST)
Date:   Wed, 14 Aug 2019 09:42:08 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 2/3] src: parser: fix parsing of chain priority
 and policy on bigendian
Message-ID: <20190814074208.tyg7h2o2mtd23pot@salvia>
References: <20190813201246.5543-1-fw@strlen.de>
 <20190813201246.5543-3-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813201246.5543-3-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:12:45PM +0200, Florian Westphal wrote:
> tests/shell/testcases/flowtable/0001flowtable_0
> tests/shell/testcases/nft-f/0008split_tables_0
> fail the 'dump compare' on s390x.
> The priority (10) turns to 0, and accept turned to drop.
> 
> Problem is that '$1' is a 64bit value -- then we pass the address
> and import 'int' -- we then get the upper all zero bits.
> 
> Add a 32bit interger type and use that.
> 
> v2: add uint32_t type to union, v1 used temporary value instead.
> 
> Fixes: 627c451b2351 ("src: allow variables in the chain priority specification")
> Fixes: dba4a9b4b5fe ("src: allow variable in chain policy")
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
