Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9487D0B37
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Oct 2019 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfJIJak (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Oct 2019 05:30:40 -0400
Received: from correo.us.es ([193.147.175.20]:57754 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfJIJak (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:30:40 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 153D7E44341
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Oct 2019 11:30:37 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 06744DA8E8
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Oct 2019 11:30:37 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 05B51DA801; Wed,  9 Oct 2019 11:30:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DF31ADA8E8;
        Wed,  9 Oct 2019 11:30:34 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 09 Oct 2019 11:30:34 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BD7FC41E4802;
        Wed,  9 Oct 2019 11:30:34 +0200 (CEST)
Date:   Wed, 9 Oct 2019 11:30:36 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v3 02/11] nft: Avoid nested cache fetching
Message-ID: <20191009093036.5f3juxrprarbz64w@salvia>
References: <20191008161447.6595-1-phil@nwl.cc>
 <20191008161447.6595-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008161447.6595-3-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 08, 2019 at 06:14:38PM +0200, Phil Sutter wrote:
> Don't call fetch_table_cache() from within fetch_chain_cache() but
> instead from __nft_build_cache(). Since that is the only caller of
> fetch_chain_cache(), this change should not have any effect in practice.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
