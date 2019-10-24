Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523A1E24A8
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Oct 2019 22:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405432AbfJWUge (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Oct 2019 16:36:34 -0400
Received: from correo.us.es ([193.147.175.20]:40276 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405399AbfJWUge (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:36:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E52A5E8624
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Oct 2019 22:36:29 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D6C53A7E1A
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Oct 2019 22:36:29 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id CC348A7E11; Wed, 23 Oct 2019 22:36:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C1D82A7E9A;
        Wed, 23 Oct 2019 22:36:27 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 23 Oct 2019 22:36:27 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 95CD341E480B;
        Wed, 23 Oct 2019 22:36:27 +0200 (CEST)
Date:   Wed, 23 Oct 2019 22:36:29 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft 1/4] doc: add missing output flag documentation.
Message-ID: <20191023203629.bw2lkfqvw5f24az4@salvia>
References: <20191022205855.22507-1-jeremy@azazel.net>
 <20191022205855.22507-2-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022205855.22507-2-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:58:52PM +0100, Jeremy Sowden wrote:
> The documentation for NFT_CTX_OUTPUT_FLAG_NUMERIC_TIME and
> NFT_CTX_OUTPUT_FLAG_NUMERIC_ALL is incomplete.  Add the missing bits.

Applied, thanks.
