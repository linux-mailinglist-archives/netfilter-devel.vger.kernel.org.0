Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E885E28C
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGCLGb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Jul 2019 07:06:31 -0400
Received: from mail.us.es ([193.147.175.20]:47178 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfGCLGb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:06:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0680711F131
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 13:06:30 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EC2991021A4
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 13:06:29 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E1BB4DA708; Wed,  3 Jul 2019 13:06:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EC3A9DA704;
        Wed,  3 Jul 2019 13:06:27 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 03 Jul 2019 13:06:27 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id CA89E4265A2F;
        Wed,  3 Jul 2019 13:06:27 +0200 (CEST)
Date:   Wed, 3 Jul 2019 13:06:26 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] files: Move netdev-ingress.nft to /etc/nftables as
 well
Message-ID: <20190703110626.zycjfc4xffz5mfkv@salvia>
References: <20190624151238.4869-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624151238.4869-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:38PM +0200, Phil Sutter wrote:
> Commit 13535a3b40b62 ("files: restore base table skeletons") moved
> config skeletons back from examples/ to /etc/nftables/ directory, but
> ignored the fact that commit 6c9230e79339c ("nftables: rearrange files
> and examples") added a new file 'netdev-ingress.nft' which is referenced
> from 'all-in-one.nft' as well.

Applied, thanks.
