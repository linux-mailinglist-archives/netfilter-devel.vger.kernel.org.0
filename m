Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7F24DED8
	for <lists+netfilter-devel@lfdr.de>; Fri, 21 Aug 2020 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHURrB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 21 Aug 2020 13:47:01 -0400
Received: from correo.us.es ([193.147.175.20]:56350 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgHURrA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:47:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6B067DA725
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Aug 2020 19:46:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5D006DA789
        for <netfilter-devel@vger.kernel.org>; Fri, 21 Aug 2020 19:46:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 52B9EDA73D; Fri, 21 Aug 2020 19:46:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C9541DA704;
        Fri, 21 Aug 2020 19:46:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 21 Aug 2020 19:46:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AA75742EE393;
        Fri, 21 Aug 2020 19:46:56 +0200 (CEST)
Date:   Fri, 21 Aug 2020 19:46:56 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Andreas Fischer <netfilter@d9c.eu>
Subject: Re: [PATCH nf 0/2] nft_set_rbtree: Two fixes for overlap detection
 on insert
Message-ID: <20200821174656.GA1980@salvia>
References: <cover.1597873312.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597873312.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:59:13PM +0200, Stefano Brivio wrote:
> Patch 1/2 fixes false positive cases resulting from a flawed
> assumption highlighted by
> 	https://bugzilla.netfilter.org/show_bug.cgi?id=1449
> and is addressed for stable (5.6.x).
> 
> Patch 2/2 fixes a false negative case I noticed while skipping
> different interval overlap checks in nft.

Applied, thanks.
