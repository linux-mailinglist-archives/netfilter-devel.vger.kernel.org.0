Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D38428115F
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Oct 2020 13:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgJBLmc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Oct 2020 07:42:32 -0400
Received: from correo.us.es ([193.147.175.20]:59702 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBLmc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:42:32 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 928C018FD85
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Oct 2020 13:42:30 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 863A0E150B
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Oct 2020 13:42:30 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7A4B4DA73F; Fri,  2 Oct 2020 13:42:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6864DDA72F;
        Fri,  2 Oct 2020 13:42:28 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 02 Oct 2020 13:42:28 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 4861142EF4E1;
        Fri,  2 Oct 2020 13:42:28 +0200 (CEST)
Date:   Fri, 2 Oct 2020 13:42:27 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Arturo Borrero Gonzalez <arturo@netfilter.org>
Cc:     Phil Sutter <phil@nwl.cc>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: iptables-nft-restore issue
Message-ID: <20201002114227.GA2592@salvia>
References: <198c69b7-d7b2-f910-c469-199bfe2fda28@netfilter.org>
 <20200930115922.GC20140@breakpoint.cc>
 <20200930121314.GA21983@salvia>
 <20200930122453.GA24863@salvia>
 <fd7a8319-e008-4fa5-1c24-af6c9da9612a@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd7a8319-e008-4fa5-1c24-af6c9da9612a@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:30:31PM +0200, Arturo Borrero Gonzalez wrote:
> On 2020-09-30 14:26, Pablo Neira Ayuso wrote:
> > 
> > Probably this patch?
> > 
> 
> The patch seems to work. Let me submit it with a testcase.

Go ahead.
