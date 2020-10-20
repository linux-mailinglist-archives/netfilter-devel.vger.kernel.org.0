Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1995028F6FF
	for <lists+netfilter-devel@lfdr.de>; Thu, 15 Oct 2020 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbgJOQl3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 15 Oct 2020 12:41:29 -0400
Received: from correo.us.es ([193.147.175.20]:53516 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388946AbgJOQl3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:41:29 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0AA05E4B97
        for <netfilter-devel@vger.kernel.org>; Thu, 15 Oct 2020 18:41:28 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EBCDFDA78E
        for <netfilter-devel@vger.kernel.org>; Thu, 15 Oct 2020 18:41:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E1795DA704; Thu, 15 Oct 2020 18:41:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E5067DA78E;
        Thu, 15 Oct 2020 18:41:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 15 Oct 2020 18:41:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C498042EF4E2;
        Thu, 15 Oct 2020 18:41:25 +0200 (CEST)
Date:   Thu, 15 Oct 2020 18:41:25 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH nf-next] netfilter: nftables: allow re-computing sctp
 CRC-32C in 'payload' statements
Message-ID: <20201015164125.GA28806@salvia>
References: <20201015161651.4902-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015161651.4902-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 15, 2020 at 06:16:51PM +0200, Florian Westphal wrote:
> From: Davide Caratti <dcaratti@redhat.com>
> 
> nftables payload statements are used to mangle SCTP headers, but they can
> only replace the Internet Checksum. As a consequence, nftables rules that
> mangle sport/dport/vtag in SCTP headers potentially generate packets that
> are discarded by the receiver, unless the CRC-32C is "offloaded" (e.g the
> rule mangles a skb having 'ip_summed' equal to 'CHECKSUM_PARTIAL'.
> 
> Fix this extending uAPI definitions and L4 checksum update function, in a
> way that userspace programs (e.g. nft) can instruct the kernel to compute
> CRC-32C in SCTP headers. Also ensure that LIBCRC32C is built if NF_TABLES
> is 'y' or 'm' in the kernel build configuration.

I have just passed up this to net-next to help improve chances this
hits upstream in this merge window.

Thanks.
