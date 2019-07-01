Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1271F739
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 May 2019 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfEOPNh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 May 2019 11:13:37 -0400
Received: from mail.us.es ([193.147.175.20]:55572 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfEOPNh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 May 2019 11:13:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 99ACBFB6C0
        for <netfilter-devel@vger.kernel.org>; Wed, 15 May 2019 17:13:36 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 89E80DA705
        for <netfilter-devel@vger.kernel.org>; Wed, 15 May 2019 17:13:36 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7F869DA702; Wed, 15 May 2019 17:13:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 88E51DA70B;
        Wed, 15 May 2019 17:13:34 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 15 May 2019 17:13:34 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 679054265A31;
        Wed, 15 May 2019 17:13:34 +0200 (CEST)
Date:   Wed, 15 May 2019 17:13:34 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] tests: Fix ipt-restore/0004-restore-race_0
 testcase
Message-ID: <20190515151333.bb6ihkeroc47qpzq@salvia>
References: <20190514114600.19383-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514114600.19383-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 14, 2019 at 01:46:00PM +0200, Phil Sutter wrote:
> Two issues fixed:
> 
> * XTABLES_LIBDIR was set wrong (CWD is not topdir but tests/). Drop the
>   export altogether, the testscript does this already.
> 
> * $LINES is a variable set by bash, so initial dump sanity check failed
>   all the time complaining about a spurious initial dump line count. Use
>   $LINES1 instead.

Applied, thanks.
