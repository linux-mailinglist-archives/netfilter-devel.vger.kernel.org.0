Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D6D528362
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 May 2022 13:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbiEPLho (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 May 2022 07:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiEPLhm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 May 2022 07:37:42 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C92EDF51;
        Mon, 16 May 2022 04:37:41 -0700 (PDT)
Date:   Mon, 16 May 2022 13:37:38 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     Oz Shlomo <ozsh@nvidia.com>, Felix Fietkau <nbd@nbd.name>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>, Paul Blakey <paulb@nvidia.com>
Subject: Re: [PATCH net v2] netfilter: nf_flow_table: fix teardown flow
 timeout
Message-ID: <YoI3gliaYc250Vnb@salvia>
References: <20220512182803.6353-1-ozsh@nvidia.com>
 <YoIt5rHw4Xwl1zgY@salvia>
 <20220516111817.2jic2qnij2dvkp5i@Svens-MacBookPro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220516111817.2jic2qnij2dvkp5i@Svens-MacBookPro.local>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 16, 2022 at 01:18:17PM +0200, Sven Auhagen wrote:
> On Mon, May 16, 2022 at 12:56:38PM +0200, Pablo Neira Ayuso wrote:
> > On Thu, May 12, 2022 at 09:28:03PM +0300, Oz Shlomo wrote:
> > > Connections leaving the established state (due to RST / FIN TCP packets)
> > > set the flow table teardown flag. The packet path continues to set lower
> > > timeout value as per the new TCP state but the offload flag remains set.
> > >
> > > Hence, the conntrack garbage collector may race to undo the timeout
> > > adjustment of the packet path, leaving the conntrack entry in place with
> > > the internal offload timeout (one day).
> > >
> > > Avoid ct gc timeout overwrite by flagging teared down flowtable
> > > connections.
> > >
> > > On the nftables side we only need to allow established TCP connections to
> > > create a flow offload entry. Since we can not guaruantee that
> > > flow_offload_teardown is called by a TCP FIN packet we also need to make
> > > sure that flow_offload_fixup_ct is also called in flow_offload_del
> > > and only fixes up established TCP connections.
> > [...]
> > > diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
> > > index 0164e5f522e8..324fdb62c08b 100644
> > > --- a/net/netfilter/nf_conntrack_core.c
> > > +++ b/net/netfilter/nf_conntrack_core.c
> > > @@ -1477,7 +1477,8 @@ static void gc_worker(struct work_struct *work)
> > >  			tmp = nf_ct_tuplehash_to_ctrack(h);
> > >  
> > >  			if (test_bit(IPS_OFFLOAD_BIT, &tmp->status)) {
> > > -				nf_ct_offload_timeout(tmp);
> > 
> > Hm, it is the trick to avoid checking for IPS_OFFLOAD from the packet
> > path that triggers the race, ie. nf_ct_is_expired()
> > 
> > The flowtable ct fixup races with conntrack gc collector.
> > 
> > Clearing IPS_OFFLOAD might result in offloading the entry again for
> > the closing packets.
> > 
> > Probably clear IPS_OFFLOAD from teardown, and skip offload if flow is
> > in a TCP state that represent closure?
>
> >   		if (unlikely(!tcph || tcph->fin || tcph->rst))
> >   			goto out;
> > 
> > this is already the intention in the existing code.
> > 
> > If this does work, could you keep IPS_OFFLOAD_TEARDOWN_BIT internal,
> > ie. no in uapi? Define it at include/net/netfilter/nf_conntrack.h and
> > add a comment regarding this to avoid an overlap in the future.
> > 
> > > +				if (!test_bit(IPS_OFFLOAD_TEARDOWN_BIT, &tmp->status))
> > > +					nf_ct_offload_timeout(tmp);
> > >  				continue;
> > >  			}
> > >  
> > > diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
> > > index 3db256da919b..aaed1a244013 100644
> > > --- a/net/netfilter/nf_flow_table_core.c
> > > +++ b/net/netfilter/nf_flow_table_core.c
> > > @@ -177,14 +177,8 @@ int flow_offload_route_init(struct flow_offload *flow,
> > >  }
> > >  EXPORT_SYMBOL_GPL(flow_offload_route_init);
> > >  
> > > -static void flow_offload_fixup_tcp(struct ip_ct_tcp *tcp)
> > > -{
> > > -	tcp->state = TCP_CONNTRACK_ESTABLISHED;
> > > -	tcp->seen[0].td_maxwin = 0;
> > > -	tcp->seen[1].td_maxwin = 0;
> > > -}
> > >  
> > > -static void flow_offload_fixup_ct_timeout(struct nf_conn *ct)
> > > +static void flow_offload_fixup_ct(struct nf_conn *ct)
> > >  {
> > >  	struct net *net = nf_ct_net(ct);
> > >  	int l4num = nf_ct_protonum(ct);
> > > @@ -192,8 +186,12 @@ static void flow_offload_fixup_ct_timeout(struct nf_conn *ct)
> > >  
> > >  	if (l4num == IPPROTO_TCP) {
> > >  		struct nf_tcp_net *tn = nf_tcp_pernet(net);
> > > +		struct ip_ct_tcp *tcp = &ct->proto.tcp;
> > > +
> > > +		tcp->seen[0].td_maxwin = 0;
> > > +		tcp->seen[1].td_maxwin = 0;
> > >  
> > > -		timeout = tn->timeouts[TCP_CONNTRACK_ESTABLISHED];
> > > +		timeout = tn->timeouts[ct->proto.tcp.state];
> > >  		timeout -= tn->offload_timeout;
> > >  	} else if (l4num == IPPROTO_UDP) {
> > >  		struct nf_udp_net *tn = nf_udp_pernet(net);
> > > @@ -211,18 +209,6 @@ static void flow_offload_fixup_ct_timeout(struct nf_conn *ct)
> > >  		WRITE_ONCE(ct->timeout, nfct_time_stamp + timeout);
> > >  }
> > >  
> > > -static void flow_offload_fixup_ct_state(struct nf_conn *ct)
> > > -{
> > > -	if (nf_ct_protonum(ct) == IPPROTO_TCP)
> > > -		flow_offload_fixup_tcp(&ct->proto.tcp);
> > > -}
> > > -
> > > -static void flow_offload_fixup_ct(struct nf_conn *ct)
> > > -{
> > > -	flow_offload_fixup_ct_state(ct);
> > > -	flow_offload_fixup_ct_timeout(ct);
> > > -}
> > > -
> > >  static void flow_offload_route_release(struct flow_offload *flow)
> > >  {
> > >  	nft_flow_dst_release(flow, FLOW_OFFLOAD_DIR_ORIGINAL);
> > > @@ -353,6 +339,10 @@ static inline bool nf_flow_has_expired(const struct flow_offload *flow)
> > >  static void flow_offload_del(struct nf_flowtable *flow_table,
> > >  			     struct flow_offload *flow)
> > >  {
> > > +	struct nf_conn *ct = flow->ct;
> > > +
> > > +	set_bit(IPS_OFFLOAD_TEARDOWN_BIT, &flow->ct->status);
> > > +
> > >  	rhashtable_remove_fast(&flow_table->rhashtable,
> > >  			       &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].node,
> > >  			       nf_flow_offload_rhash_params);
> > > @@ -360,12 +350,11 @@ static void flow_offload_del(struct nf_flowtable *flow_table,
> > >  			       &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].node,
> > >  			       nf_flow_offload_rhash_params);
> > >  
> > > -	clear_bit(IPS_OFFLOAD_BIT, &flow->ct->status);
> > > -
> > >  	if (nf_flow_has_expired(flow))
> > > -		flow_offload_fixup_ct(flow->ct);
> > > -	else
> > > -		flow_offload_fixup_ct_timeout(flow->ct);
> > > +		flow_offload_fixup_ct(ct);
> > 
> > Very unlikely, but race might still happen between fixup and
> > clear IPS_OFFLOAD_BIT with gc below?
> > 
> > Without checking from the packet path, the conntrack gc might race to
> > refresh the timeout, I don't see a 100% race free solution.
> > 
> > Probably update the nf_ct_offload_timeout to a shorter value than a
> > day would mitigate this issue too.
> 
> This section of the code is now protected by IPS_OFFLOAD_TEARDOWN_BIT
> which will prevent the update via nf_ct_offload_timeout.
> We set it at the beginning of flow_offload_del and flow_offload_teardown.
> 
> Since flow_offload_teardown is only called on TCP packets
> we also need to set it at flow_offload_del to prevent the race.
> 
> This should prevent the race at this point.

OK.

> > > +	clear_bit(IPS_OFFLOAD_BIT, &ct->status);
> > > +	clear_bit(IPS_OFFLOAD_TEARDOWN_BIT, &ct->status);
> > >  
> > >  	flow_offload_free(flow);
> > >  }
> > > @@ -373,8 +362,9 @@ static void flow_offload_del(struct nf_flowtable *flow_table,
> > >  void flow_offload_teardown(struct flow_offload *flow)
> > >  {
> > >  	set_bit(NF_FLOW_TEARDOWN, &flow->flags);
> > > +	set_bit(IPS_OFFLOAD_TEARDOWN_BIT, &flow->ct->status);
> > >  
> > > -	flow_offload_fixup_ct_state(flow->ct);
> > > +	flow_offload_fixup_ct(flow->ct);
> > >  }
> > >  EXPORT_SYMBOL_GPL(flow_offload_teardown);
> > >  
> > > diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
> > > index 900d48c810a1..9cc3ea08eb3a 100644
> > > --- a/net/netfilter/nft_flow_offload.c
> > > +++ b/net/netfilter/nft_flow_offload.c
> > > @@ -295,6 +295,8 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
> > >  					  sizeof(_tcph), &_tcph);
> > >  		if (unlikely(!tcph || tcph->fin || tcph->rst))
> > >  			goto out;
> > > +		if (unlikely(!nf_conntrack_tcp_established(ct)))
> > > +			goto out;
> > 
> > This chunk is not required, from ruleset users can do
> > 
> >         ... ct status assured ...
> > 
> > instead.
> 
> Maybe this should be mentioned in the manual or wiki if
> it is not necessary in the flow offload code.

Yes, documentation and wiki can be updated.

Users might want to offload the flow at a later stage in the TCP
connection.
