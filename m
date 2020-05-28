Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1EF1E5218
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2020 02:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgE1AJt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 May 2020 20:09:49 -0400
Received: from correo.us.es ([193.147.175.20]:38940 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgE1AJt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 May 2020 20:09:49 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 51C6DBCAA9
        for <netfilter-devel@vger.kernel.org>; Thu, 28 May 2020 02:09:48 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4396FDA703
        for <netfilter-devel@vger.kernel.org>; Thu, 28 May 2020 02:09:48 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 39087DA709; Thu, 28 May 2020 02:09:48 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3462BDA703;
        Thu, 28 May 2020 02:09:46 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 28 May 2020 02:09:46 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1670042EF4E0;
        Thu, 28 May 2020 02:09:46 +0200 (CEST)
Date:   Thu, 28 May 2020 02:09:45 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2 0/2] Fix evaluation of anonymous sets with
 concatenated ranges
Message-ID: <20200528000945.GA11541@salvia>
References: <cover.1590612113.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1590612113.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 27, 2020 at 10:51:20PM +0200, Stefano Brivio wrote:
> As reported by both Pablo and Phil, trying to add an anonymous set
> containing a concatenated range would fail:
> 
>   # nft add rule x y ip saddr . tcp dport { 192.168.2.1 . 20-30 } accept
>   BUG: invalid range expression type concat
>   nft: expression.c:1160: range_expr_value_low: Assertion `0' failed.
>   Aborted
> 
>   # nft add rule t c ip daddr . tcp dport '{ 10.0.0.0/8 . 10-23, 192.168.1.1-192.168.3.8 . 80-443 } accept'
>   BUG: invalid range expression type concat
>   nft: expression.c:1296: range_expr_value_low: Assertion `0' failed.
> 
> Patch 1/2 fixes this, and 2/2 enables a test for it in inet/sets.t.

Series applied, thanks Stefano.
