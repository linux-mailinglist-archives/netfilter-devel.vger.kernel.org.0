Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB05C1E55A
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 May 2019 00:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfENWzv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 May 2019 18:55:51 -0400
Received: from mail.us.es ([193.147.175.20]:49256 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfENWzu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 May 2019 18:55:50 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B65C3F2785
        for <netfilter-devel@vger.kernel.org>; Wed, 15 May 2019 00:55:48 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A744EDA70B
        for <netfilter-devel@vger.kernel.org>; Wed, 15 May 2019 00:55:48 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9D0D0DA708; Wed, 15 May 2019 00:55:48 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AC1E9DA704;
        Wed, 15 May 2019 00:55:46 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 15 May 2019 00:55:46 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 8B7EB4265A31;
        Wed, 15 May 2019 00:55:46 +0200 (CEST)
Date:   Wed, 15 May 2019 00:55:46 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/2 nft] jump: Allow goto and jump to a variable using
 nft input files
Message-ID: <20190514225546.lspqs3p752q5wlju@salvia>
References: <20190514211340.913-1-ffmancera@riseup.net>
 <20190514211340.913-2-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514211340.913-2-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 14, 2019 at 11:13:40PM +0200, Fernando Fernandez Mancera wrote:
> This patch introduces the use of nft input files variables in 'jump' and 'goto'
> statements, e.g.
> 
> define dest = ber
> 
> add table ip foo
> add chain ip foo bar {type filter hook input priority 0;}
> add chain ip foo ber
> add rule ip foo ber counter
> add rule ip foo bar jump $dest
> 
> table ip foo {
> 	chain bar {
> 		type filter hook input priority filter; policy accept;
> 		jump ber
> 	}
> 
> 	chain ber {
> 		counter packets 71 bytes 6664
> 	}
> }

Please, add a tests/shell/ script for this in your next patch version.

Thanks.
