Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0892531214
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 May 2019 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEaQQ6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 May 2019 12:16:58 -0400
Received: from mail.us.es ([193.147.175.20]:44422 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfEaQQ5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 May 2019 12:16:57 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AFF3280767
        for <netfilter-devel@vger.kernel.org>; Fri, 31 May 2019 18:16:55 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A0993DA70E
        for <netfilter-devel@vger.kernel.org>; Fri, 31 May 2019 18:16:55 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 950E7DA70C; Fri, 31 May 2019 18:16:55 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A17A9DA709;
        Fri, 31 May 2019 18:16:53 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 31 May 2019 18:16:53 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 78A7E4265A31;
        Fri, 31 May 2019 18:16:53 +0200 (CEST)
Date:   Fri, 31 May 2019 18:16:53 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
Subject: Re: [nft PATCH v4 0/2] JSON schema for nftables.py
Message-ID: <20190531161653.dty3y2jl2jgm2iho@salvia>
References: <20190527113642.8434-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527113642.8434-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 27, 2019 at 01:36:40PM +0200, Phil Sutter wrote:
> Round four of JSON validation enhancement.

I'm going to place this in the nft.git tree, you can just follow up on
this with more incremental updates.

Thanks.
