Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328094C01E
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Jun 2019 19:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFSRqs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Jun 2019 13:46:48 -0400
Received: from mail.us.es ([193.147.175.20]:41376 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfFSRqs (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:46:48 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 68CF4C1D50
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Jun 2019 19:46:46 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5807ADA714
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Jun 2019 19:46:46 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 49CBDDA707; Wed, 19 Jun 2019 19:46:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 802E5DA704;
        Wed, 19 Jun 2019 19:46:43 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 19 Jun 2019 19:46:43 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5225C4265A2F;
        Wed, 19 Jun 2019 19:46:43 +0200 (CEST)
Date:   Wed, 19 Jun 2019 19:46:42 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        wenxu <wenxu@ucloud.cn>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] netfilter: synproxy: fix building syncookie calls
Message-ID: <20190619174642.hvjvmfaptfdkmbpk@salvia>
References: <20190619125500.1054426-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619125500.1054426-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 19, 2019 at 02:54:36PM +0200, Arnd Bergmann wrote:
> When either CONFIG_IPV6 or CONFIG_SYN_COOKIES are disabled, the kernel
> fails to build:
> 
> include/linux/netfilter_ipv6.h:180:9: error: implicit declaration of function '__cookie_v6_init_sequence'
>       [-Werror,-Wimplicit-function-declaration]
>         return __cookie_v6_init_sequence(iph, th, mssp);
> include/linux/netfilter_ipv6.h:194:9: error: implicit declaration of function '__cookie_v6_check'
>       [-Werror,-Wimplicit-function-declaration]
>         return __cookie_v6_check(iph, th, cookie);
> net/ipv6/netfilter.c:237:26: error: use of undeclared identifier '__cookie_v6_init_sequence'; did you mean 'cookie_init_sequence'?
> net/ipv6/netfilter.c:238:21: error: use of undeclared identifier '__cookie_v6_check'; did you mean '__cookie_v4_check'?
> 
> Fix the IS_ENABLED() checks to match the function declaration
> and definitions for these.

I made this:

https://patchwork.ozlabs.org/patch/1117735/

Basically it does:

+#endif
+#if IS_MODULE(CONFIG_IPV6) && defined(CONFIG_SYN_COOKIES)
        .cookie_init_sequence   = __cookie_v6_init_sequence,
        .cookie_v6_check        = __cookie_v6_check,
 #endif

If CONFIG_IPV6=n, then net/ipv6/netfilter.c is never compiled.

Unless I'm missing anything, I'd prefer my patch because it's a bit
less of ifdefs 8-)

Thanks!
