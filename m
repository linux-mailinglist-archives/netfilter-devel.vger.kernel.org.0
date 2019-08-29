Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24146A1D0A
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Aug 2019 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfH2Oia (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Aug 2019 10:38:30 -0400
Received: from correo.us.es ([193.147.175.20]:42622 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbfH2Oi2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:38:28 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 95FF61C0223
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Aug 2019 16:38:24 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 89D03DA8E8
        for <netfilter-devel@vger.kernel.org>; Thu, 29 Aug 2019 16:38:24 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7F862DA840; Thu, 29 Aug 2019 16:38:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 72EF2DA72F;
        Thu, 29 Aug 2019 16:38:22 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 29 Aug 2019 16:38:22 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 49B8C4265A5A;
        Thu, 29 Aug 2019 16:38:22 +0200 (CEST)
Date:   Thu, 29 Aug 2019 16:38:23 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_flow_table: clear skb tstamp before xmit
Message-ID: <20190829143823.j2n4bdi2pqtbtwba@salvia>
References: <20190827192345.12661-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827192345.12661-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:23:45PM +0200, Florian Westphal wrote:
> If 'fq' qdisc is used and a program has requested timestamps,
> skb->tstamp needs to be cleared, else fq will treat these as
> 'transmit time'.

Applied, thanks.
