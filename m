Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8830A142E6
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 May 2019 00:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfEEWkM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 May 2019 18:40:12 -0400
Received: from mail.us.es ([193.147.175.20]:51578 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfEEWkM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 May 2019 18:40:12 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E834911ED80
        for <netfilter-devel@vger.kernel.org>; Mon,  6 May 2019 00:40:09 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D7E03DA705
        for <netfilter-devel@vger.kernel.org>; Mon,  6 May 2019 00:40:09 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id CD8EBDA703; Mon,  6 May 2019 00:40:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DDEFCDA702;
        Mon,  6 May 2019 00:40:07 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 06 May 2019 00:40:07 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BD3BA4265A31;
        Mon,  6 May 2019 00:40:07 +0200 (CEST)
Date:   Mon, 6 May 2019 00:40:07 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3 nf] netfilter: nf_flow_table: do not use deleted CT's
 flow offload
Message-ID: <20190505224007.wh7m4a345ouwm72r@salvia>
References: <20190430135614.8773-1-ap420073@gmail.com>
 <20190505223803.imszbt6em52epv5j@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505223803.imszbt6em52epv5j@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 06, 2019 at 12:38:03AM +0200, Pablo Neira Ayuso wrote:
> On Tue, Apr 30, 2019 at 10:56:14PM +0900, Taehee Yoo wrote:
> > flow offload of CT can be deleted by the masquerade module. then,
> > flow offload should be deleted too. but GC and data-path of flow offload
> > do not check CT's status. hence they will be removed only by the timeout.
> > 
> > GC and data-path routine will check ct->status.
> > If IPS_DYING_BIT is set, GC will delete CT and data-path routine
> > do not use it.
> 
> Applied, thanks.

For the record, I have edited to patch title to: "netfilter:
nf_flow_table: do not flow offload deleted conntrack entries"
