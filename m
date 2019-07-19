Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55786E8DC
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jul 2019 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfGSQf2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jul 2019 12:35:28 -0400
Received: from mail.us.es ([193.147.175.20]:46704 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfGSQf2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:35:28 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B42D0DA738
        for <netfilter-devel@vger.kernel.org>; Fri, 19 Jul 2019 18:35:25 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A45E358F
        for <netfilter-devel@vger.kernel.org>; Fri, 19 Jul 2019 18:35:25 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9A09FDA708; Fri, 19 Jul 2019 18:35:25 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A86F8DA732;
        Fri, 19 Jul 2019 18:35:23 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 19 Jul 2019 18:35:23 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [47.60.47.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 741A84265A32;
        Fri, 19 Jul 2019 18:35:23 +0200 (CEST)
Date:   Fri, 19 Jul 2019 18:35:21 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Florian Westphal <fwestpha@redhat.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH v2 1/2] net: nf_tables: Make nft_meta expression more
 robust
Message-ID: <20190719163521.oozthobj33ejswrx@salvia>
References: <20190719123921.1249-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719123921.1249-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 19, 2019 at 02:39:20PM +0200, Phil Sutter wrote:
> nft_meta_get_eval()'s tendency to bail out setting NFT_BREAK verdict in
> situations where required data is missing breaks inverted checks
> like e.g.:
> 
> | meta iifname != eth0 accept
> 
> This rule will never match if there is no input interface (or it is not
> known) which is not intuitive and, what's worse, breaks consistency of
> iptables-nft with iptables-legacy.
> 
> Fix this by falling back to placing a value in dreg which never matches
> (avoiding accidental matches):
> 
> {I,O}IF:
> 	Use invalid ifindex value zero.
> 
> {BRI_,}{I,O}IFNAME, {I,O}IFKIND:
> 	Use an empty string which is neither a valid interface name nor
> 	kind.
> 
> {I,O}IFTYPE:
> 	Use ARPHRD_VOID (0xFFFF).

What could it be done with?

NFT_META_BRI_IIFPVID
NFT_META_BRI_IIFPVPROTO

Those will still not work for

        meta ibrpvid != 40

if interface is not available.

For VPROTO probably it's possible. I don't have a solution for
IIFPVID.
