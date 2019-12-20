Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7620F1272B1
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Dec 2019 02:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLTBL6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Dec 2019 20:11:58 -0500
Received: from correo.us.es ([193.147.175.20]:48188 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfLTBL5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:11:57 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 493E2F25A0
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Dec 2019 02:11:55 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3BE09DA702
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Dec 2019 02:11:55 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3186DDA701; Fri, 20 Dec 2019 02:11:55 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2AE2DDA702;
        Fri, 20 Dec 2019 02:11:53 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Dec 2019 02:11:53 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 048ED4265A5A;
        Fri, 20 Dec 2019 02:11:52 +0100 (CET)
Date:   Fri, 20 Dec 2019 02:11:53 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org,
        =?iso-8859-1?Q?M=E1t=E9?= Eckl <ecklm94@gmail.com>
Subject: Re: [nf PATCH] netfilter: nft_tproxy: Fix port selector on Big Endian
Message-ID: <20191220011153.h74t7svtrn5fnav2@salvia>
References: <20191217235929.32555-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217235929.32555-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:59:29AM +0100, Phil Sutter wrote:
> On Big Endian architectures, u16 port value was extracted from the wrong
> parts of u32 sreg_port, just like commit 10596608c4d62 ("netfilter:
> nf_tables: fix mismatch in big-endian system") describes.

Applied, thanks.
