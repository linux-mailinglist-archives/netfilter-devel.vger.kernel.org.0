Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC64C8065
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Mar 2022 02:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiCABh0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Feb 2022 20:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiCABhZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:37:25 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC263D4A1
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Feb 2022 17:36:46 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nOrRT-0005tl-Po; Tue, 01 Mar 2022 02:36:43 +0100
Date:   Tue, 1 Mar 2022 02:36:43 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Joe Stringer <joe@cilium.io>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH nf] netfilter: nf_queue: be more careful with sk refcounts
Message-ID: <20220301013643.GD12167@breakpoint.cc>
References: <20220228162918.23327-1-fw@strlen.de>
 <CADa=Ryx0-A6TmXjSDUO0V-6arMjbOhO6MXV6emNhugAm+F_oLg@mail.gmail.com>
 <20220228234143.GB12167@breakpoint.cc>
 <CADa=RyzGKsayKFSX22qAVOaZ6Sq6akPvBxq32OUK6yvB_1+T=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADa=RyzGKsayKFSX22qAVOaZ6Sq6akPvBxq32OUK6yvB_1+T=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Joe Stringer <joe@cilium.io> wrote:
> I'm not sure I follow the question
> about veth/netns crossing as this feature can only be used on TC
> ingress today.

Ah, never mind then.  Thanks for explaining!
