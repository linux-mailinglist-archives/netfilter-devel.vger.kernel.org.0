Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A170B57
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 23:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfGVV3b (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 17:29:31 -0400
Received: from mail.us.es ([193.147.175.20]:41868 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfGVV3b (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:29:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7117680D00
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jul 2019 23:29:30 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5ECC0D1911
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jul 2019 23:29:30 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 54583D2F98; Mon, 22 Jul 2019 23:29:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6688F1150CB;
        Mon, 22 Jul 2019 23:29:28 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 22 Jul 2019 23:29:28 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.183.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F40E34265A32;
        Mon, 22 Jul 2019 23:29:27 +0200 (CEST)
Date:   Mon, 22 Jul 2019 23:29:25 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Phil Sutter <phil@nwl.cc>
Subject: Re: [PATCH nft v2 0/2] netlink_ctx initialization fixes.
Message-ID: <20190722212925.nqf365f63pzrm3us@salvia>
References: <20190719103205.GM1628@orbyte.nwl.cc>
 <20190719111010.14421-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719111010.14421-1-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 19, 2019 at 12:10:08PM +0100, Jeremy Sowden wrote:
> A couple of patches to tidy up initialization of a pair of netlink_ctx
> variables.

Applied, thanks.
