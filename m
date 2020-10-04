Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1646D282CE6
	for <lists+netfilter-devel@lfdr.de>; Sun,  4 Oct 2020 21:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgJDTKH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 4 Oct 2020 15:10:07 -0400
Received: from correo.us.es ([193.147.175.20]:55238 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgJDTKH (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:10:07 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3972DE8623
        for <netfilter-devel@vger.kernel.org>; Sun,  4 Oct 2020 21:10:06 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2B6B2DA72F
        for <netfilter-devel@vger.kernel.org>; Sun,  4 Oct 2020 21:10:06 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 20F7ADA722; Sun,  4 Oct 2020 21:10:06 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 14830DA72F;
        Sun,  4 Oct 2020 21:10:04 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 04 Oct 2020 21:10:04 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id EBBE642EF9E0;
        Sun,  4 Oct 2020 21:10:03 +0200 (CEST)
Date:   Sun, 4 Oct 2020 21:10:03 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2 v2] net: netfilter: Enable fast nft_cmp for
 inverted matches
Message-ID: <20201004191003.GA3823@salvia>
References: <20201001165744.25466-2-phil@nwl.cc>
 <20201002135056.17328-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002135056.17328-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:50:56PM +0200, Phil Sutter wrote:
> Add a boolean indicating NFT_CMP_NEQ. To include it into the match
> decision, it is sufficient to XOR it with the data comparison's result.
> 
> While being at it, store the mask that is calculated during expression
> init and free the eval routine from having to recalculate it each time.

Applied, thanks
