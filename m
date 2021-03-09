Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89075332304
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Mar 2021 11:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCIK17 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Mar 2021 05:27:59 -0500
Received: from correo.us.es ([193.147.175.20]:34284 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhCIK1p (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:27:45 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E1630F2583
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 11:27:43 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D1F7ADA704
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 11:27:43 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C752CDA793; Tue,  9 Mar 2021 11:27:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-105.9 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,USER_IN_WELCOMELIST,
        USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 739E6DA78A;
        Tue,  9 Mar 2021 11:27:41 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Mar 2021 11:27:41 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5311442DC6E2;
        Tue,  9 Mar 2021 11:27:41 +0100 (CET)
Date:   Tue, 9 Mar 2021 11:27:40 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Marc =?utf-8?Q?Aur=C3=A8le?= La France <tsi@tuyoix.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter REJECT: Fix destination MAC in RST packets
Message-ID: <20210309102740.GA30899@salvia>
References: <alpine.LNX.2.20.2103071736460.15162@fanir.tuyoix.net>
 <20210308102510.GA23497@salvia>
 <alpine.WNT.2.20.2103080908550.2772@CLUIJ>
 <20210309013621.GA27206@salvia>
 <alpine.WNT.2.20.2103082114130.1604@CLUIJ>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.WNT.2.20.2103082114130.1604@CLUIJ>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Mar 08, 2021 at 09:25:28PM -0700, Marc Aurèle La France wrote:
> On Tue, 9 Mar 2021, Pablo Neira Ayuso wrote:
> > On Mon, Mar 08, 2021 at 09:21:20AM -0700, Marc Aurèle La France wrote:
> > > On Mon, 8 Mar 2021, Pablo Neira Ayuso wrote:
> > > > On Sun, Mar 07, 2021 at 06:16:34PM -0700, Marc Aurèle La France wrote:
> 
> > > > > In the non-bridge case, the REJECT target code assumes the REJECTed
> > > > > packets were originally emitted by the local host, but that's not
> > > > > necessarily true when the local host is the default route of a subnet
> > > > > it is on, resulting in RST packets being sent out with an incorrect
> > > > > destination MAC.  Address this by refactoring the handling of bridged
> > > > > packets which deals with a similar issue.  Modulo patch fuzz, the
> > > > > following applies to v5 and later kernels.
> 
> > > > The code this patch updates is related to BRIDGE_NETFILTER. Your patch
> > > > description refers to the non-bridge case. What are you trying to
> > > > achieve?
> 
> > > Via DHCP, my subnet's default route is a Linux system so that it can monitor
> > > all outbound traffic.  By doing so, for example, I have determined that my
> > > Android phone connects to Facebook despite the fact that I have no such app
> > > installed.  I want to know, and control, what other behind-the-scenes
> > > (under-handed) traffic devices on my subnet generate.
> 
> > > > dev_queue_xmit() path should not be exercised from the prerouting
> > > > chain, packets generated from the IP later must follow the
> > > > ip_local_out() path.
> 
> > > Well, I can tell you dev_queue_xmit() does in fact work in prerouting
> > > chains, as it must for the bridging case.  The only potential problem I've
> > > found so far is that the RST packet doesn't go through any netfilter hooks.
> 
> > That's the issue, Netfilter rejects code from the IP layer, so the
> > packets follows the ip_local_out() path.
> 
> ... which sets an incorrect destination MAC.  Also, in this case, netfilter
> doesn't reject any such thing.  It doesn't even "see" the RST packet
> dev_queue_xmit() sends out.  That's OK as there is no further need to
> process such a packet.

dev_queue_xmit() skips the policy in the local out path for the
generated RST packet. If you want to plain reject using
dev_queue_xmit() then you have to use the ingress hook.

> At least, the device whose connection request is being denied
> doesn't hang anymore...

The neighbour cache selects the destination MAC from the destination
IP address of the RST packet.

Your patch also refers to non-bridge scenario (no br_netfilter in
place).

Could you describe what you're trying to achieve in plain layman terms?
