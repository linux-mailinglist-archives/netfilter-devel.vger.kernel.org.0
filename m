Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8CF6E7432
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Apr 2023 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjDSHmX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Apr 2023 03:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjDSHlg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:41:36 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F3D46A56
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Apr 2023 00:41:22 -0700 (PDT)
Date:   Wed, 19 Apr 2023 09:41:18 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, stgraber@stgraber.org
Subject: Re: [PATCH nf] netfilter: conntrack: restore IPS_CONFIRMED out of
 nf_conntrack_hash_check_insert()
Message-ID: <ZD+bHjZ67rs5+CyY@calendula>
References: <20230418214024.14653-1-pablo@netfilter.org>
 <20230419061723.GF21058@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419061723.GF21058@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 19, 2023 at 08:17:23AM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > e6d57e9ff0ae ("netfilter: conntrack: fix rmmod double-free race")
> > consolidates IPS_CONFIRMED bit set in nf_conntrack_hash_check_insert().
> > However, this breaks ctnetlink:
> > 
> >  # conntrack -I -p tcp --timeout 123 --src 1.2.3.4 --dst 5.6.7.8 --state ESTABLISHED --sport 1 --dport 4 -u SEEN_REPLY
> >  conntrack v1.4.6 (conntrack-tools): Operation failed: Device or resource busy
> > 
> > This is a partial revert of the aforementioned commit.
> > 
> > Fixes: e6d57e9ff0ae ("netfilter: conntrack: fix rmmod double-free race")
> > Reported-by: Stéphane Graber <stgraber@stgraber.org>
> > Tested-by: Stéphane Graber <stgraber@stgraber.org>
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> >  net/netfilter/nf_conntrack_bpf.c     | 1 +
> >  net/netfilter/nf_conntrack_core.c    | 1 -
> >  net/netfilter/nf_conntrack_netlink.c | 3 +++
> >  3 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> > index bfc3aaa2c872..d3ee18854698 100644
> > --- a/net/netfilter/nf_conntrack_netlink.c
> > +++ b/net/netfilter/nf_conntrack_netlink.c
> > @@ -2316,6 +2316,9 @@ ctnetlink_create_conntrack(struct net *net,
> >  	nfct_seqadj_ext_add(ct);
> >  	nfct_synproxy_ext_add(ct);
> >  
> > +	/* we must add conntrack extensions before confirmation. */
> > +	ct->status |= IPS_CONFIRMED;
> > +
> 
> I'd guess that these 2 lines are the only part that is needed, but up
> to you.

OK, I have drropped the bfp chunk.
