Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBE1B0297
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Sep 2019 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfIKRWg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Sep 2019 13:22:36 -0400
Received: from correo.us.es ([193.147.175.20]:34050 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbfIKRWg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:22:36 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2E40418FCE0
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Sep 2019 19:22:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 201D22DC7B
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Sep 2019 19:22:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 15B4ADA8E8; Wed, 11 Sep 2019 19:22:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 19F55B7FF2;
        Wed, 11 Sep 2019 19:22:30 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 11 Sep 2019 19:22:30 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [47.60.32.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B5F7042EF42A;
        Wed, 11 Sep 2019 19:22:29 +0200 (CEST)
Date:   Wed, 11 Sep 2019 19:22:29 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Arturo Borrero Gonzalez <arturo@netfilter.org>
Subject: Re: [PATCH ebtables-nft] ebtables: fix over-eager -o checks on
 custom chains
Message-ID: <20190911172229.hcuj4gix2yskzmdm@salvia>
References: <20190910211059.9872-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910211059.9872-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 10, 2019 at 11:10:59PM +0200, Florian Westphal wrote:
> Arturo reports ebtables-nft reports an error when -o is
> used in custom chains:
> 
> -A MYCHAIN -o someif
> makes ebtables-nft exit with an error:
> "Use -o only in OUTPUT, FORWARD and POSTROUTING chains."
> 
> Problem is that all the "-o" checks expect <= NF_BR_POST_ROUTING
> to mean "builtin", so -1 mistakenly leads to the checks being active.

LGTM.
