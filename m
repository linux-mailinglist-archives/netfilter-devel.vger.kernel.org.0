Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6420B1A8D79
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2020 23:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391798AbgDNVQu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Apr 2020 17:16:50 -0400
Received: from correo.us.es ([193.147.175.20]:43720 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732367AbgDNVQs (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:16:48 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5D29CDA711
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2020 23:16:44 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4EC21DA8E6
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2020 23:16:44 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 41EAEDA7B2; Tue, 14 Apr 2020 23:16:44 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 57DA1DA736;
        Tue, 14 Apr 2020 23:16:42 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 14 Apr 2020 23:16:42 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 372F44301DE1;
        Tue, 14 Apr 2020 23:16:42 +0200 (CEST)
Date:   Tue, 14 Apr 2020 23:16:41 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 0/2] Prevent kernel from adding concatenated ranges
 if they're not supported
Message-ID: <20200414211641.nfn4ckoxxqvquqwq@salvia>
References: <cover.1586806931.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1586806931.git.sbrivio@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:48:01PM +0200, Stefano Brivio wrote:
> This series fixes the nft crash recently reported by Pablo with older
> (< 5.6) kernels: use the NFT_SET_CONCAT flag whenever we send a set
> including concatenated ranges, so that kernels not supporting them
> will not add them altogether, and we won't crash while trying to list
> the malformed sets that are added as a result.

Applied, thanks.
