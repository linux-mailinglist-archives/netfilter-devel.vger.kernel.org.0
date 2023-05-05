Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88CD6F8456
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 May 2023 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjEENrA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 May 2023 09:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjEENq7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 May 2023 09:46:59 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263B612F
        for <netfilter-devel@vger.kernel.org>; Fri,  5 May 2023 06:46:58 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1puvlv-0006El-P9; Fri, 05 May 2023 15:46:55 +0200
Date:   Fri, 5 May 2023 15:46:55 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/3] netfilter: nf_tables: reject loads from
 uninitialized registers
Message-ID: <20230505134655.GC6126@breakpoint.cc>
References: <20230505111656.32238-1-fw@strlen.de>
 <ZFUBusxUvWw//ENx@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFUBusxUvWw//ENx@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> On Fri, May 05, 2023 at 01:16:53PM +0200, Florian Westphal wrote:
> > Keep a per-rule bitmask that tracks registers that have seen a store,
> > then reject loads when the accessed registers haven't been flagged.
> > 
> > This changes uabi contract, because we previously allowed this.
> > Neither nftables nor iptables-nft create such rules.
> 
> Did you consider keeping this bitmask on a per base-chain level? One had
> to perform this for each base chain of a table upon each rule change and
> traverse the tree of chains jumped to from there. I guess the huge
> overhead disqualifies this, though.

Yes, but its very hard task, because in that case we also need to prove
that a write *WILL* happen, rather than *might happen*.

Consider:

rule1:
ip protocol tcp iifname "eth0" ...
reg1 := ip protocol
cmp reg1
reg2 := meta iifname

rule2:
iifname "eth1" ...
cmp reg2 "eth0"

rule 2 has to be rejected because reg2 might be unitialized for != tcp.

Even if we can handle this some way, we now also need to revalidate the
ruleset on deletes, because we'd have to detect when a register write
we depend on goes away.
