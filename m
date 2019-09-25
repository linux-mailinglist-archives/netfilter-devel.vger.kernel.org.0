Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1ABDA61
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 11:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfIYJAb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 05:00:31 -0400
Received: from correo.us.es ([193.147.175.20]:55686 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfIYJAY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:00:24 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AF1B43066B8
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Sep 2019 11:00:19 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 99A7710079B
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Sep 2019 11:00:19 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 94C10FF6E4; Wed, 25 Sep 2019 11:00:19 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 408B9DA4D0;
        Wed, 25 Sep 2019 11:00:17 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 25 Sep 2019 11:00:17 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 18EFC42EF4E4;
        Wed, 25 Sep 2019 11:00:17 +0200 (CEST)
Date:   Wed, 25 Sep 2019 11:00:18 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: use __u8 instead of uint8_t in uapi header
Message-ID: <20190925090018.2yuzqac23tu3uzxq@salvia>
References: <20190923224007.20179-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190923224007.20179-1-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 24, 2019 at 07:40:06AM +0900, Masahiro Yamada wrote:
> When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
> make sure they can be included from user-space.
> 
> Currently, linux/netfilter_bridge/ebtables.h is excluded from the test
> coverage. To make it join the compile-test, we need to fix the build
> errors attached below.
> 
> For a case like this, we decided to use __u{8,16,32,64} variable types
> in this discussion:
> 
>   https://lkml.org/lkml/2019/6/5/18
> 
> Build log:
> 
>   CC      usr/include/linux/netfilter_bridge/ebtables.h.s
> In file included from <command-line>:32:0:
> ./usr/include/linux/netfilter_bridge/ebtables.h:126:4: error: unknown type name ‘uint8_t’
>     uint8_t revision;
>     ^~~~~~~
> ./usr/include/linux/netfilter_bridge/ebtables.h:139:4: error: unknown type name ‘uint8_t’
>     uint8_t revision;
>     ^~~~~~~
> ./usr/include/linux/netfilter_bridge/ebtables.h:152:4: error: unknown type name ‘uint8_t’
>     uint8_t revision;
>     ^~~~~~~

Applied.
