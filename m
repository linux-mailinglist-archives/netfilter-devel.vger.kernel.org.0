Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF2B46AE
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Sep 2019 07:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbfIQFBB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Sep 2019 01:01:01 -0400
Received: from correo.us.es ([193.147.175.20]:54070 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730349AbfIQFBB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:01:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2C12BDA884
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Sep 2019 07:00:57 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1CBC1CE39C
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Sep 2019 07:00:57 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 12481D2B1F; Tue, 17 Sep 2019 07:00:57 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E87ECDA840;
        Tue, 17 Sep 2019 07:00:54 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 17 Sep 2019 07:00:54 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [46.31.102.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 79AB34265A5A;
        Tue, 17 Sep 2019 07:00:54 +0200 (CEST)
Date:   Tue, 17 Sep 2019 07:00:38 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 07/14] nft Increase mnl_talk() receive buffer
 size
Message-ID: <20190917050038.mi4omfwlctacjfze@salvia>
References: <20190916165000.18217-1-phil@nwl.cc>
 <20190916165000.18217-8-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916165000.18217-8-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 16, 2019 at 06:49:53PM +0200, Phil Sutter wrote:
> This improves cache population quite a bit and therefore helps when
> dealing with large rulesets. A simple hard to improve use-case is
> listing the last rule in a large chain.

You might consider extending the netlink interface too for this
particularly case, GETRULE plus position attribute could be used for
this I think. You won't be able to use this new operation from
userspace anytime soon though, given there is no way so far to expose
interface capabilities so far rather than probing.

If there are more particular corner cases like this, I would also
encourage to extend the netlink interface.

Just a side note, not a comment specifically on this patch :-).
