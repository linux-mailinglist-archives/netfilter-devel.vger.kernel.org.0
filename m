Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4B514B375
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jan 2020 12:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgA1LWt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jan 2020 06:22:49 -0500
Received: from correo.us.es ([193.147.175.20]:33274 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1LWt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:22:49 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A830EE2C67
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 12:22:47 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9A64EDA703
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2020 12:22:47 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8F970DA718; Tue, 28 Jan 2020 12:22:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 73A2ADA703;
        Tue, 28 Jan 2020 12:22:45 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Jan 2020 12:22:45 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 556BC4301DE1;
        Tue, 28 Jan 2020 12:22:45 +0100 (CET)
Date:   Tue, 28 Jan 2020 12:22:44 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nft PATCH 1/4] segtree: Drop needless insertion in ei_insert()
Message-ID: <20200128112244.q523d3yjo6qtfsgc@salvia>
References: <20200123143049.13888-1-phil@nwl.cc>
 <20200123143049.13888-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123143049.13888-2-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 23, 2020 at 03:30:46PM +0100, Phil Sutter wrote:
> Code checks whether for two new ranges one fully includes the other. If
> so, it would add the contained one only for segtree_linearize() to later
> omit the redundant items.
> 
> Instead just drop the contained item (which will always come last
> because caller orders the new elements in beforehand).
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

I would probably append this to the patch description.

* The auto-merge feature for sets merges what it has just been split
  by this code thereafter, so it turns this code into no-op.

* The auto-merge feature is not available for maps at this stage.
  This code allows to split intervals that have a different rhs mapping.
  This could be used in that case, but I find this feature confusing
  userwise.

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
