Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6138AA5
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 14:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfFGMtq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 08:49:46 -0400
Received: from mail.us.es ([193.147.175.20]:40392 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfFGMtp (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:49:45 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6D293C04E3
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Jun 2019 14:49:43 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5D09BDA715
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Jun 2019 14:49:43 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 28591DA70B; Fri,  7 Jun 2019 14:49:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 28983DA709;
        Fri,  7 Jun 2019 14:49:40 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 07 Jun 2019 14:49:40 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 05C4D4265A31;
        Fri,  7 Jun 2019 14:49:39 +0200 (CEST)
Date:   Fri, 7 Jun 2019 14:49:39 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Guillaume Nault <gnault@redhat.com>
Cc:     netfilter-devel@vger.kernel.org, Peter Oskolkov <posk@google.com>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH nf] netfilter: ipv6: nf_defrag: accept duplicate
 fragments again
Message-ID: <20190607124939.qwwfyeuqmej7atqi@salvia>
References: <e8f3e725c5546df221c4aeec340b6bb73631145e.1559836971.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f3e725c5546df221c4aeec340b6bb73631145e.1559836971.git.gnault@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 06, 2019 at 06:04:00PM +0200, Guillaume Nault wrote:
> When fixing the skb leak introduced by the conversion to rbtree, I
> forgot about the special case of duplicate fragments. The condition
> under the 'insert_error' label isn't effective anymore as
> nf_ct_frg6_gather() doesn't override the returned value anymore. So
> duplicate fragments now get NF_DROP verdict.
> 
> To accept duplicate fragments again, handle them specially as soon as
> inet_frag_queue_insert() reports them. Return -EINPROGRESS which will
> translate to NF_STOLEN verdict, like any accepted fragment. However,
> such packets don't carry any new information and aren't queued, so we
> just drop them immediately.

Applied, thanks.
