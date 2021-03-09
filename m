Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708C4332604
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Mar 2021 14:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCINEF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Mar 2021 08:04:05 -0500
Received: from correo.us.es ([193.147.175.20]:51784 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhCINDo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:03:44 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E159B18CE7F
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 14:03:42 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CCB65DA844
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 14:03:42 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C150ADA7E4; Tue,  9 Mar 2021 14:03:42 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-105.9 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8A12ADA78C
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 14:03:40 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Mar 2021 14:03:40 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6D92342DC703
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 14:03:40 +0100 (CET)
Date:   Tue, 9 Mar 2021 14:03:40 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [HEADS UP] bugzilla.netfilter.org is under maintainance
Message-ID: <20210309130340.GA1624@salvia>
References: <20210308232606.GA24377@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308232606.GA24377@salvia>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 09, 2021 at 12:26:06AM +0100, Pablo Neira Ayuso wrote:
> Hi!
> 
> Short notice:
> 
> bugzilla.netfilter.org is currently down / under maintainance, we're
> expecting to bring it back soon.
> 
> I will keep you all posted with updates.

Netfilter's bugzilla is back to operation.

Thanks for your patience.
