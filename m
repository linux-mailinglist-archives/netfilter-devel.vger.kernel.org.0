Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518A231D2FD
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Feb 2021 00:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBPXRg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 Feb 2021 18:17:36 -0500
Received: from correo.us.es ([193.147.175.20]:45488 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhBPXRg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 Feb 2021 18:17:36 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 50A8911772A
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Feb 2021 00:16:53 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3D570DA840
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Feb 2021 00:16:53 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7D5B6DA704; Wed, 17 Feb 2021 00:16:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-105.9 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2511BDA722;
        Wed, 17 Feb 2021 00:16:50 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 17 Feb 2021 00:16:50 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F38AF42DC6E3;
        Wed, 17 Feb 2021 00:16:49 +0100 (CET)
Date:   Wed, 17 Feb 2021 00:16:49 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] include: Drop libipulog.h
Message-ID: <20210216231649.GA13735@salvia>
References: <20210216222453.2519-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210216222453.2519-1-phil@nwl.cc>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Feb 16, 2021 at 11:24:53PM +0100, Phil Sutter wrote:
> The file is not included anywhere, also it seems outdated compared to
> the one in libnetfilter_log (which also holds the implementation).
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks
