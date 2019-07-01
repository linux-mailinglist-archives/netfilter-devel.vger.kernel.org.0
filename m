Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6028325FD3
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 May 2019 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfEVIzu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 May 2019 04:55:50 -0400
Received: from mail.us.es ([193.147.175.20]:48886 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbfEVIzu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 May 2019 04:55:50 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2FBF381B07
        for <netfilter-devel@vger.kernel.org>; Wed, 22 May 2019 10:55:48 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1FBCFDA712
        for <netfilter-devel@vger.kernel.org>; Wed, 22 May 2019 10:55:48 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1F23FDA711; Wed, 22 May 2019 10:55:48 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 12A9DDA708;
        Wed, 22 May 2019 10:55:46 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 22 May 2019 10:55:46 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E5E254265A31;
        Wed, 22 May 2019 10:55:45 +0200 (CEST)
Date:   Wed, 22 May 2019 10:55:45 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, marcmicalizzi@gmail.com
Subject: Re: [PATCH nf 0/5] netfilter: flow table fixes
Message-ID: <20190522085545.xza7h3mh6y2shox2@salvia>
References: <20190521112434.11767-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521112434.11767-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 21, 2019 at 01:24:29PM +0200, Florian Westphal wrote:
> This series fixes several issues I spotted while investigating
> a 'tcp connection stalls with flow offload on' bug report.
> 
> I'm not sure if the original problem is fixed, however, the test script
> in patch 5 will fail without the fixes from patches 1 and 2.
> 
> Patches 3 and 4 fix additional problems, however, these are by code
> review only.

Series applied, thanks Florian.
