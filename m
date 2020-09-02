Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DAE25ACBA
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Sep 2020 16:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIBORM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Sep 2020 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgIBOQy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:16:54 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B468C061244
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Sep 2020 07:16:52 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kDTZ1-0006PH-3n; Wed, 02 Sep 2020 16:16:39 +0200
Date:   Wed, 2 Sep 2020 16:16:39 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de, eric@garver.life
Subject: Re: [PATCH] netfilter: nf_tables: coalesce multiple notifications
 into one skbuff
Message-ID: <20200902141639.GD23632@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, fw@strlen.de, eric@garver.life
References: <20200827172842.24478-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827172842.24478-1-pablo@netfilter.org>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Thu, Aug 27, 2020 at 07:28:42PM +0200, Pablo Neira Ayuso wrote:
[...]
> +static void nft_commit_notify(struct net *net, u32 portid)
> +{
> +	struct sk_buff *batch_skb = NULL, *nskb, *skb;
> +	unsigned char *data;
> +	int len;
> +
> +	list_for_each_entry_safe(skb, nskb, &net->nft.notify_list, list) {
> +		if (!batch_skb) {
> +new_batch:
> +			batch_skb = skb;
> +			NFT_CB(batch_skb).report = NFT_CB(skb).report;
> +			len = NLMSG_GOODSIZE;

This doesn't account for the data in the first skb. After changing the
line into 'len = NLMSG_GOODSIZE - skb->len;', the reported problem
disappears and the patch works as expected.

Cheers, Phil
