Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3C441919A3
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Mar 2020 20:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgCXTBi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Mar 2020 15:01:38 -0400
Received: from correo.us.es ([193.147.175.20]:55206 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbgCXTBh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:01:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F37111E2C70
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Mar 2020 20:00:59 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E4778DA3C3
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Mar 2020 20:00:59 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DA15ADA840; Tue, 24 Mar 2020 20:00:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1E272DA3C2;
        Tue, 24 Mar 2020 20:00:58 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 24 Mar 2020 20:00:58 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0175842EF42B;
        Tue, 24 Mar 2020 20:00:57 +0100 (CET)
Date:   Tue, 24 Mar 2020 20:01:33 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf v2 0/4] nftables: Consistently report partial and
 entire set overlaps
Message-ID: <20200324190133.le2zxpbwhkpjd435@salvia>
References: <cover.1584841602.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584841602.git.sbrivio@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Mar 22, 2020 at 03:21:57AM +0100, Stefano Brivio wrote:
> Phil reports that inserting an element, that includes a concatenated
> range colliding with an existing one, fails silently.
> 
> This is because so far set back-ends have no way to tell apart cases
> of identical elements being inserted from clashing elements. On
> insertion, the front-end would strip -EEXIST if NLM_F_EXCL is not
> passed, so we return success to userspace while an error in fact
> occurred.
> 
> As suggested by Pablo, allow back-ends to return -ENOTEMPTY in case
> of partial overlaps, with patch 1/4. Then, with patches 2/4 to 4/4,
> update nft_set_pipapo and nft_set_rbtree to report partial overlaps
> using the new error code.

Applied, thanks.
