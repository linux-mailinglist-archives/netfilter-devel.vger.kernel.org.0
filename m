Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A05F82EF5
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Aug 2019 11:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfHFJoP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Aug 2019 05:44:15 -0400
Received: from correo.us.es ([193.147.175.20]:43006 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFJoP (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:44:15 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4D098F26EA
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Aug 2019 11:44:13 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3B1BB1150D8
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Aug 2019 11:44:13 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 30D08DA704; Tue,  6 Aug 2019 11:44:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 241B5DA704;
        Tue,  6 Aug 2019 11:44:11 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 06 Aug 2019 11:44:11 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (149.103.108.93.rev.vodafone.pt [93.108.103.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 8F9C24265A31;
        Tue,  6 Aug 2019 11:44:10 +0200 (CEST)
Date:   Tue, 6 Aug 2019 11:44:08 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Michael Braun <michael-dev@fami-braun.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nfnetlink_log:add support for VLAN information
Message-ID: <20190806094408.yyc4toud5yjll5ta@salvia>
References: <20190805072814.14922-1-michael-dev@fami-braun.de>
 <20190805103516.ctrrelq3zcorhr3n@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805103516.ctrrelq3zcorhr3n@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 05, 2019 at 12:35:16PM +0200, Florian Westphal wrote:
> Michael Braun <michael-dev@fami-braun.de> wrote:
> > Currently, there is no vlan information (e.g. when used with a vlan aware
> > bridge) passed to userspache, HWHEADER will contain an 08 00 (ip) suffix
> > even for tagged ip packets.
> > 
> > Therefore, add an extra netlink attribute that passes the vlan tag to
> > userspace. Userspace might need to handle PCP/DEI included in this field.
> > 
> > Signed-off-by: Michael Braun <michael-dev@fami-braun.de>
> 
> nfqueue has nfqnl_put_bridge() helper which will plcae both tci and
> proto in a nested attribute, I wonder if we can just re-use that?
> 
> (Yes, we need new attributes unfortunately).

Indeed, something similar to nfqnl_put_bridge() would be great to get
nfnetlink_log in feature parity with nfnetlink_queue.

Thanks.
