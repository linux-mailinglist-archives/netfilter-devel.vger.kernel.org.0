Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D9D1C00AE
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2020 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgD3Pop (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Apr 2020 11:44:45 -0400
Received: from correo.us.es ([193.147.175.20]:38870 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgD3Poo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:44:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 26E83F23A9
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 17:44:43 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1819EDA7B2
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 17:44:43 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0D59FBAAB4; Thu, 30 Apr 2020 17:44:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0D3C2DA7B2;
        Thu, 30 Apr 2020 17:44:41 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 30 Apr 2020 17:44:41 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E298842EFB83;
        Thu, 30 Apr 2020 17:44:40 +0200 (CEST)
Date:   Thu, 30 Apr 2020 17:44:40 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 00/18] iptables: introduce cache evaluation
 phase
Message-ID: <20200430154440.GA3999@salvia>
References: <20200428121013.24507-1-phil@nwl.cc>
 <20200429213609.GA24368@salvia>
 <20200430135300.GK15009@orbyte.nwl.cc>
 <20200430150831.GA2267@salvia>
 <20200430152606.GM15009@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430152606.GM15009@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 30, 2020 at 05:26:07PM +0200, Phil Sutter wrote:
[...]
> > BTW, this cache consistency check
> > 
> > commit 200bc399651499f502ac0de45f4d4aa4c9d37ab6
> > Author: Phil Sutter <phil@nwl.cc>
> > Date:   Fri Mar 13 13:02:12 2020 +0100
> > 
> >     nft: cache: Fix iptables-save segfault under stress
> > 
> > is already restored in this series, right?
> 
> Yes, IIRC this was the reason why I got a merge conflict upon rebase.
> But the problem shouldn't exist with the new logic: We fetch cache just
> once, so there is no cache update (and potential cache free) happening
> while iterating through chain lists or anything.

Still another process might be competing to update the ruleset, right?
