Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B761F7A8D5
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jul 2019 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfG3MlN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Jul 2019 08:41:13 -0400
Received: from correo.us.es ([193.147.175.20]:57890 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbfG3MlN (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:41:13 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 951C21176A4
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Jul 2019 14:41:11 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8691018539
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Jul 2019 14:41:11 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7C4DADA732; Tue, 30 Jul 2019 14:41:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 649A691F4;
        Tue, 30 Jul 2019 14:41:09 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 30 Jul 2019 14:41:09 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [47.60.32.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0F2F34265A31;
        Tue, 30 Jul 2019 14:41:08 +0200 (CEST)
Date:   Tue, 30 Jul 2019 14:41:06 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2 0/2] parser_bison: Get rid of (most) bison
 compiler warnings
Message-ID: <20190730124106.5edmsjwzzgknpnjs@salvia>
References: <20190723132313.13238-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723132313.13238-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:23:11PM +0200, Phil Sutter wrote:
> Eliminate as many bison warnings emitted since bison-3.3 as possible.
> Sadly getting bison, flex and automake right is full of pitfalls so on
> one hand this series does not fix for deprecated %name-prefix statement
> and on the other passes -Wno-yacc to bison to not complain about POSIX
> incompatibilities although automake causes to run bison in POSIX compat
> mode in the first place. Fixing either of those turned out to be
> non-trivial.

Indeed, lots of warnings and things to be updated.

Do you think it's worth fixing those in the midterm?

We can just place these two small ones in the tree, I'm just concerned
about tech debt in the midterm, these deprecated stuff might just go
away.

Thanks.

> Changes since v1:
> - Drop nfnl_osf patch, Fernando took care of that already.
> - Split remaining patch in two.
> - Document which warnings are being silenced.
> 
> Phil Sutter (2):
>   parser_bison: Fix for deprecated statements
>   src: Call bison with -Wno-yacc to silence warnings
> 
>  src/Makefile.am    | 2 +-
>  src/parser_bison.y | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.22.0
> 
