Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377BBCF702
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Oct 2019 12:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfJHK1y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Oct 2019 06:27:54 -0400
Received: from correo.us.es ([193.147.175.20]:59458 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbfJHK1x (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:27:53 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F3666E3EE4F
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Oct 2019 12:27:46 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E2F07FB362
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Oct 2019 12:27:46 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D82522DC7B; Tue,  8 Oct 2019 12:27:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D62CEB7FF2;
        Tue,  8 Oct 2019 12:27:44 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 08 Oct 2019 12:27:44 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BC83E42EF4E1;
        Tue,  8 Oct 2019 12:27:44 +0200 (CEST)
Date:   Tue, 8 Oct 2019 12:27:46 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue 0/5] clang and documentation updates
Message-ID: <20191008102746.h72le7hizrxqa4j5@salvia>
References: <20191008004948.25632-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008004948.25632-1-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 08, 2019 at 11:49:43AM +1100, Duncan Roe wrote:
> This series is a mixture of patches to enable clang build and correct / insert
> doxygen comments. It ended up that way after git merges of local branches where
> they were originally developed.
> 
> Hopefully they are all uncontroversial so can just be applied.

Series applied, thanks.

I have just mangled "src: Enable clang build" not to split the
function definition from its return value, it's a personal preference,
I like to git grep for function definitions occasionally when
searching for symbols. This is something in between your original
proposal and what it's done in libmnl.

Thanks.
