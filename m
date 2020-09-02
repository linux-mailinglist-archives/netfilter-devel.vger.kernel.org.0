Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA525AE44
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Sep 2020 17:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgIBPFL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Sep 2020 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgIBPEp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:04:45 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0DBC061244
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Sep 2020 08:04:44 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1kDUJX-00072t-8y; Wed, 02 Sep 2020 17:04:43 +0200
Date:   Wed, 2 Sep 2020 17:04:43 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, eric@garver.life
Subject: Re: [PATCH nf,v2] netfilter: nf_tables: coalesce multiple
 notifications into one skbuff
Message-ID: <20200902150443.GE23632@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, eric@garver.life
References: <20200902145202.6822-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902145202.6822-1-pablo@netfilter.org>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 02, 2020 at 04:52:02PM +0200, Pablo Neira Ayuso wrote:
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

Is this assignment needed? NFT_CB() merely dereferences skb->cb, so
after assigning 'batch_skb = skb', NFT_CB(batch_skb) == NFT_CB(skb), no?

(Sorry for the late complaint, I forgot about it until reviewing your
v2.)

Cheers, Phil
