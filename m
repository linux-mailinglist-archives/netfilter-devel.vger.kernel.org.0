Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD21C00B1
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2020 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD3Pqd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Apr 2020 11:46:33 -0400
Received: from correo.us.es ([193.147.175.20]:39736 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgD3Pqd (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:46:33 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 534D5F23A4
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 17:46:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 44FC2B7FFD
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Apr 2020 17:46:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3A991B7FFC; Thu, 30 Apr 2020 17:46:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id ED1F7B7FF5;
        Thu, 30 Apr 2020 17:46:29 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 30 Apr 2020 17:46:29 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D09D942EFB8D;
        Thu, 30 Apr 2020 17:46:29 +0200 (CEST)
Date:   Thu, 30 Apr 2020 17:46:29 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] rule: memleak in __do_add_setelems()
Message-ID: <20200430154629.GB3999@salvia>
References: <20200430121845.10388-1-pablo@netfilter.org>
 <20200430130820.GA11056@salvia>
 <20200430135217.GJ15009@orbyte.nwl.cc>
 <20200430144714.GA1454@salvia>
 <20200430154106.GO15009@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430154106.GO15009@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 30, 2020 at 05:41:06PM +0200, Phil Sutter wrote:
> [...]
> > I think I found the root cause:
> > 
> > https://marc.info/?l=netfilter-devel&m=158825784609307&w=2
> 
> Good catch!

I just pushed this out, thanks for reviewing.
