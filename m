Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0639D1AFC17
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Apr 2020 18:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDSQne (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Apr 2020 12:43:34 -0400
Received: from correo.us.es ([193.147.175.20]:35602 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgDSQne (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:43:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DEAFEC51A3
        for <netfilter-devel@vger.kernel.org>; Sun, 19 Apr 2020 18:43:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D11CF20C64
        for <netfilter-devel@vger.kernel.org>; Sun, 19 Apr 2020 18:43:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C6ECEFA525; Sun, 19 Apr 2020 18:43:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C809BDA3C4;
        Sun, 19 Apr 2020 18:43:30 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 19 Apr 2020 18:43:30 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A95EB41E4800;
        Sun, 19 Apr 2020 18:43:30 +0200 (CEST)
Date:   Sun, 19 Apr 2020 18:43:30 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Matt Turner <mattst88@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables] doc: Include generated man pages in dist tarball
Message-ID: <20200419164330.tn7ov4qm3o7mde2f@salvia>
References: <20200407190508.21496-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407190508.21496-1-mattst88@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 07, 2020 at 12:05:08PM -0700, Matt Turner wrote:
> Most projects ship pre-generated man pages in the distribution tarball
> so that builders don't need the documentation tools installed, similar
> to how bison-generated sources are included.
> 
> To do this, we conditionalize the presence check of a2x on whether nft.8
> already exists in the source directory, as it would exist if included in
> the distribution tarball.
> 
> Secondly, we move the 'if BUILD_MAN' conditional to around the man page
> generation rules. This ensures that the man pages are unconditionally
> installed. Also only add the man pages to CLEANFILES if their generation
> is enabled.

Applied, thanks.
