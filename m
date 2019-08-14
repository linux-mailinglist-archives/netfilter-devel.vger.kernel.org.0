Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA98CD19
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 09:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHNHmX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 03:42:23 -0400
Received: from correo.us.es ([193.147.175.20]:41972 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfHNHmX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:42:23 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 80716EDB13
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Aug 2019 09:42:20 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 717B564497
        for <netfilter-devel@vger.kernel.org>; Wed, 14 Aug 2019 09:42:20 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 70C0E5C023; Wed, 14 Aug 2019 09:42:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6C5B821FE4;
        Wed, 14 Aug 2019 09:42:18 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 14 Aug 2019 09:42:18 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.218.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 433A64265A2F;
        Wed, 14 Aug 2019 09:42:18 +0200 (CEST)
Date:   Wed, 14 Aug 2019 09:42:17 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 3/3] src: mnl: retry when we hit -ENOBUFS
Message-ID: <20190814074217.zqjgt6pzuxptuy56@salvia>
References: <20190813201246.5543-1-fw@strlen.de>
 <20190813201246.5543-4-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813201246.5543-4-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:12:46PM +0200, Florian Westphal wrote:
> tests/shell/testcases/transactions/0049huge_0
> 
> still fails with ENOBUFS error after endian fix done in
> previous patch.  Its enough to increase the scale factor (4)
> on s390x, but rather than continue with these "guess the proper
> size" game, just increase the buffer size and retry up to 3 times.
> 
> This makes above test work on s390x.
> 
> So, implement what Pablo suggested in the earlier commit:
>     We could also explore increasing the buffer and retry if
>     mnl_nft_socket_sendmsg() hits ENOBUFS if we ever hit this problem again.
> 
> v2: call setsockopt unconditionally, then increase on error.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
