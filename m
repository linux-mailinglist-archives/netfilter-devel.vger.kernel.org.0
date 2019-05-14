Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654DB1C6DB
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 May 2019 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENKSH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 May 2019 06:18:07 -0400
Received: from mail.us.es ([193.147.175.20]:59152 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfENKSH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 May 2019 06:18:07 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CF3FA1B694F
        for <netfilter-devel@vger.kernel.org>; Tue, 14 May 2019 12:18:04 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BEBBCDA717
        for <netfilter-devel@vger.kernel.org>; Tue, 14 May 2019 12:18:04 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B4288DA711; Tue, 14 May 2019 12:18:04 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F26ADDA706;
        Tue, 14 May 2019 12:18:01 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 14 May 2019 12:18:00 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D1AFD4265A32;
        Tue, 14 May 2019 12:18:01 +0200 (CEST)
Date:   Tue, 14 May 2019 12:18:01 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     =?utf-8?B?6IKW55Ge54+g?= <katrina.xiaorz@gmail.com>
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>, davem@davemloft.net,
        alin.nastac@gmail.com, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3] netfilter: nf_conntrack_sip: fix expectation clash
Message-ID: <20190514101801.xregz4uqppy3lg7j@salvia>
References: <20190321105607.dwj3wtxe32cenglo@salvia>
 <1555317180-3074-1-git-send-email-katrina.xiaorz@gmail.com>
 <20190513112631.zmrcyss5bqr53yo4@salvia>
 <CAEorUYZe2mtLupMDkAOvMXZoH_NcUOKLR=K4atLC5dddHOs-MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEorUYZe2mtLupMDkAOvMXZoH_NcUOKLR=K4atLC5dddHOs-MQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Xiao,

On Tue, May 14, 2019 at 03:45:13PM +0800, 肖瑞珠 wrote:
> Hi Pablo,
> 
> Thanks very much for your reply.
> 
> >On Thu, May 13, 2019 at 07:26PM, Pablo Neira Ayuso <pablo@netfilter.org>
> >wrote:
> >
> >I wonder if we can handle this from __nf_ct_expect_check() itself.
> >
> >We could just check if master mismatches, then return -EALREADY from
> >there?
> >
> >Similar to 876c27314ce51, but catch the master mismatches case.
> 
> Thanks for your proposal. It is a neater solution.

OK, thanks for exploring this path and confirming this works!

Still one more question before we go: I wonder if we should enable
this through flag, eg. extend nf_ct_expect_related() to take a flag
that NFCT_EXP_F_MASTER_MISMATCH.

This would change the behaviour for the other existing helpers, which
would prevent them from creating expectations with the same tuple from
different master conntracks.

So I would just turn on this for SIP unless there is some reasoning
here that turning it for all existing helpers is fine.

One more comment below.

> Please find the patch updated accordingly below.

For some reason this patch is not showing in patchwork:

https://patchwork.ozlabs.org/project/netfilter-devel/list/

Would you resubmit via git send-mail?

Thanks.
