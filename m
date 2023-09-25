Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18C07AE01F
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Sep 2023 21:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjIYTxa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Sep 2023 15:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjIYTx3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:53:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C1C109
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Sep 2023 12:53:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qkrdt-0000iR-1A; Mon, 25 Sep 2023 21:53:17 +0200
Date:   Mon, 25 Sep 2023 21:53:17 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH 2/5] netfilter: nf_tables: Add locking for
 NFT_MSG_GETRULE_RESET requests
Message-ID: <20230925195317.GC22532@breakpoint.cc>
References: <20230923013807.11398-1-phil@nwl.cc>
 <20230923013807.11398-3-phil@nwl.cc>
 <20230923110437.GB22532@breakpoint.cc>
 <ZQ7+MF4aweUYmU7j@orbyte.nwl.cc>
 <20230923161813.GB19098@breakpoint.cc>
 <ZRFTx6pFYt2tZuSy@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRFTx6pFYt2tZuSy@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Sat, Sep 23, 2023 at 06:18:13PM +0200, Florian Westphal wrote:
> > callback_that_might_reset()
> > {
> > 	try_module_get ...
> > 	rcu_read_unlock()
> > 	mutex_lock(net->commit_mutex)
> > 	  dumper();
> > 	mutex_unlock(net->commit_mutex)
> > 	rcu_read_lock();
> > 	module_put()
> > }
> >
> > should do the trick.
> 
> Idiom above LGTM, *except for net->commit_mutex*. Please do not use
> ->commit_mutex: This will stall ruleset updates for no reason, netlink
> dump would grab and release such mutex for each netlink_recvmsg() call
> and netlink dump side will always retry because of NLM_F_EINTR.

It will stall updates, but for good reason: we are making changes to the
expressions state.

We even emit AUDIT messages about this.
So, I think the commit mutex is appropirate here.

That said, if you totally disagree, then I suppose a new "reset" mutex
could be used instead.
