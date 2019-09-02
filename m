Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5569A5D61
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Sep 2019 23:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfIBVMU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 17:12:20 -0400
Received: from correo.us.es ([193.147.175.20]:47340 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfIBVMU (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 17:12:20 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C1B1B172C74
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Sep 2019 23:12:16 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B363D10219C
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Sep 2019 23:12:16 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A8B4E10079B; Mon,  2 Sep 2019 23:12:16 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        PDS_TONAME_EQ_TOLOCAL_SHORT,SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3F109CA0F3;
        Mon,  2 Sep 2019 23:12:14 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 02 Sep 2019 23:12:14 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1E1944265A5A;
        Mon,  2 Sep 2019 23:12:14 +0200 (CEST)
Date:   Mon, 2 Sep 2019 23:12:15 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu <wenxu@ucloud.cn>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2] netfilter: nf_table_offload: Fix the
 incorrect rcu usage in nft_indr_block_get_and_ing_cmd
Message-ID: <20190902211215.5wyw7esdtecmr3hn@salvia>
References: <1566220952-27225-1-git-send-email-wenxu@ucloud.cn>
 <f8951093-2874-847e-4a3c-0e4cc69b6f6f@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8951093-2874-847e-4a3c-0e4cc69b6f6f@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 02, 2019 at 02:14:54PM +0800, wenxu wrote:
> Hi pablo,
> 
> any other questions about this patch?

Please, rebase:

https://patchwork.ozlabs.org/patch/1156728/
https://patchwork.ozlabs.org/patch/1156729/
