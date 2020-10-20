Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35DB2848DE
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Oct 2020 10:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFI5m (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Oct 2020 04:57:42 -0400
Received: from correo.us.es ([193.147.175.20]:54324 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFI5l (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:57:41 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DD23439626D
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Oct 2020 10:57:40 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C31BCDA911
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Oct 2020 10:57:40 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BC57ADA85E; Tue,  6 Oct 2020 10:57:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A070ADA4CB;
        Tue,  6 Oct 2020 10:56:21 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 06 Oct 2020 10:56:21 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 75B2142EF9E6;
        Tue,  6 Oct 2020 10:56:21 +0200 (CEST)
Date:   Tue, 6 Oct 2020 10:56:21 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] nft: Optimize class-based IP prefix matches
Message-ID: <20201006085621.GA16275@salvia>
References: <20201002090334.29788-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002090334.29788-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 02, 2020 at 11:03:34AM +0200, Phil Sutter wrote:
> Payload expression works on byte-boundaries, leverage this with suitable
> prefix lengths.

Interesing. But it kicks in the raw payload expression in nftables.

# nft list ruleset
table ip filter {
        chain INPUT {
                type filter hook input priority filter; policy accept;
                @nh,96,24 8323072 counter packets 0 bytes 0
        }

Would you send a patch for nftables too? There is already approximate
offset matching in the tree, it should not be too hard to amend.

Thanks.
