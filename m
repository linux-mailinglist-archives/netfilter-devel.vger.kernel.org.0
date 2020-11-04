Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2722A64D2
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Nov 2020 14:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgKDNFh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Nov 2020 08:05:37 -0500
Received: from correo.us.es ([193.147.175.20]:56726 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbgKDNFh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:05:37 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F332CD9AD6C
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Nov 2020 14:05:35 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E5907DA73D
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Nov 2020 14:05:35 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DB001DA72F; Wed,  4 Nov 2020 14:05:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C08E5DA722;
        Wed,  4 Nov 2020 14:05:33 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 04 Nov 2020 14:05:33 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9CCA842EF9E0;
        Wed,  4 Nov 2020 14:05:33 +0100 (CET)
Date:   Wed, 4 Nov 2020 14:05:33 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 2/2] ebtables: Optimize masked MAC address
 matches
Message-ID: <20201104130533.GB7194@salvia>
References: <20201030132449.5576-1-phil@nwl.cc>
 <20201030132449.5576-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201030132449.5576-2-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 30, 2020 at 02:24:49PM +0100, Phil Sutter wrote:
> Just like with class-based prefix matches in iptables-nft, optimize
> masked MAC address matches if the mask is on a byte-boundary.
> 
> To reuse the logic in add_addr(), extend it to accept the payload base
> value via parameter.

This also looks fine, thanks.
