Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602D3A71BB
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 19:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfICRdg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Sep 2019 13:33:36 -0400
Received: from correo.us.es ([193.147.175.20]:49468 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfICRdg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:33:36 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BF7AAD2F6C
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 19:33:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B21D5D2B1F
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 19:33:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A7E4B3569; Tue,  3 Sep 2019 19:33:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B3ACDD2B1F;
        Tue,  3 Sep 2019 19:33:30 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 03 Sep 2019 19:33:30 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9247C4265A5A;
        Tue,  3 Sep 2019 19:33:30 +0200 (CEST)
Date:   Tue, 3 Sep 2019 19:33:31 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 1/3] netfilter: nf_offload: Make
 nft_flow_offload_chain public
Message-ID: <20190903173331.jntwuxjpb2uwmbzs@salvia>
References: <1566207905-22203-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566207905-22203-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Could you explore fixing up this by registering a netdev handler from
nf_tables_offload.c?

Now we have a nft_offload_init() and _exit() functions, you could
register this from there.

I think notifier block priority should allow for running this before
__nft_release_basechain().
