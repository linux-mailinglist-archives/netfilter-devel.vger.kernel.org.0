Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9587B14C0A6
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jan 2020 20:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgA1TJt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jan 2020 14:09:49 -0500
Received: from correo.us.es ([193.147.175.20]:59674 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgA1TJt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:09:49 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6D5F5127C7B
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 20:09:48 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5F87ADA713
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 20:09:48 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5535CDA712; Tue, 28 Jan 2020 20:09:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6A743DA705;
        Tue, 28 Jan 2020 20:09:46 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Jan 2020 20:09:46 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4C61542EF4E0;
        Tue, 28 Jan 2020 20:09:46 +0100 (CET)
Date:   Tue, 28 Jan 2020 20:09:45 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft v3 0/9] bitwise shift support
Message-ID: <20200128190945.foy5so5ibqecfrqs@salvia>
References: <20200119225710.222976-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119225710.222976-1-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jan 19, 2020 at 10:57:01PM +0000, Jeremy Sowden wrote:
> The kernel supports bitwise shift operations.  This patch-set adds the
> support to nft.  There are a few preliminary housekeeping patches.

Actually, this batch goes in the direction of adding the basic
lshift/right support.

# nft --debug=netlink add rule x y tcp dport set tcp dport lshift 1
ip x y 
  [ meta load l4proto => reg 1 ]
  [ cmp eq reg 1 0x00000006 ]
  [ payload load 2b @ transport header + 2 => reg 1 ]
  [ byteorder reg 1 = ntoh(reg 1, 2, 2) ]
  [ bitwise reg 1 = ( reg 1 << 0x00000001 ) ]
  [ payload write reg 1 => 2b @ transport header + 2 csum_type 1 csum_off 16 csum_flags 0x0 ]

I'm applying patches 1, 2, 3, 4, 7 and 8.

Regarding patch 5, it would be good to restore the parens when
listing.

Patch 6, I guess it will break something else. Did you run tests/py to
check this?

Patch 9, I'm skipping until 5 and 6 are sorted out.

Thanks.
