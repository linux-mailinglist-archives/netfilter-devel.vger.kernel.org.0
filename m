Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A053B321972
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Feb 2021 14:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhBVNxs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Feb 2021 08:53:48 -0500
Received: from correo.us.es ([193.147.175.20]:46368 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhBVNxl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:53:41 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0986BF2DE9
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Feb 2021 14:53:00 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EB161DA73F
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Feb 2021 14:52:59 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E0232DA78B; Mon, 22 Feb 2021 14:52:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-105.9 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,USER_IN_WELCOMELIST,
        USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B9589DA73D;
        Mon, 22 Feb 2021 14:52:57 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 22 Feb 2021 14:52:57 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9425D42DF560;
        Mon, 22 Feb 2021 14:52:57 +0100 (CET)
Date:   Mon, 22 Feb 2021 14:52:57 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <snemec@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>
Subject: Re: [nft PATCH 2/2] doc: nft: fix some typos and formatting issues
Message-ID: <20210222135257.GB28388@salvia>
References: <20210222120320.2252514-1-snemec@redhat.com>
 <20210222120320.2252514-2-snemec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222120320.2252514-2-snemec@redhat.com>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 22, 2021 at 01:03:20PM +0100, Štěpán Němec wrote:
> Trying to escape asciidoc (9.1.0) * with \ preserves the backslash in
> the formatted man page. Bare * works as expected.

Also applied, thanks.
