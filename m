Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470042842D7
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Oct 2020 01:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgJEXIV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Oct 2020 19:08:21 -0400
Received: from correo.us.es ([193.147.175.20]:52768 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgJEXIV (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Oct 2020 19:08:21 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 775BAD28C4
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Oct 2020 01:08:19 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6A6F1DA722
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Oct 2020 01:08:19 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6017FDA72F; Tue,  6 Oct 2020 01:08:19 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 40D21DA722;
        Tue,  6 Oct 2020 01:08:17 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 06 Oct 2020 01:08:17 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2223D42EF42A;
        Tue,  6 Oct 2020 01:08:17 +0200 (CEST)
Date:   Tue, 6 Oct 2020 01:08:16 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org,
        Serhey Popovych <serhe.popovych@gmail.com>
Subject: Re: [iptables PATCH 2/3] libxtables: Simplify pending extension
 registration
Message-ID: <20201005230816.GA13745@salvia>
References: <20200922225341.8976-1-phil@nwl.cc>
 <20200922225341.8976-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922225341.8976-3-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:53:40AM +0200, Phil Sutter wrote:
> Assuming that pending extensions are sorted by first name and family,
> then descending revision, the decision where to insert a newly
> registered extension may be simplified by memorizing the previous
> registration (which obviously is of same name and family and higher
> revision).
> 
> As a side-effect, fix for unsupported old extension revisions lingering
> in pending extension list forever and being retried with every use of
> the given extension. Any revision being rejected by the kernel may
> safely be dropped iff a previous (read: higher) revision was accepted
> already.
> 
> Yet another side-effect of this change is the removal of an unwanted
> recursion by xtables_fully_register_pending_*() into itself via
> xtables_find_*().

LGTM.
