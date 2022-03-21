Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99944E238C
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Mar 2022 10:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbiCUJsN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Mar 2022 05:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346027AbiCUJsC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:48:02 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 218FA72E0C
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Mar 2022 02:46:37 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5B42660212;
        Mon, 21 Mar 2022 10:43:55 +0100 (CET)
Date:   Mon, 21 Mar 2022 10:46:33 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, sven.auhagen@voleatech.de
Subject: Re: [PATCH nf-next] netfilter: nf_conntrack_tcp: preserve liberal
 flag in tcp options
Message-ID: <YjhJeQsI5TWTNgI0@salvia>
References: <20220321094205.63121-1-pablo@netfilter.org>
 <YjhJBGffCTEtOuB9@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjhJBGffCTEtOuB9@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:44:39AM +0100, Pablo Neira Ayuso wrote:
> On Mon, Mar 21, 2022 at 10:42:05AM +0100, Pablo Neira Ayuso wrote:
> > When tcp_options is called all flags are cleared.
> > When the IP_CT_TCP_FLAG_BE_LIBERAL is set it should be preserved
> > otherwise such connections will fail in the window check.
> 
> 
> This patch completes 8437a6209f76 ("netfilter: nft_flow_offload: set liberal tracking mode for tcp")
> 
> I'm going to send v2 to add a wrapper function to update these flags,
> so we do not accidentally reset IP_CT_TCP_FLAG_BE_LIBERAL.

Hm. Actually I don't see a clear way to add such wrapper function, so
patch LGTM as is.

> > Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> > Supersedes: https://patchwork.ozlabs.org/project/netfilter-devel/patch/20220318144939.69465-1-pablo@netfilter.org/ which is not correct, it breaks TCP FIN handling.
> > 
> >  net/netfilter/nf_conntrack_proto_tcp.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
> > index d1582b888c0d..d8599ab5f767 100644
> > --- a/net/netfilter/nf_conntrack_proto_tcp.c
> > +++ b/net/netfilter/nf_conntrack_proto_tcp.c
> > @@ -342,7 +342,7 @@ static void tcp_options(const struct sk_buff *skb,
> >  		return;
> >  
> >  	state->td_scale =
> > -	state->flags = 0;
> > +	state->flags &= IP_CT_TCP_FLAG_BE_LIBERAL;
> >  
> >  	while (length > 0) {
> >  		int opcode=*ptr++;
> > @@ -873,7 +873,7 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
> >  	struct nf_tcp_net *tn = nf_tcp_pernet(net);
> >  	struct nf_conntrack_tuple *tuple;
> >  	enum tcp_conntrack new_state, old_state;
> > -	unsigned int index, *timeouts;
> > +	unsigned int index, flags, *timeouts;
> >  	enum ip_conntrack_dir dir;
> >  	const struct tcphdr *th;
> >  	struct tcphdr _tcph;
> > @@ -968,8 +968,10 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
> >  			ct->proto.tcp.last_flags &= ~IP_CT_EXP_CHALLENGE_ACK;
> >  			ct->proto.tcp.seen[ct->proto.tcp.last_dir].flags =
> >  				ct->proto.tcp.last_flags;
> > +			flags = ct->proto.tcp.seen[dir].flags;
> >  			memset(&ct->proto.tcp.seen[dir], 0,
> >  			       sizeof(struct ip_ct_tcp_state));
> > +			ct->proto.tcp.seen[dir].flags = flags & IP_CT_TCP_FLAG_BE_LIBERAL;
> >  			break;
> >  		}
> >  		ct->proto.tcp.last_index = index;
> > -- 
> > 2.30.2
> > 
