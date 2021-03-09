Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7B733228F
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Mar 2021 11:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCIKGN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Mar 2021 05:06:13 -0500
Received: from correo.us.es ([193.147.175.20]:45242 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhCIKFv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:05:51 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 64FC75E4771
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 11:05:46 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 51F7DDA78E
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Mar 2021 11:05:46 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 46BD8DA78D; Tue,  9 Mar 2021 11:05:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-105.9 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        FORGED_MUA_MOZILLA,NICE_REPLY_A,SMTPAUTH_US2,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C6E2EDA704;
        Tue,  9 Mar 2021 11:05:43 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 09 Mar 2021 11:05:43 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A8BF942DC6E3;
        Tue,  9 Mar 2021 11:05:43 +0100 (CET)
Date:   Tue, 9 Mar 2021 11:05:43 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH conntrack-tools] conntrackd: set default hashtable
 buckets and max entries if not specified
Message-ID: <20210309100543.GA30640@salvia>
References: <20210308153254.15678-1-pablo@netfilter.org>
 <c85d5bbc-0f47-1f78-7eb5-8468bf56e78f@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c85d5bbc-0f47-1f78-7eb5-8468bf56e78f@netfilter.org>
User-Agent: Mozilla/5.0
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:51:20AM +0100, Arturo Borrero Gonzalez wrote:
> On 3/8/21 4:32 PM, Pablo Neira Ayuso wrote:
> > Fall back to 65536 buckets and 262144 entries.
> > 
> > It would be probably good to add code to autoadjust by reading
> > /proc/sys/net/netfilter/nf_conntrack_buckets and
> > /proc/sys/net/nf_conntrack_max.
> > 
> > Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1491
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> >   src/read_config_yy.y | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> 
> Thanks for the patch!
> 
> Would it make sense to have all this logic in evaluate() in src/run.c?

I think so. A patch to move it there would be fine.

I suspect there might more missing sanity checks in the configuration
file parser (options that are not set to default value, like hashsize
and hashlimit).
