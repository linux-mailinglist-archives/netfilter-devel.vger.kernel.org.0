Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5419EDC4
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 Apr 2020 21:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgDET6m (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 Apr 2020 15:58:42 -0400
Received: from correo.us.es ([193.147.175.20]:36412 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgDET6m (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:58:42 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D4B6681407
        for <netfilter-devel@vger.kernel.org>; Sun,  5 Apr 2020 21:58:40 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C5E23DA736
        for <netfilter-devel@vger.kernel.org>; Sun,  5 Apr 2020 21:58:40 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BB53D100A47; Sun,  5 Apr 2020 21:58:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7D909DA736;
        Sun,  5 Apr 2020 21:58:38 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 05 Apr 2020 21:58:38 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 60D3842EE38F;
        Sun,  5 Apr 2020 21:58:38 +0200 (CEST)
Date:   Sun, 5 Apr 2020 21:58:37 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf v2] nft_set_rbtree: Drop spurious condition for
 overlap detection on insertion
Message-ID: <20200405195837.cttlxpmmg2ggz2ez@salvia>
References: <26b78e559de6ae7250108163c19b48bdf0d12bfd.1585754003.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b78e559de6ae7250108163c19b48bdf0d12bfd.1585754003.git.sbrivio@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 01, 2020 at 05:14:38PM +0200, Stefano Brivio wrote:
> Case a1. for overlap detection in __nft_rbtree_insert() is not a valid
> one: start-after-start is not needed to detect any type of interval
> overlap and it actually results in a false positive if, while
> descending the tree, this is the only step we hit after starting from
> the root.

Applied, thanks.
