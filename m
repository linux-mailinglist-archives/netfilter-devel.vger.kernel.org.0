Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556411F4918
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2020 23:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgFIVtA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Jun 2020 17:49:00 -0400
Received: from correo.us.es ([193.147.175.20]:51664 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgFIVtA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:49:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7DBBB1A7AAA
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2020 23:48:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 71028DA72F
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2020 23:48:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 66705DA844; Tue,  9 Jun 2020 23:48:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 56690DA840;
        Tue,  9 Jun 2020 23:48:57 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Jun 2020 23:48:57 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3A7D4426CCB9;
        Tue,  9 Jun 2020 23:48:57 +0200 (CEST)
Date:   Tue, 9 Jun 2020 23:48:56 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, Florian Westphal <fw@strlen.de>,
        stable@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] nft_set_pipapo: Disable preemption before getting
 per-CPU pointer
Message-ID: <20200609214856.GA28534@salvia>
References: <45861d795de2db1494b40bb2cc13bb36b4dacf72.1591606165.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45861d795de2db1494b40bb2cc13bb36b4dacf72.1591606165.git.sbrivio@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 08, 2020 at 10:50:29AM +0200, Stefano Brivio wrote:
[...]
> Disable preemption before accessing the lookup scratch area in
> nft_pipapo_insert().

Applied, thanks.
