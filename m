Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EA4738A25
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Jun 2023 17:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjFUPw0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Jun 2023 11:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjFUPwZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:52:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D2219C
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Jun 2023 08:52:24 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qC086-0000Io-ME; Wed, 21 Jun 2023 17:52:22 +0200
Date:   Wed, 21 Jun 2023 17:52:22 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: dccp: copy entire header to
 stack buffer, not just basic one
Message-ID: <20230621155222.GF24035@breakpoint.cc>
References: <20230621154451.8176-1-fw@strlen.de>
 <CANn89i+RGTkWuOeVwf5ocRuk4+heQcEeZVFcrRKeR4sRKoN1KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+RGTkWuOeVwf5ocRuk4+heQcEeZVFcrRKeR4sRKoN1KQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Eric Dumazet <edumazet@google.com> wrote:
> > +       struct dccp_hdr *dh;
> >
> >         dh = skb_header_pointer(skb, dataoff, sizeof(_dh), &_dh);
> 
> sizeof(struct dccp_hdr) , or sizeof(_dh._dh) ?

sizeof(*dh) :-)

Thanks, I will send v2.
