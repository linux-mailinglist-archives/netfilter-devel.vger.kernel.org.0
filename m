Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68436100BA8
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Nov 2019 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfKRSnG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Nov 2019 13:43:06 -0500
Received: from correo.us.es ([193.147.175.20]:52184 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfKRSnG (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:43:06 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 96BD34DE735
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Nov 2019 19:43:02 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 895C8D1DBB
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Nov 2019 19:43:02 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7EF8DD2B1F; Mon, 18 Nov 2019 19:43:02 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D1893DA72F;
        Mon, 18 Nov 2019 19:42:56 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 18 Nov 2019 19:42:56 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id AC75542EE38E;
        Mon, 18 Nov 2019 19:42:56 +0100 (CET)
Date:   Mon, 18 Nov 2019 19:42:58 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 1/2] files: Drop shebangs from config files
Message-ID: <20191118184258.ukfa3p3f75huhkwh@salvia>
References: <20191107114516.9258-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107114516.9258-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 07, 2019 at 12:45:15PM +0100, Phil Sutter wrote:
> These are not meant to be executed as is but instead loaded via
> 'nft -f' - all-in-one.nft even points this out in header comment.
> While being at it, drop two spelling mistakes found along the way.
> 
> Consequently remove executable bits - being registered in automake as
> dist_pkgsysconf_DATA, they're changed to 644 upon installation anyway.
> 
> Also there is obviously no need for replacement of nft binary path
> anymore, drop that bit from Makefile.am.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

No object from Arturo, so:

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
