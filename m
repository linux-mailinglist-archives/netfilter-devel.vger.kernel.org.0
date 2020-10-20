Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BAD287B03
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Oct 2020 19:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgJHRcA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Oct 2020 13:32:00 -0400
Received: from correo.us.es ([193.147.175.20]:39150 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729179AbgJHRcA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:32:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1DE1718CDC3
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 19:31:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0E5AEDA791
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 19:31:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 03E72DA73F; Thu,  8 Oct 2020 19:31:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BBD95DA73F;
        Thu,  8 Oct 2020 19:31:56 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 08 Oct 2020 19:31:56 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 9F7D542EF4E0;
        Thu,  8 Oct 2020 19:31:56 +0200 (CEST)
Date:   Thu, 8 Oct 2020 19:31:56 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, phil@nwl.cc
Subject: Re: [iptables PATCH] iptables-nft: fix basechain policy configuration
Message-ID: <20201008173156.GA14654@salvia>
References: <160163907669.18523.7311010971070291883.stgit@endurance>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160163907669.18523.7311010971070291883.stgit@endurance>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:44:36PM +0200, Arturo Borrero Gonzalez wrote:
> From: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> Previous to this patch, the basechain policy could not be properly configured if it wasn't
> explictly set when loading the ruleset, leading to iptables-nft-restore (and ip6tables-nft-restore)
> trying to send an invalid ruleset to the kernel.

I have applied this with some amendments to the test file to cover
the --noflush case. I think this is a real problem there, where you
can combine to apply incremental updates to the ruleset.

For the --flush case, I still have doubts how to use this feature, not
sure it is worth the effort to actually fix it.

We can revisit later, you can rewrite this later Phil.
