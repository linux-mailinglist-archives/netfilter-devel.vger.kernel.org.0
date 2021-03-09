Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D5B331C94
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Mar 2021 02:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCIBn4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Mar 2021 20:43:56 -0500
Received: from correo.us.es ([193.147.175.20]:35402 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230421AbhCIBnv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Mar 2021 20:43:51 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B01511C4383
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 02:43:50 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A0065DA704
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 02:43:50 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 95328DA78B; Tue,  9 Mar 2021 02:43:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-105.9 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,USER_IN_WELCOMELIST,
        USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 68F45DA704;
        Tue,  9 Mar 2021 02:43:48 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Mar 2021 02:43:48 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 41C8142DC700;
        Tue,  9 Mar 2021 02:43:48 +0100 (CET)
Date:   Tue, 9 Mar 2021 02:43:47 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/3] Minor documentation improvements
Message-ID: <20210309014347.GA27565@salvia>
References: <cover.1615108958.git.simon@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615108958.git.simon@ruderich.org>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Mar 07, 2021 at 10:51:33AM +0100, Simon Ruderich wrote:
> Hello,
> 
> while reading the nft man page I noticed a few minor things which
> should be improved by the following patches.

Applied, thanks.
