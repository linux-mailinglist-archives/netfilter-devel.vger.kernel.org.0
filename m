Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB41485E9
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 16:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfFQOoa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 10:44:30 -0400
Received: from mail.us.es ([193.147.175.20]:47004 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfFQOoa (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:44:30 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id ABCFA11480C
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 16:44:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9BF71DA70B
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 16:44:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 90CBCDA70A; Mon, 17 Jun 2019 16:44:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7F420DA702;
        Mon, 17 Jun 2019 16:44:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 17 Jun 2019 16:44:24 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5891C4265A2F;
        Mon, 17 Jun 2019 16:44:24 +0200 (CEST)
Date:   Mon, 17 Jun 2019 16:44:23 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] datatype: fix print of raw numerical symbol values
Message-ID: <20190617144423.iu6h66egns4hj3vj@salvia>
References: <20190617095542.5702-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617095542.5702-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:55:42AM +0200, Florian Westphal wrote:
> The two rules:
> arp operation 1-2 accept
> arp operation 256-512 accept
> 
> are both shown as 256-512:
> 
>         chain in_public {
>                 arp operation 256-512 accept
>                 arp operation 256-512 accept
>                 meta mark "1"
>                 tcp flags 2,4
>         }
> 
> This is because range expression enforces numeric output,
> yet nft_print doesn't respect byte order.
> 
> Behave as if we had no symbol in the first place and call
> the base type print function instead.
> 
> This means we now respect format specifier as well:
> 	chain in_public {
>                 arp operation 1-2 accept
>                 arp operation 256-512 accept
>                 meta mark 0x00000001
>                 tcp flags 0x2,0x4
> 	}
> 
> Without fix, added test case will fail:
> 'add rule arp test-arp input arp operation 1-2': 'arp operation 1-2' mismatches 'arp operation 256-512'
> 
> v2: in case of -n, also elide quotation marks, just as if we would not
> have found a symbolic name.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks Florian.
