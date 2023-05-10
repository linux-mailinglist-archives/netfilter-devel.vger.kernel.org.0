Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93436FD70D
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 May 2023 08:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjEJGdV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 May 2023 02:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjEJGdT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 May 2023 02:33:19 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18BB73A93
        for <netfilter-devel@vger.kernel.org>; Tue,  9 May 2023 23:33:19 -0700 (PDT)
Date:   Wed, 10 May 2023 08:33:14 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: fix possible bug_on with enable_hooks=1
Message-ID: <ZFs6qpQB8rfK0kPd@calendula>
References: <20230504125502.22512-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504125502.22512-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 04, 2023 at 02:55:02PM +0200, Florian Westphal wrote:
> I received a bug report (no reproducer so far) where we trip over
> 
> 712         rcu_read_lock();
> 713         ct_hook = rcu_dereference(nf_ct_hook);
> 714         BUG_ON(ct_hook == NULL);  // here
> 
> In nf_conntrack_destroy().
> 
> First turn this BUG_ON into a WARN.  I think it was triggered
> via enable_hooks=1 flag.
> 
> When this flag is turned on, the conntrack hooks are registered
> before nf_ct_hook pointer gets assigned.
> This opens a short window where packets enter the conntrack machinery,
> can have skb->_nfct set up and a subsequent kfree_skb might occur
> before nf_ct_hook is set.
> 
> Call nf_conntrack_init_end() to set nf_ct_hook before we register the
> pernet ops.

Applied to nf, thanks
