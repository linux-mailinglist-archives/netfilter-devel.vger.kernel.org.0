Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88D7B257E
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Sep 2023 20:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjI1SsE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Sep 2023 14:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjI1SsD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:48:03 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6648D180
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Sep 2023 11:48:00 -0700 (PDT)
Received: from [78.30.34.192] (port=36398 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qlw3H-003rHL-AR; Thu, 28 Sep 2023 20:47:57 +0200
Date:   Thu, 28 Sep 2023 20:47:54 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH v2 8/8] netfilter: nf_tables: Add locking for
 NFT_MSG_GETSETELEM_RESET requests
Message-ID: <ZRXKWuGAE1snXkaK@calendula>
References: <20230928165244.7168-1-phil@nwl.cc>
 <20230928165244.7168-9-phil@nwl.cc>
 <20230928174630.GD19098@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928174630.GD19098@breakpoint.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 28, 2023 at 07:46:30PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > +static int nf_tables_dumpreset_set(struct sk_buff *skb,
> > +				   struct netlink_callback *cb)
> > +{
> > +	struct nftables_pernet *nft_net = nft_pernet(sock_net(skb->sk));
> > +	struct nft_set_dump_ctx *dump_ctx = cb->data;
> > +	int ret, skip = cb->args[0];
> > +
> > +	mutex_lock(&nft_net->commit_mutex);
> > +	ret = nf_tables_dump_set(skb, cb);
> > +	mutex_unlock(&nft_net->commit_mutex);
> > +
> > +	if (cb->args[0] > skip)
> > +		audit_log_nft_set_reset(dump_ctx->ctx.table, cb->seq,
> > +					cb->args[0] - skip);
> > +
> 
> Once commit_mutex is dropped, parallel user can
> delete table, and ctx.table references garbage.

This path should hold rcu read lock.

> So I think this needs to be done under mutex.

I think spinlock would be better, we would just spin for very little
time here for another thread to complete the reset, and the race is
fixed.

The use of commit_mutex here is confusing is really misleading to the
reader, this is also not the commit path.
