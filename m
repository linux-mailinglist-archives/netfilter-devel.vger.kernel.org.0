Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F212354D6
	for <lists+netfilter-devel@lfdr.de>; Sun,  2 Aug 2020 03:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHBBt1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 1 Aug 2020 21:49:27 -0400
Received: from correo.us.es ([193.147.175.20]:40592 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgHBBt1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 1 Aug 2020 21:49:27 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 18D93DA7B0
        for <netfilter-devel@vger.kernel.org>; Sun,  2 Aug 2020 03:49:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0A471DA78C
        for <netfilter-devel@vger.kernel.org>; Sun,  2 Aug 2020 03:49:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F12A6DA78A; Sun,  2 Aug 2020 03:49:25 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0064ADA72F;
        Sun,  2 Aug 2020 03:49:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 02 Aug 2020 03:49:23 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id CDA674265A2F;
        Sun,  2 Aug 2020 03:49:23 +0200 (CEST)
Date:   Sun, 2 Aug 2020 03:49:23 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        "Demi M . Obenour" <demiobenour@gmail.com>
Subject: Re: [PATCH nf] netfilter: nft_meta: fix iifgroup matching
Message-ID: <20200802014923.GA22080@salvia>
References: <20200802012703.15135-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802012703.15135-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Aug 02, 2020 at 03:27:03AM +0200, Florian Westphal wrote:
> iifgroup matching errounously checks the output interface.

Applied, thanks.
