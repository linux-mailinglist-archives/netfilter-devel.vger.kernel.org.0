Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE21A10D233
	for <lists+netfilter-devel@lfdr.de>; Fri, 29 Nov 2019 09:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfK2IEh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 29 Nov 2019 03:04:37 -0500
Received: from correo.us.es ([193.147.175.20]:36746 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfK2IEh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:04:37 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2906327F8D1
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Nov 2019 09:04:33 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 17A4FDA71A
        for <netfilter-devel@vger.kernel.org>; Fri, 29 Nov 2019 09:04:33 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0C2E4DA70D; Fri, 29 Nov 2019 09:04:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0C517DA70E;
        Fri, 29 Nov 2019 09:04:31 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 29 Nov 2019 09:04:31 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D0C0041E4802;
        Fri, 29 Nov 2019 09:04:30 +0100 (CET)
Date:   Fri, 29 Nov 2019 09:04:32 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] netfilter: nf_flow_table_offload: Don't use offset
 uninitialized in flow_offload_port_{d,s}nat
Message-ID: <20191129080432.jnsghajoenturr7v@salvia>
References: <20191126201226.51857-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126201226.51857-1-natechancellor@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 26, 2019 at 01:12:26PM -0700, Nathan Chancellor wrote:
> Clang warns (trimmed the second warning for brevity):
> 
> ../net/netfilter/nf_flow_table_offload.c:342:2: warning: variable
> 'offset' is used uninitialized whenever switch default is taken
> [-Wsometimes-uninitialized]
>         default:
>         ^~~~~~~
> ../net/netfilter/nf_flow_table_offload.c:346:57: note: uninitialized use
> occurs here
>         flow_offload_mangle(entry, flow_offload_l4proto(flow), offset,
>                                                                ^~~~~~
> ../net/netfilter/nf_flow_table_offload.c:331:12: note: initialize the
> variable 'offset' to silence this warning
>         u32 offset;
>                   ^
>                    = 0
> 
> Match what was done in the flow_offload_ipv{4,6}_{d,s}nat functions and
> just return in the default case, since port would also be uninitialized.

Applied, thanks.
