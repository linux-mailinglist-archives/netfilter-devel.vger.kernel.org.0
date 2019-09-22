Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3197BA156
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Sep 2019 09:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfIVHNW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Sep 2019 03:13:22 -0400
Received: from correo.us.es ([193.147.175.20]:36936 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfIVHNW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Sep 2019 03:13:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A0B06E1224
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Sep 2019 09:13:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 91656DA840
        for <netfilter-devel@vger.kernel.org>; Sun, 22 Sep 2019 09:13:18 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 87118DA801; Sun, 22 Sep 2019 09:13:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 42664DA72F;
        Sun, 22 Sep 2019 09:13:16 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 22 Sep 2019 09:13:16 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E32BA4265A5A;
        Sun, 22 Sep 2019 09:13:15 +0200 (CEST)
Date:   Sun, 22 Sep 2019 09:13:15 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: use __u8 instead of uint8_t in uapi header
Message-ID: <20190922071315.iig2lbey5ophuipu@salvia>
References: <20190921134648.1259-1-yamada.masahiro@socionext.com>
 <20190922071111.3gflycy6t4jnjpd4@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190922071111.3gflycy6t4jnjpd4@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Sep 22, 2019 at 09:11:11AM +0200, Pablo Neira Ayuso wrote:
> On Sat, Sep 21, 2019 at 10:46:48PM +0900, Masahiro Yamada wrote:
> > When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
> > make sure they can be included from user-space.
> > 
> > Currently, linux/netfilter_bridge/ebtables.h is excluded from the test
> > coverage. To make it join the compile-test, we need to fix the build
> > errors attached below.
> > 
> > For a case like this, we decided to use __u{8,16,32,64} variable types
> > in this discussion:
> > 
> >   https://lkml.org/lkml/2019/6/5/18
> > 
> > Build log:
> > 
> >   CC      usr/include/linux/netfilter_bridge/ebtables.h.s
> > In file included from <command-line>:32:0:
> > ./usr/include/linux/netfilter_bridge/ebtables.h:126:4: error: unknown type name ‘uint8_t’
> >     uint8_t revision;
> >     ^~~~~~~
> > ./usr/include/linux/netfilter_bridge/ebtables.h:139:4: error: unknown type name ‘uint8_t’
> >     uint8_t revision;
> >     ^~~~~~~
> > ./usr/include/linux/netfilter_bridge/ebtables.h:152:4: error: unknown type name ‘uint8_t’
> >     uint8_t revision;
> >     ^~~~~~~
> 
> Applied.

Patch does not apply cleanly to nf.git, I have to keep it back, sorry

$ git am /tmp/yamada.masahiro.txt -s
Applying: netfilter: use __u8 instead of uint8_t in uapi header
error: patch failed: usr/include/Makefile:37
error: usr/include/Makefile: patch does not apply
Patch failed at 0001 netfilter: use __u8 instead of uint8_t in uapi header
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
