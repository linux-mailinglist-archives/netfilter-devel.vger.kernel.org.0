Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0477618CB3
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 May 2019 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEIPLM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 May 2019 11:11:12 -0400
Received: from mail.us.es ([193.147.175.20]:35964 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfEIPLM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 May 2019 11:11:12 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B94E11C442F
        for <netfilter-devel@vger.kernel.org>; Thu,  9 May 2019 17:11:10 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A9F8ADA70A
        for <netfilter-devel@vger.kernel.org>; Thu,  9 May 2019 17:11:10 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9FB17DA706; Thu,  9 May 2019 17:11:10 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 923A8DA706;
        Thu,  9 May 2019 17:11:08 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 09 May 2019 17:11:08 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.199.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6967B4265A32;
        Thu,  9 May 2019 17:11:08 +0200 (CEST)
Date:   Thu, 9 May 2019 17:11:06 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, logan@cyberstorm.mu
Subject: Re: [nft PATCH 7/9] tests/py: Fix for ip dscp symbol "le"
Message-ID: <20190509151106.qpgz6qrk4hawmbjs@salvia>
References: <20190509113545.4017-1-phil@nwl.cc>
 <20190509113545.4017-8-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509113545.4017-8-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 09, 2019 at 01:35:43PM +0200, Phil Sutter wrote:
> In scanner.l, that name is defined as alternative to "<=" symbol. To
> avoid the clash, it must be quoted on input.
> 
> Fixes: 55715486efba4 ("proto: support for draft-ietf-tsvwg-le-phb-10.txt")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
> Note that nft still produces invalid output since it doesn't quote
> symbol table values.

I have reverted 55715486efba42 by now, I overlook that tests/py/ were
never run because the update for non-json is broken. @Logan: Please,
fix this and resubmit.

BTW, a trick similar to what we do in primary_rhs_expr to deal with
the "le" token showing as a constant value will be needed.
