Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75F424325D
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Aug 2020 04:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMCJE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Aug 2020 22:09:04 -0400
Received: from correo.us.es ([193.147.175.20]:32862 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgHMCJE (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Aug 2020 22:09:04 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5BBC7DA3C3
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Aug 2020 04:09:03 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4BECCDA722
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Aug 2020 04:09:03 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 413BBDA704; Thu, 13 Aug 2020 04:09:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2A778DA722;
        Thu, 13 Aug 2020 04:09:01 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 13 Aug 2020 04:09:01 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (246.pool85-48-185.static.orange.es [85.48.185.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B5A3442EE38E;
        Thu, 13 Aug 2020 04:09:00 +0200 (CEST)
Date:   Thu, 13 Aug 2020 04:08:57 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] nft: Fix for ruleset flush while restoring
Message-ID: <20200813020857.GA3256@salvia>
References: <20200731163125.7309-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731163125.7309-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 31, 2020 at 06:31:25PM +0200, Phil Sutter wrote:
> If ruleset is flushed while an instance of iptables-nft-restore is
> running and has seen a COMMIT line once, it doesn't notice the
> disappeared table while handling the next COMMIT. This is due to table
> existence being tracked via 'initialized' boolean which is only reset
> by nft_table_flush().
> 
> To fix this, drop the dedicated 'initialized' boolean and switch users
> to the recently introduced 'exists' one.
> 
> As a side-effect, this causes base chain existence being checked for
> each command calling nft_xt_builtin_init() as the old 'initialized' bit
> was used to track if that function has been called before or not.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
