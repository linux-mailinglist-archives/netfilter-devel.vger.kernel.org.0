Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52D10A419
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Nov 2019 19:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfKZShS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Nov 2019 13:37:18 -0500
Received: from correo.us.es ([193.147.175.20]:34916 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZShS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:37:18 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F002E5E4781
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Nov 2019 19:37:13 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E05BDD190C
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Nov 2019 19:37:13 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D5CFEDA3A9; Tue, 26 Nov 2019 19:37:13 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 81838DA7B6;
        Tue, 26 Nov 2019 19:37:11 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 26 Nov 2019 19:37:11 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5C46642EE38E;
        Tue, 26 Nov 2019 19:37:11 +0100 (CET)
Date:   Tue, 26 Nov 2019 19:37:12 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/2] segtree: restore automerge
Message-ID: <20191126183712.wgyravjgmzlgy2ji@salvia>
References: <20191126103422.29501-1-pablo@netfilter.org>
 <20191126103422.29501-2-pablo@netfilter.org>
 <20191126120908.GC8016@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126120908.GC8016@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 26, 2019 at 01:09:08PM +0100, Phil Sutter wrote:
> Hi Pablo,
> 
> On Tue, Nov 26, 2019 at 11:34:22AM +0100, Pablo Neira Ayuso wrote:
> > Always close interval in non-anonymous sets unless the auto-merge
> > feature is set on.
> > 
> > Fixes: a4ec05381261 ("segtree: always close interval in non-anonymous sets")
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> > Hi Phil,
> > 
> > this patch also supersedes https://patchwork.ozlabs.org/patch/1198896/.
> 
> I fear this doesn't fix the problem at hand. With your two patches
> applied, tests/shell/testcases/sets/0039delete_interval_0 still fails
> for me. Your revert removes executable bit from that script, maybe
> that's why you didn't notice?

Indeed. Scratch this.
