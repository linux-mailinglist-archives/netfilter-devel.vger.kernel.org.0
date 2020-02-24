Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9293516AF88
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Feb 2020 19:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgBXSoM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Feb 2020 13:44:12 -0500
Received: from correo.us.es ([193.147.175.20]:46224 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgBXSoM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:44:12 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DF38EE8D68
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Feb 2020 19:44:04 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D0F72DA3C4
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Feb 2020 19:44:04 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C669ADA3C2; Mon, 24 Feb 2020 19:44:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D0537DA72F;
        Mon, 24 Feb 2020 19:44:02 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 24 Feb 2020 19:44:02 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B2DDD424EECB;
        Mon, 24 Feb 2020 19:44:02 +0100 (CET)
Date:   Mon, 24 Feb 2020 19:44:08 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, nevola@gmail.com
Subject: Re: [PATCH nft 0/6] allow s/dnat to map to both addr and port
Message-ID: <20200224184408.baejyxhujwg4rnrt@salvia>
References: <20200224000324.9333-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224000324.9333-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:03:18AM +0100, Florian Westphal wrote:
> Right now its not possible to use a map with snat/dnat to alter both
> address and port at the same time.
> 
> This series teaches nft to accept this:
> 
> 	map y4 {
> 		type ipv4_addr : ipv4_addr . inet_service
> 		elements = { 192.168.7.2 : 10.1.1.1 . 4242 }
> 	}
>  	meta l4proto tcp meta nfproto ipv4 dnat ip to ip saddr map @y4
> 
> i.e., it allows:
> 1. A mapping that contains a concatenated expression.
> 2. nat expression will peek into set type and detect when
>    the mapping is of 'addr + port' type.
>    Linearization will compute the register that contains the port
>    part of the mapping.
> 3. Delinarization will figure out when this trick was used by looking
>    at the length of the mapping: 64 == ipv4addr+service, 160 == ipv6addr+service.
> 
> What does not work:
> Anonymous mappings, i.e.
> meta l4proto tcp meta nfproto ipv4 dnat ip to ip saddr map { 1.2.3.4 : 1.2.3.5 . 53, ..
>
> doesn't work.  When evaluating "1.2.3.4", this is still a symbol and
> unlike with named sets, nft doesn't have a properly declared set type.

This is now working, test has been adjusted and it is passing.

> This is similar to the 'maps-on-LHS-side' issue.
> Phil suggested to allow this:
>  ...  to ip saddr map { type ipv4_addr : ipv4_addr . inet_service; 1.2.3.4 : 1.2.3.5 . 53, ..
> 
> i.e. re-use the declarative syntax from map code.
> 
> Another related issue:
> "typeof" doesn't work with concatenations so far.

typeof support is still lacking.
