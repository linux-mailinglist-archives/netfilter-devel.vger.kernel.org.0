Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421F23030CD
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Jan 2021 01:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbhAZAF6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Jan 2021 19:05:58 -0500
Received: from correo.us.es ([193.147.175.20]:33966 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732455AbhAZAFi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Jan 2021 19:05:38 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 48E94508CC5
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Jan 2021 01:03:58 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 39581DA78C
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Jan 2021 01:03:58 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2EEA4DA73D; Tue, 26 Jan 2021 01:03:58 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 72EE6DA704;
        Tue, 26 Jan 2021 01:03:55 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 26 Jan 2021 01:03:55 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 54FBE426CC84;
        Tue, 26 Jan 2021 01:03:55 +0100 (CET)
Date:   Tue, 26 Jan 2021 01:04:52 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, dpayne <darby.payne@gmail.com>,
        netfilter-devel@vger.kernel.org, lvs-devel@vger.kernel.org
Subject: Re: [PATCH v6] ipvs: add weighted random twos choice algorithm
Message-ID: <20210126000452.GA29052@salvia>
References: <c97fced3-b6b7-ba40-274c-7a5749bbe48a@ssi.bg>
 <20210106190242.1044489-1-darby.payne@gmail.com>
 <c13462ca-37ce-1112-f73c-40d3e612482@ssi.bg>
 <20210124104524.GG576@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210124104524.GG576@vergenet.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jan 24, 2021 at 11:45:24AM +0100, Simon Horman wrote:
> On Wed, Jan 06, 2021 at 09:25:47PM +0200, Julian Anastasov wrote:
> > 
> > 	Hello,
> > 
> > On Wed, 6 Jan 2021, dpayne wrote:
> > 
> > > Adds the random twos choice load-balancing algorithm. The algorithm will
> > > pick two random servers based on weights. Then select the server with
> > > the least amount of connections normalized by weight. The algorithm
> > > avoids the "herd behavior" problem. The algorithm comes from a paper
> > > by Michael Mitzenmacher available here
> > > http://www.eecs.harvard.edu/~michaelm/NEWWORK/postscripts/twosurvey.pdf
> > > 
> > > Signed-off-by: dpayne <darby.payne@gmail.com>
> > 
> > 	Looks good to me for -next, thanks!
> > 
> > Acked-by: Julian Anastasov <ja@ssi.bg>
> 
> Sorry for the delay,
> 
> Acked-by: Simon Horman <horms@verge.net.au>

Applied, thanks.
