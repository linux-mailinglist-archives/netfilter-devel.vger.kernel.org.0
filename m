Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240251E02A8
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2020 21:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbgEXT4y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 24 May 2020 15:56:54 -0400
Received: from correo.us.es ([193.147.175.20]:53250 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388029AbgEXT4x (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 24 May 2020 15:56:53 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C35D295314
        for <netfilter-devel@vger.kernel.org>; Sun, 24 May 2020 21:56:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B518EDA707
        for <netfilter-devel@vger.kernel.org>; Sun, 24 May 2020 21:56:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AA86EDA703; Sun, 24 May 2020 21:56:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 74CECDA703;
        Sun, 24 May 2020 21:56:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 24 May 2020 21:56:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5898442EF42A;
        Sun, 24 May 2020 21:56:50 +0200 (CEST)
Date:   Sun, 24 May 2020 21:56:50 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2 nf] netfilter: make conntrack userspace helpers work
 again
Message-ID: <20200524195650.GA28733@salvia>
References: <CAPZ+yNLdFUDCnuBG-LeS4aVvr14Pjp_mBbi+GFR9w49QVK_7Mg@mail.gmail.com>
 <20200515212712.16637-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515212712.16637-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 15, 2020 at 11:27:12PM +0200, Florian Westphal wrote:
> conntrackd has support for userspace-based connection tracking helpers,
> to move parsing of control packets to userspace.

I posted a patch that simplifies this logic by checking for:

        helper->flags & NF_CT_HELPER_F_USERSPACE

from the nf_conntrack_update path.

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20200524195410.28502-2-pablo@netfilter.org/

There was another issue that I have also fixed.

Thanks for posting your patch.
