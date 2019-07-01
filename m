Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C679323BC8
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbfETPM7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 11:12:59 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:58910 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730650AbfETPM7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 11:12:59 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hSjyD-0002FP-PG; Mon, 20 May 2019 17:12:57 +0200
Date:   Mon, 20 May 2019 17:12:57 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de, phil@nwl.cc
Subject: Re: [PATCH iptables RFC 4/4] nft: don't care about previous state in
 RESTART
Message-ID: <20190520151257.n2zgcoahsz7t5oyb@breakpoint.cc>
References: <20190520144115.29732-1-pablo@netfilter.org>
 <20190520144115.29732-5-pablo@netfilter.org>
 <20190520144938.gqjakvfck6v4akq3@salvia>
 <20190520150625.orluik4il46mgu2x@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520150625.orluik4il46mgu2x@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > So we only skip the flush if the table does not exist.
> >
> > Still not working though, hitting EEXIST on CHAIN_USER_ADD.
> 
> The nfnl_unlock(subsys_id); is released after check the generation ID
> in nfnetlink.
> 
> This is rendering the generation ID useless. We need a kernel fix for
> this.

-v, the subsys mutex is released, but we do hold the transaction mutex.

parallel batch that is incoming will block in
nf_tables_valid_genid() until current transaction completes, then it
will fail due to genid mismatch.
