Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6972F115E0F
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Dec 2019 19:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLGSwM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 Dec 2019 13:52:12 -0500
Received: from correo.us.es ([193.147.175.20]:50670 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfLGSwM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:52:12 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 383C8508CD7
        for <netfilter-devel@vger.kernel.org>; Sat,  7 Dec 2019 19:52:09 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2A0CDDA705
        for <netfilter-devel@vger.kernel.org>; Sat,  7 Dec 2019 19:52:09 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1F9AADA703; Sat,  7 Dec 2019 19:52:09 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 30379DA701;
        Sat,  7 Dec 2019 19:52:07 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 07 Dec 2019 19:52:07 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 02AD34265A5A;
        Sat,  7 Dec 2019 19:52:06 +0100 (CET)
Date:   Sat, 7 Dec 2019 19:52:07 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] selftests: netfilter: use randomized netns names
Message-ID: <20191207185207.zdjpgbgu4bzhsbnx@salvia>
References: <20191202173540.12230-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202173540.12230-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Dec 02, 2019 at 06:35:40PM +0100, Florian Westphal wrote:
> Using ns0, ns1, etc. isn't a good idea, they might exist already.
> Use a random suffix.
> 
> Also, older nft versions don't support "-" as alias for stdin, so
> use /dev/stdin instead.

Applied, thanks Florian.
