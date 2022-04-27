Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B617E5110A5
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Apr 2022 07:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357926AbiD0Fvg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Apr 2022 01:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbiD0Fvd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:51:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9646821804
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Apr 2022 22:48:22 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1njaXE-0008ST-A4; Wed, 27 Apr 2022 07:48:20 +0200
Date:   Wed, 27 Apr 2022 07:48:20 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nft_socket: socket expressions for GID & UID
Message-ID: <20220427054820.GB9849@breakpoint.cc>
References: <20220420185447.10199-1-toiwoton@gmail.com>
 <5a292abd-7f2e-728f-5594-86d85fbd1c00@gmail.com>
 <20220425223421.GA14400@breakpoint.cc>
 <ab7923f2-d1e7-ce61-5df8-c05778ef3ebd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <ab7923f2-d1e7-ce61-5df8-c05778ef3ebd@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> wrote:
> On 26.4.2022 1.34, Florian Westphal wrote:
> > Topi Miettinen <toiwoton@gmail.com> wrote:
> > > On 20.4.2022 21.54, Topi Miettinen wrote:
> > > > Add socket expressions for checking GID or UID of the originating
> > > > socket. These work also on input side, unlike meta skuid/skgid.
> > > 
> > > Unfortunately, there's a reproducible kernel BUG when closing a local
> > > connection:
> > > 
> > > Apr 25 21:18:13 kernel:
> > > ==================================================================
> > > Apr 25 21:18:13 kernel: BUG: KASAN: null-ptr-deref in
> > > nf_sk_lookup_slow_v6+0x45b/0x590 [nf_socket_ipv6]
> > 
> > You can pass this to scripts/faddr2line to get the location of the null deref.
> 
> Didn't work,

?

You pass the object file and the nf_sk_lookup_slow_v6+0x45b/0x590 info.
I can't do it for you because I lack the object file and the exact
source code.

> net/ipv6/netfilter/nf_socket_ipv6.c:
> 
> static struct sock *
> nf_socket_get_sock_v6(struct net *net, struct sk_buff *skb, int doff,
>                       const u8 protocol,
>                       const struct in6_addr *saddr, const struct in6_addr
> *daddr,
>                       const __be16 sport, const __be16 dport,
>                       const struct net_device *in)
> {
>         switch (protocol) {
>         case IPPROTO_TCP:
>                 return inet6_lookup(net, &tcp_hashinfo, skb, doff,
>                                     saddr, sport, daddr, dport,
>                                     in->ifindex);

What does that rule look like?  Seems like no input interface is
available, seems like a bug in existing code?
