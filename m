Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E461490FF1
	for <lists+netfilter-devel@lfdr.de>; Sat, 17 Aug 2019 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfHQKX4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 17 Aug 2019 06:23:56 -0400
Received: from correo.us.es ([193.147.175.20]:40520 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHQKX4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 17 Aug 2019 06:23:56 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BBA96EA469
        for <netfilter-devel@vger.kernel.org>; Sat, 17 Aug 2019 12:23:53 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AB6C2D2CBB
        for <netfilter-devel@vger.kernel.org>; Sat, 17 Aug 2019 12:23:53 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A1144DA72F; Sat, 17 Aug 2019 12:23:53 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A3731DA72F;
        Sat, 17 Aug 2019 12:23:51 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 17 Aug 2019 12:23:51 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 8279A4265A32;
        Sat, 17 Aug 2019 12:23:51 +0200 (CEST)
Date:   Sat, 17 Aug 2019 12:23:51 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 0/8] add typeof keyword
Message-ID: <20190817102351.x2s2vj5hgvsi5vak@salvia>
References: <20190816144241.11469-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816144241.11469-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Florian,

On Fri, Aug 16, 2019 at 04:42:33PM +0200, Florian Westphal wrote:
> This patch series adds the typeof keyword.
> 
> The only dependency is a small change to libnftnl to add two new
> UDATA_SET_TYPEOF enum values.

Thanks for working on this.

> named set can be configured as follows:
> 
> set os {
>    type typeof(osf name)
>    elements = { "Linux", "Windows" }
> }
>
> or
> nft add set ip filter allowed "{ type typeof(ip daddr) . typeof(tcp dport); }"

I know I sent a RFC using typeof(), I wonder if you could just use the
selector instead, it's a bit of a lot of type typeof() . typeof()
probably.

So this is left as this:

        type osf name

in concatenations, like this:

        nft add set ip filter allowed "{ type ip daddr . tcp dport; }"

Probably I would ask my sysadmin friends what they think. I spent too
much time on coding, so all these typeof() look natural to me, but it
might be a bit too much syntactic sugar for someone that is more in
network operations, not sure.

P.S: patch 1/8 and 2/8 are related to this patchset? After quick
glance, not obvious to me or if they are again related to multiple
nft_ctx_new() calls.
