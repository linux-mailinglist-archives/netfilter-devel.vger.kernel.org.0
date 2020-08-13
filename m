Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36624326C
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Aug 2020 04:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMCRn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Aug 2020 22:17:43 -0400
Received: from correo.us.es ([193.147.175.20]:33616 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHMCRm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Aug 2020 22:17:42 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EDC49DA3C6
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Aug 2020 04:17:41 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E0990DA789
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Aug 2020 04:17:41 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D650DDA72F; Thu, 13 Aug 2020 04:17:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D01B3DA722;
        Thu, 13 Aug 2020 04:17:39 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 13 Aug 2020 04:17:39 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (246.pool85-48-185.static.orange.es [85.48.185.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6576F42EE38E;
        Thu, 13 Aug 2020 04:17:39 +0200 (CEST)
Date:   Thu, 13 Aug 2020 04:17:36 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+c99868fde67014f7e9f5@syzkaller.appspotmail.com
Subject: Re: [PATCH nf] netfilter: free chain context when BINDING flag is
 missing
Message-ID: <20200813021736.GA3650@salvia>
References: <20200811173909.11246-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811173909.11246-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 11, 2020 at 07:39:09PM +0200, Florian Westphal wrote:
> syzbot found a memory leak in nf_tables_addchain() because the chain
> object is not free'd correctly on error.

Applied, thanks.
