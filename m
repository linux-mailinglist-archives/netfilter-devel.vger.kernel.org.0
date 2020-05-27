Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A181E5098
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2020 23:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgE0Vjn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 May 2020 17:39:43 -0400
Received: from correo.us.es ([193.147.175.20]:40426 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0Vjm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 May 2020 17:39:42 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 216CF9F4C5
        for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2020 23:39:40 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 12D16DA710
        for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2020 23:39:40 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 08224DA703; Wed, 27 May 2020 23:39:40 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 227D2DA703;
        Wed, 27 May 2020 23:39:38 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 27 May 2020 23:39:38 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 05D3B42EF4E0;
        Wed, 27 May 2020 23:39:37 +0200 (CEST)
Date:   Wed, 27 May 2020 23:39:37 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/3] Avoid gretap fragmentation with nftables on bridge
Message-ID: <20200527213937.GA2714@salvia>
References: <cover.1588758255.git.michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588758255.git.michael-dev@fami-braun.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 06, 2020 at 11:46:22AM +0200, Michael Braun wrote:
> Hi,
> 
> I have a bridge with connects an gretap tunnel with some ethernet lan.
> On the gretap device I use ignore-df to avoid packets being lost without
> icmp reject to the sender of the bridged packet.
> 
> Still I want to avoid packet fragmentation with the gretap packets.
> So I though about adding an nftables rule like this:
> 
> nft insert rule bridge filter FORWARD \
>   ip protocol tcp \
>   ip length > 1400 \
>   ip frag-off & 0x4000 != 0 \
>   reject with icmp type frag-needed
> 
> This would reject all tcp packets with ip dont-fragment bit set that are
> bigger than some threshold (here 1400 bytes). The sender would then receive
> ICMP unreachable - fragmentation needed and reduce its packet size (as
> defined with PMTU).

Patches 1 and 2 are applied, thanks.

Patch 3 has been merged upstream as a bugfix since VLAN should be
preversed in any reject case.
