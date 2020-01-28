Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1046014C0D5
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jan 2020 20:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA1TUl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jan 2020 14:20:41 -0500
Received: from correo.us.es ([193.147.175.20]:34670 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgA1TUk (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:20:40 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id AA0FC127C8D
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 20:20:39 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9BD01DA70F
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 20:20:39 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 91717DA707; Tue, 28 Jan 2020 20:20:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AAEAFDA712;
        Tue, 28 Jan 2020 20:20:37 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Jan 2020 20:20:37 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 8E5B842EF4E0;
        Tue, 28 Jan 2020 20:20:37 +0100 (CET)
Date:   Tue, 28 Jan 2020 20:20:36 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 9/9] tests: shell: add bit-shift tests.
Message-ID: <20200128192036.7os3dd4vwdvlr3qi@salvia>
References: <20200119225710.222976-1-jeremy@azazel.net>
 <20200119225710.222976-10-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119225710.222976-10-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jan 19, 2020 at 10:57:10PM +0000, Jeremy Sowden wrote:
> Add a couple of tests for setting the CT mark to a bitwise expression
> derived from the packet mark and vice versa.

Probably tests/py for this instead?

It also checks for the netlink bytecode, which is good to catch for
regressions in the future.

Thanks.
