Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5884F511DE3
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 Apr 2022 20:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbiD0Qam (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Apr 2022 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbiD0Q2p (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:28:45 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66A7655BF
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Apr 2022 09:23:08 -0700 (PDT)
Date:   Wed, 27 Apr 2022 18:23:05 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables 7/7] nft: support for dynamic register allocation
Message-ID: <Ymlt6QWWy4xUag2x@salvia>
References: <20220424215613.106165-1-pablo@netfilter.org>
 <20220424215613.106165-8-pablo@netfilter.org>
 <YmgYkZE7hZFVL0D4@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmgYkZE7hZFVL0D4@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:06:41PM +0200, Phil Sutter wrote:
> On Sun, Apr 24, 2022 at 11:56:13PM +0200, Pablo Neira Ayuso wrote:
[...]
> > +
> > +static int reg_space(int i)
> > +{
> > +	return sizeof(uint32_t) * 16 - sizeof(uint32_t) * i;
> > +}
> > +
> > +static void register_track(const struct nft_handle *h,
> > +			   struct nft_reg_ctx *ctx, int i, int len)
> > +{
> > +	if (ctx->reg >= 0 || h->regs[i].word || reg_space(i) < len)
> > +		return;
> 
> Since ctx->reg is not reset in callers' loops and reg_space(i) is
> monotonic, maybe make those loop exit conditions by returning false from
> register_track() in those cases?

you mean:

        if (!register_track(...))
                continue;

?

That defeats the check for a matching register already storing the
data I need, ie.

        if (h->regs[i].type != NFT_REG_META)
                continue;
        ...

> > +	if (h->regs[i].type == NFT_REG_UNSPEC) {
> > +		ctx->genid = h->reg_genid;
> 
> Is ctx->genid used in this case?

It used to shortcircuit the logic to evict a register (no eviction
needed case), but that is not needed anymore since ctx->reg >= 0
already prevents this.

> > +		ctx->reg = i;
> > +	} else if (h->regs[i].genid < ctx->genid) {
> > +		ctx->genid = h->regs[i].genid;
> > +		ctx->evict = i;
> 
> What if the oldest reg is too small?

The reg_space(i) < len check prevents this?

> > +	} else if (h->regs[i].len == len) {
> > +		ctx->evict = i;
> > +		ctx->genid = 0;
> 
> Why prefer regs of same size over older ones?

this was an early optimization. An Ipv6 address might evict up four
registers, if n stores old data, then n+1, n+2, n+3 store recent data,
n+1, n+2, n+3 would be unfairly evicted.

I can remove this case: it is probably an early optimization. This is
the initial version of the dynamic register allocation infra. It
should be possible to catch for more suboptimal situations with real
rulesets, by incrementally reviewing generated bytecode.

[...]
> > +uint8_t meta_get_register(struct nft_handle *h, enum nft_meta_keys key)
> 
> Accept a uint32_t len parameter and replace all the sizeof(uint32_t)
> below with it? Not needed but consistent with payload_get_register() and
> less hard-coded values.

Actually NFT_META_TIME_NS uses 64 bits, assuming 32-bits for meta is
indeed not correct.

[...]
> > @@ -1201,21 +1202,26 @@ static int __add_nft_among(struct nft_handle *h, const char *table,
> >  		nftnl_set_elem_add(s, elem);
> >  	}
> >  
> > -	e = gen_payload(h, NFT_PAYLOAD_LL_HEADER,
> > -			eth_addr_off[dst], ETH_ALEN, &reg);
> > +	concat_len = ETH_ALEN;
> > +	if (ip)
> > +		concat_len += sizeof(struct in_addr);
> > +
> > +	reg = get_register(h, concat_len);
> > +	e = __gen_payload(NFT_PAYLOAD_LL_HEADER,
> > +			  eth_addr_off[dst], ETH_ALEN, reg);
> >  	if (!e)
> >  		return -ENOMEM;
> >  	nftnl_rule_add_expr(r, e);
> >  
> >  	if (ip) {
> > -		e = gen_payload(h, NFT_PAYLOAD_NETWORK_HEADER, ip_addr_off[dst],
> > -				sizeof(struct in_addr), &reg);
> > +		e = __gen_payload(NFT_PAYLOAD_NETWORK_HEADER, ip_addr_off[dst],
> > +				  sizeof(struct in_addr), reg + 2);
> 
> With a respective macro, this could be 'reg + REG_ALIGN(ETH_ALEN)'.

that's feasible.

> >  struct nft_handle {
> >  	int			family;
> >  	struct mnl_socket	*nl;
> > @@ -111,6 +133,9 @@ struct nft_handle {
> >  	bool			cache_init;
> >  	int			verbose;
> >  
> > +	struct nft_regs		regs[20];
> 
> Why 20? Ain't 16 enough?

Yes, this should be 16.
