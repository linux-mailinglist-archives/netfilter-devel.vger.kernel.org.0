Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1370D5D9FD
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 02:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfGCA6o (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Jul 2019 20:58:44 -0400
Received: from mail.us.es ([193.147.175.20]:46452 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfGCA6o (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:58:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4A3E780780
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 01:38:43 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 39F12DA4D0
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jul 2019 01:38:43 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2FA46DA801; Wed,  3 Jul 2019 01:38:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 673F4DA708;
        Wed,  3 Jul 2019 01:38:40 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 03 Jul 2019 01:38:40 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 46CD84265A31;
        Wed,  3 Jul 2019 01:38:40 +0200 (CEST)
Date:   Wed, 3 Jul 2019 01:38:39 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Fernando Fernandez Mancera <ffmancera@riseup.net>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v6] netfilter: nf_tables: Add SYNPROXY support
Message-ID: <20190702233839.fwbrhqsuay7if4bo@salvia>
References: <20190626105918.1142-1-ffmancera@riseup.net>
 <20190626111216.6va4t6nfkjkvof4a@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626111216.6va4t6nfkjkvof4a@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 26, 2019 at 01:12:16PM +0200, Florian Westphal wrote:
> Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
> > Add SYNPROXY module support in nf_tables. It preserves the behaviour of the
> > SYNPROXY target of iptables but structured in a different way to propose
> > improvements in the future.
> 
> Looks good, thanks Fernando!
> 
> Just one note, this will cause conflicts with
> https://patchwork.ozlabs.org/patch/1121798/
> 
> Normally this would need to wait until the fix has propagated to
> nf-next.
> 
> Pablo, any suggestion on how to proceed?
> I guess Fernando should resend a rebased v7 once the fix is in nf-next?

I'm inclined to adapt Ibrahim's patch to nf-next, then make a backport
for -stable and ask Greg to take it.

Unless Ibrahim patch lands in the mailing list soon.
