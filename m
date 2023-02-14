Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FB269686F
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Feb 2023 16:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjBNPsk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Feb 2023 10:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjBNPsj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:48:39 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713D2BF0D
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Feb 2023 07:48:04 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pRxXF-0005mr-Qd; Tue, 14 Feb 2023 16:48:01 +0100
Date:   Tue, 14 Feb 2023 16:48:01 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: fix rmmod double-free race
Message-ID: <20230214154801.GC22890@breakpoint.cc>
References: <20230213175737.26685-1-fw@strlen.de>
 <Y+uEM5Rmr5ARRoKz@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+uEM5Rmr5ARRoKz@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > @@ -934,8 +936,7 @@ nf_conntrack_hash_check_insert(struct nf_conn *ct)
> >  
> >  	if (!nf_ct_ext_valid_post(ct->ext)) {
> >  		nf_ct_kill(ct);
> 
> I think this nf_ct_kill() delivers a destroy to userspace for an entry
> that was never added?
> 
> lock is not held anymore, so maybe a packet already got this
> conntrack.
> 
> Maybe post validation also needs to hold the lock and
> nf_conntrack_hash_check_insert() could undo the list insertion itself
> leaving things as they were before calling this function?

I think its safe to move _post before the actual insertion, because
get_next_corpse has to wait until we've released the lock.

If the genid check passes and the genid is incremented right
after on another core we can be sure that nf_ct_iterate() will see the
not-yet-inserted entry as we're holding the hash & reply slot locks.

This makes things simpler as we can go back to 'no failure after
insert' semantics.
