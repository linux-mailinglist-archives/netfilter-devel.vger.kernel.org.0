Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D4281215
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Oct 2020 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBMQD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Oct 2020 08:16:03 -0400
Received: from correo.us.es ([193.147.175.20]:43312 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBMQD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:16:03 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7182ABA1A8
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Oct 2020 14:16:01 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 62DD1FC5E3
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Oct 2020 14:16:01 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 58946DA730; Fri,  2 Oct 2020 14:16:01 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4AD37DA72F;
        Fri,  2 Oct 2020 14:15:59 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 02 Oct 2020 14:15:59 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2933642EF536;
        Fri,  2 Oct 2020 14:15:59 +0200 (CEST)
Date:   Fri, 2 Oct 2020 14:15:58 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>,
        Arturo Borrero Gonzalez <arturo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] iptables-nft: fix basechain policy configuration
Message-ID: <20201002121558.GA1367@salvia>
References: <160163907669.18523.7311010971070291883.stgit@endurance>
 <20201002120732.GB29050@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201002120732.GB29050@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:07:32PM +0200, Phil Sutter wrote:
> Hi,
> 
> On Fri, Oct 02, 2020 at 01:44:36PM +0200, Arturo Borrero Gonzalez wrote:
> > Previous to this patch, the basechain policy could not be properly configured if it wasn't
> > explictly set when loading the ruleset, leading to iptables-nft-restore (and ip6tables-nft-restore)
> > trying to send an invalid ruleset to the kernel.
> 
> I fear this is not sufficient: iptables-legacy-restore leaves the
> previous chain policy in place if '-' is given in dump file. Please try
> this snippet from a testcase I wrote:
> 
> $XT_MULTI iptables -P FORWARD DROP
> 
> diff -u -Z <($XT_MULTI iptables-save | grep '^:FORWARD') \
>            <(echo ":FORWARD DROP [0:0]")
> 
> $XT_MULTI iptables-restore -c <<< "$TEST_RULESET"
> diff -u -Z <($XT_MULTI iptables-save | grep '^:FORWARD') \
>            <(echo ":FORWARD DROP [0:0]")

Hm, this is how it works in this patch right?

I mean, if '-' is given, chain policy attribute in the netlink message
is not set, and the kernel sets chain policy to
NFT_CHAIN_POLICY_UNSET.

Or am I missing anything?
