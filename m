Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690395202EC
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 May 2022 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbiEIQve (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 May 2022 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiEIQvb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 May 2022 12:51:31 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B096822B381
        for <netfilter-devel@vger.kernel.org>; Mon,  9 May 2022 09:47:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1no6Xl-00064u-RY; Mon, 09 May 2022 18:47:33 +0200
Date:   Mon, 9 May 2022 18:47:33 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Sven Auhagen <Sven.Auhagen@voleatech.de>
Cc:     netfilter-devel@vger.kernel.org, pablo@netfilter.org, nbd@nbd.name,
        fw@strlen.de, paulb@nvidia.com, ozsh@nvidia.com
Subject: Re: [PATCH] nf_flowtable: teardown fix race condition
Message-ID: <20220509164733.GA12438@breakpoint.cc>
References: <20220509093132.fmxxhhogq7jhhpks@SvensMacbookPro.hq.voleatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509093132.fmxxhhogq7jhhpks@SvensMacbookPro.hq.voleatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Sven Auhagen <Sven.Auhagen@voleatech.de> wrote:
> +	if (unlikely(!test_bit(IPS_ASSURED_BIT, &flow->ct->status))) {
> +		spin_lock_bh(&flow->ct->lock);
> +		flow->ct->proto.tcp.state = TCP_CONNTRACK_ESTABLISHED;
> +		spin_unlock_bh(&flow->ct->lock);
> +		set_bit(IPS_ASSURED_BIT, &flow->ct->status);

Uh. Whats going on here?  ASSURED bit prevents early-eviction,
it should not be set at random.
