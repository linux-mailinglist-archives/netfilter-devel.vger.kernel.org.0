Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFE904A5
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Aug 2019 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfHPP1W (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 16 Aug 2019 11:27:22 -0400
Received: from correo.us.es ([193.147.175.20]:47030 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfHPP1W (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:27:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 12E0DF2787
        for <netfilter-devel@vger.kernel.org>; Fri, 16 Aug 2019 17:27:19 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 03798D2B1B
        for <netfilter-devel@vger.kernel.org>; Fri, 16 Aug 2019 17:27:19 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id EBF77D2B18; Fri, 16 Aug 2019 17:27:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DB560DA72F;
        Fri, 16 Aug 2019 17:27:16 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 16 Aug 2019 17:27:16 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id BA12C4265A2F;
        Fri, 16 Aug 2019 17:27:16 +0200 (CEST)
Date:   Fri, 16 Aug 2019 17:27:17 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: nfacct: Fix alignment mismatch in
 xt_nfacct_match_info
Message-ID: <20190816152717.uje6jxebuw4vq47h@salvia>
References: <7899070.tJGA48rBTd@rocinante.m.i2n>
 <3db64b99-9787-4e9d-7499-55cb32591856@intra2net.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3db64b99-9787-4e9d-7499-55cb32591856@intra2net.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 16, 2019 at 05:09:56PM +0200, Juliana Rodrigueiro wrote:
> Hi Florian.
> 
> I hope this patch reflects your suggestion to add a 'v1' match revision
> to nfacct. To be sincere, I'm not sure if should have also written
> nfacct_mt_v1() and etc, since these would be pretty much duplicate code.
> 
> Please let me know if this patch needs more work.

Please, send userspace iptables patch to add v1 too. Thanks.
