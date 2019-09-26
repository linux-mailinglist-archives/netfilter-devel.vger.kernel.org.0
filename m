Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA2DBED87
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Sep 2019 10:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfIZIhe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Sep 2019 04:37:34 -0400
Received: from correo.us.es ([193.147.175.20]:44090 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfIZIhe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:37:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C462E1022AA
        for <netfilter-devel@vger.kernel.org>; Thu, 26 Sep 2019 10:37:29 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B4427D2B1E
        for <netfilter-devel@vger.kernel.org>; Thu, 26 Sep 2019 10:37:29 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B3400DA4D0; Thu, 26 Sep 2019 10:37:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 63AE7B8004;
        Thu, 26 Sep 2019 10:37:27 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 26 Sep 2019 10:37:27 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (barqueta.lsi.us.es [150.214.188.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 54B9342EE38F;
        Thu, 26 Sep 2019 10:37:27 +0200 (CEST)
Date:   Thu, 26 Sep 2019 10:37:29 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libmnl] src: fix doxygen function documentation
Message-ID: <20190926083729.qcxkz7anewywvdy7@salvia>
References: <20190925131418.7711-1-ffmancera@riseup.net>
 <20190926000558.GA27134@dimstar.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926000558.GA27134@dimstar.local.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:05:58AM +1000, Duncan Roe wrote:
> On Wed, Sep 25, 2019 at 03:14:19PM +0200, Fernando Fernandez Mancera wrote:
> > Currently clang requires EXPORT_SYMBOL() to be above the function
> > implementation. At the same time doxygen is not generating the proper
> > documentation because of that.
> >
> > This patch solves that problem but EXPORT_SYMBOL looks less like the Linux
> > kernel way exporting symbols.
> >
> > Reported-by: Duncan Roe <duncan_roe@optusnet.com.au>
> > Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> > ---
> >  src/attr.c     | 145 +++++++++++++++++++++----------------------------
> >  src/callback.c |  14 ++---
> >  src/internal.h |   3 +-
> >  src/nlmsg.c    |  68 +++++++++--------------
> >  src/socket.c   |  42 ++++++--------
> >  5 files changed, 113 insertions(+), 159 deletions(-)
> >
>
> Why do we need EXPORT_SYMBOL anyway?

For __attribute__((visibility("default"))).
