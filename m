Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6E10536C
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 14:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKUNoT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 08:44:19 -0500
Received: from correo.us.es ([193.147.175.20]:46738 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKUNoT (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:44:19 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6A928103290
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 14:44:15 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5D6E3D1911
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 14:44:15 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5306DD2B1E; Thu, 21 Nov 2019 14:44:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5D944DA840;
        Thu, 21 Nov 2019 14:44:13 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 21 Nov 2019 14:44:13 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3738F42EF4E0;
        Thu, 21 Nov 2019 14:44:13 +0100 (CET)
Date:   Thu, 21 Nov 2019 14:44:14 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH] utils: Define __visible even if not supported
 by compiler
Message-ID: <20191121134414.2umdbwwfj244el2z@salvia>
References: <20191121112456.28274-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121112456.28274-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:24:56PM +0100, Phil Sutter wrote:
> Since __visible is now used directly, provide a fallback empty
> definition if HAVE_VISIBILITY_HIDDEN is not defined.
> 
> Fixes: 7349a70634fa0 ("Deprecate untyped data setters")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
