Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F3557EA
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfFYTlo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Jun 2019 15:41:44 -0400
Received: from mail.us.es ([193.147.175.20]:47088 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfFYTln (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:41:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DD78DC330C
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 21:41:41 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CCE8EDA708
        for <netfilter-devel@vger.kernel.org>; Tue, 25 Jun 2019 21:41:41 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C1C93DA801; Tue, 25 Jun 2019 21:41:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5E597DA708;
        Tue, 25 Jun 2019 21:41:39 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 25 Jun 2019 21:41:39 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 38D934265A31;
        Tue, 25 Jun 2019 21:41:39 +0200 (CEST)
Date:   Tue, 25 Jun 2019 21:41:38 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Felix Kaechele <felix@kaechele.ca>
Cc:     netfilter-devel@vger.kernel.org, kristian.evensen@gmail.com
Subject: Re: [PATCH 08/13] netfilter: ctnetlink: Resolve conntrack
 L3-protocol flush regression
Message-ID: <20190625194138.dsu34hqazmeju3qh@salvia>
References: <20190513095630.32443-1-pablo@netfilter.org>
 <20190513095630.32443-9-pablo@netfilter.org>
 <0a4e3cd2-82f7-8ad6-2403-9852e34c8ac3@kaechele.ca>
 <20190624235816.vw6ahepdgvxhvdej@salvia>
 <4367f30f-4602-a4b6-a96e-35d879cc7758@kaechele.ca>
 <20190625080853.d6f523cimgg2u44v@salvia>
 <0904a616-106c-91de-ed55-97973aa5c330@kaechele.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0904a616-106c-91de-ed55-97973aa5c330@kaechele.ca>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 25, 2019 at 07:33:05AM -0400, Felix Kaechele wrote:
> On 2019-06-25 4:08 a.m., Pablo Neira Ayuso wrote:
> > As you describe, conntrack is a hashtable and the layer 3 protocol is
> > part of the hash:
> > 
> > https://elixir.bootlin.com/linux/latest/source/net/netfilter/nf_conntrack_core.c#L188
> > 
> > so AF_UNSPEC cannot work.
> > 
> > There is no support for layer 3 wildcard deletion.
> 
> So in this case I'd like to propose two options:
> 
> 1. the patch should be reverted and userspace fixed to properly request
> flushing of both AF_INET and AF_INET6 entries in the table when doing a full
> flush
> 
> 2. both this patch as well as the initial patch "netfilter: ctnetlink:
> Support L3 protocol-filter on flush" should be reverted and a new approach
> should be made to implement that feature.
> 
> As it stands right now current kernel versions that are being released break
> userspace, which is unfortunate, because it forces me to run older,
> vulnerable kernels.

Your usecase has never ever worked. You cannot delete entries via
AF_UNSPEC, you're just mixing things up.
