Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07EDA9D2
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 12:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfJQKUr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 06:20:47 -0400
Received: from correo.us.es ([193.147.175.20]:34872 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfJQKUr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:20:47 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 334EB11EB8E
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Oct 2019 12:20:42 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 23C84DA801
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Oct 2019 12:20:42 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 19402B8007; Thu, 17 Oct 2019 12:20:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2D258B7FF6;
        Thu, 17 Oct 2019 12:20:40 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 17 Oct 2019 12:20:40 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0B95441E4800;
        Thu, 17 Oct 2019 12:20:40 +0200 (CEST)
Date:   Thu, 17 Oct 2019 12:20:42 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, Edward Cree <ecree@solarflare.com>
Subject: Re: [PATCH v2 nf-next] netfilter: add and use nf_hook_slow_list()
Message-ID: <20191017102042.emoxv5oesxov4oxv@salvia>
References: <20191010223037.10811-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010223037.10811-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:30:37AM +0200, Florian Westphal wrote:
> At this time, NF_HOOK_LIST() macro will iterate the list and then calls
> nf_hook() for each individual skb.
> 
> This makes it so the entire list is passed into the netfilter core.
> The advantage is that we only need to fetch the rule blob once per list
> instead of per-skb.
> 
> NF_HOOK_LIST now only works for ipv4 and ipv6, as those are the only
> callers.
> 
> v2: use skb_list_del_init() instead of list_del (Edward Cree)
> 
> Cc: Edward Cree <ecree@solarflare.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Applied.
