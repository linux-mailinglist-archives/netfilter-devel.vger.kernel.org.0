Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F904D547
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 Jun 2019 19:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfFTRdP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 20 Jun 2019 13:33:15 -0400
Received: from mx1.riseup.net ([198.252.153.129]:46182 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFTRdP (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:33:15 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id AE5F81A19A4;
        Thu, 20 Jun 2019 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1561051994; bh=zRgPyPvx/AZ52wp0Nnf6yL4GBBUU7myip+VXIff2nfM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NykQFYGorWmg+u9BwVXE75h6gCFn3VewBPNqxs2BCuvxnnXZNQq801D7808+SW1h3
         fuCpiXvJOv+Ah+GoYw31yuL2z6gDehzQj5yR0R5U9UM/vI6RzvnwvCblKqyFE30Muy
         5IQoIDZ787EpgFei04zBrMKElz8xY3FPpAWpnuyA=
X-Riseup-User-ID: 46FCE07950D4DB68A6F9D156AE75697BD4474394A5CBCF9DE5DC4F1517052897
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id EA7DE12096A;
        Thu, 20 Jun 2019 10:33:13 -0700 (PDT)
Subject: Re: [PATCH nf-next v2] netfilter: nf_tables: Add SYNPROXY support
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <20190619180654.1432-1-ffmancera@riseup.net>
 <20190620141008.6dcgzgynbyfxkvf2@salvia>
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
Openpgp: preference=signencrypt
Message-ID: <6e04cd54-2ffd-c179-725c-0023d6f440e8@riseup.net>
Date:   Thu, 20 Jun 2019 19:33:23 +0200
MIME-Version: 1.0
In-Reply-To: <20190620141008.6dcgzgynbyfxkvf2@salvia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Agree with everything, I am going to send a new patch series with all
the fixes. Thanks Pablo :-)

On 6/20/19 4:10 PM, Pablo Neira Ayuso wrote:
> On Wed, Jun 19, 2019 at 08:06:54PM +0200, Fernando Fernandez Mancera wrote:
> [...]
>> diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
>> new file mode 100644
>> index 000000000000..3ef7f1dc50be
>> --- /dev/null
>> +++ b/net/netfilter/nft_synproxy.c
>> @@ -0,0 +1,327 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
> 
> Remove empty line above.
> 
>> +#include <linux/types.h>
>> +
> 
> Same here.
> 
>> +#include <net/ip.h>
>> +#include <net/tcp.h>
>> +#include <net/netlink.h>
>> +
> 
> Same here.
> 
>> +#include <net/netfilter/nf_tables.h>
>> +#include <net/netfilter/nf_conntrack.h>
>> +#include <net/netfilter/nf_conntrack_ecache.h>
> 
> I don't think we need this ecache.h header.
> 
>> +#include <net/netfilter/nf_conntrack_extend.h>
> 
> You can remove _extend.h, already included by _synproxy.h
> 
>> +#include <net/netfilter/nf_conntrack_seqadj.h>
> 
> Do we need _seqadj.h?
> 
>> +#include <net/netfilter/nf_conntrack_synproxy.h>
>> +#include <net/netfilter/nf_synproxy.h>
>> +
> 
> remove empty line.
> 
>> +#include <linux/netfilter/nf_tables.h>
>> +#include <linux/netfilter/nf_SYNPROXY.h>
>> +
>> +struct nft_synproxy {
>> +	struct nf_synproxy_info	info;
>> +};
>> +
>> +static const struct nla_policy nft_synproxy_policy[NFTA_SYNPROXY_MAX + 1] = {
>> +	[NFTA_SYNPROXY_MSS]		= { .type = NLA_U16 },
>> +	[NFTA_SYNPROXY_WSCALE]		= { .type = NLA_U8 },
>> +	[NFTA_SYNPROXY_FLAGS]		= { .type = NLA_U32 },
>> +};
>> +
>> +static void nft_synproxy_eval_v4(const struct nft_expr *expr,
>> +				 struct nft_regs *regs,
>> +				 const struct nft_pktinfo *pkt)
>> +{
>> +	struct nft_synproxy *priv = nft_expr_priv(expr);
>> +	struct nf_synproxy_info info = priv->info;
>> +	struct synproxy_options opts = {};
>> +	struct net *net = nft_net(pkt);
>> +	struct synproxy_net *snet = synproxy_pernet(net);
>> +	struct sk_buff *skb = pkt->skb;
>> +	int thoff = pkt->xt.thoff;
>> +	const struct tcphdr *tcp;
>> +	struct tcphdr _tcph;
>> +
>> +	if (nf_ip_checksum(skb, nft_hook(pkt), thoff, IPPROTO_TCP)) {
>> +		regs->verdict.code = NF_DROP;
>> +		return;
>> +	}
>> +
>> +	tcp = skb_header_pointer(skb, ip_hdrlen(skb),
>> +				 sizeof(struct tcphdr), &_tcph);
>> +	if (!tcp) {
>> +		regs->verdict.code = NF_DROP;
>> +		return;
>> +	}
> 
> This code above is common to eval_v6, you can place it in _eval(),
> and pass the pointer tcph to _eval_v4().
> 
>> +	if (!synproxy_parse_options(skb, thoff, tcp, &opts)) {
>> +		regs->verdict.code = NF_DROP;
>> +		return;
>> +	}
>> +
>> +	if (tcp->syn) {
>> +		/* Initial SYN from client */
>> +		this_cpu_inc(snet->stats->syn_received);
>> +
>> +		if (tcp->ece && tcp->cwr)
>> +			opts.options |= NF_SYNPROXY_OPT_ECN;
>> +
>> +		opts.options &= priv->info.options;
>> +		if (opts.options & NF_SYNPROXY_OPT_TIMESTAMP)
>> +			synproxy_init_timestamp_cookie(&info, &opts);
>> +		else
>> +			opts.options &= ~(NF_SYNPROXY_OPT_WSCALE |
>> +					  NF_SYNPROXY_OPT_SACK_PERM |
>> +					  NF_SYNPROXY_OPT_ECN);
>> +
>> +		synproxy_send_client_synack(net, skb, tcp, &opts);
>> +		consume_skb(skb);
>> +		regs->verdict.code = NF_STOLEN;
>> +		return;
>> +	} else if (tcp->ack) {
>> +		/* ACK from client */
>> +		if (synproxy_recv_client_ack(net, skb, tcp, &opts,
>> +					     ntohl(tcp->seq))) {
>> +			consume_skb(skb);
>> +			regs->verdict.code = NF_STOLEN;
>> +		} else {
>> +			regs->verdict.code = NF_DROP;
>> +		}
>> +		return;
>> +	}
>> +
>> +	regs->verdict.code = NFT_CONTINUE;
>> +}
>> +
>> +#if IS_ENABLED(CONFIG_NF_TABLES_IPV6)
>> +static void nft_synproxy_eval_v6(const struct nft_expr *expr,
>> +				 struct nft_regs *regs,
>> +				 const struct nft_pktinfo *pkt)
>> +{
>> +	struct nft_synproxy *priv = nft_expr_priv(expr);
>> +	struct nf_synproxy_info info = priv->info;
>> +	struct synproxy_options opts = {};
>> +	struct net *net = nft_net(pkt);
>> +	struct synproxy_net *snet = synproxy_pernet(net);
>> +	struct sk_buff *skb = pkt->skb;
>> +	int thoff = pkt->xt.thoff;
>> +	const struct tcphdr *tcp;
>> +	struct tcphdr _tcph;
>> +
>> +	if (nf_ip_checksum(skb, nft_hook(pkt), thoff, IPPROTO_TCP)) {
>> +		regs->verdict.code = NF_DROP;
>> +		return;
>> +	}
>> +
>> +	tcp = skb_header_pointer(skb, ip_hdrlen(skb),
> 
> ip_hdrlen() won't fly for IPv6.
> 
>> +				 sizeof(struct tcphdr), &_tcph);
>> +	if (!tcp) {
>> +		regs->verdict.code = NF_DROP;
>> +		return;
>> +	}
>> +
>> +	if (!synproxy_parse_options(skb, thoff, tcp, &opts)) {
>> +		regs->verdict.code = NF_DROP;
>> +		return;
>> +	}
>> +
>> +	if (tcp->syn) {
> 
> From here...
> 
>> +		/* Initial SYN from client */
>> +		this_cpu_inc(snet->stats->syn_received);
>> +
>> +		if (tcp->ece && tcp->cwr)
>> +			opts.options |= NF_SYNPROXY_OPT_ECN;
>> +
>> +		opts.options &= priv->info.options;
>> +		if (opts.options & NF_SYNPROXY_OPT_TIMESTAMP)
>> +			synproxy_init_timestamp_cookie(&info, &opts);
>> +		else
>> +			opts.options &= ~(NF_SYNPROXY_OPT_WSCALE |
>> +					  NF_SYNPROXY_OPT_SACK_PERM |
>> +					  NF_SYNPROXY_OPT_ECN);
> 
> ... to here. Could you wrap this code into a function? eg.
> 
>         nft_synproxy_tcp_options(...);
> 
> that can be shared by v4 and v6.
> 
>> +
>> +		synproxy_send_client_synack_ipv6(net, skb, tcp, &opts);
>> +		consume_skb(skb);
>> +		regs->verdict.code = NF_STOLEN;
>> +		return;
>> +	} else if (tcp->ack) {
>> +		/* ACK from client */
>> +		if (synproxy_recv_client_ack_ipv6(net, skb, tcp, &opts,
>> +						  ntohl(tcp->seq))) {
>> +			consume_skb(skb);
>> +			regs->verdict.code = NF_STOLEN;
>> +		} else {
>> +			regs->verdict.code = NF_DROP;
>> +		}
>> +		return;
>> +	}
>> +
>> +	regs->verdict.code = NFT_CONTINUE;
>> +}
>> +#endif /* CONFIG_NF_TABLES_IPV6*/
>> +
>> +static void nft_synproxy_eval(const struct nft_expr *expr,
>> +			      struct nft_regs *regs,
>> +			      const struct nft_pktinfo *pkt)
>> +{
>> +	struct sk_buff *skb = pkt->skb;
>> +	const struct tcphdr *tcp;
>> +	struct tcphdr _tcph;
>> +
>> +	tcp = skb_header_pointer(skb, ip_hdrlen(skb),
>> +				 sizeof(struct tcphdr), &_tcph);
>> +	if (!tcp) {
>> +		regs->verdict.code = NFT_BREAK;
>> +		return;
>> +	}
> 
> Hm. You should check for pkt->tprot to check if this is really TCP
> before trying to fetch the tcp header.
> 
>> +	switch (skb->protocol) {
>> +	case htons(ETH_P_IP):
>> +		nft_synproxy_eval_v4(expr, regs, pkt);
>> +		return;
>> +#if IS_ENABLED(CONFIG_NF_TABLES_IPV6)
>> +	case htons(ETH_P_IPV6):
>> +		nft_synproxy_eval_v6(expr, regs, pkt);
>> +		return;
>> +#endif
>> +	}
>> +	regs->verdict.code = NFT_BREAK;
>> +}
>> +
>> +static int nft_synproxy_init(const struct nft_ctx *ctx,
>> +			     const struct nft_expr *expr,
>> +			     const struct nlattr * const tb[])
>> +{
>> +	struct synproxy_net *snet = synproxy_pernet(ctx->net);
>> +	struct nft_synproxy *priv = nft_expr_priv(expr);
>> +	u32 flags;
>> +	int err;
>> +
>> +	err = nf_ct_netns_get(ctx->net, ctx->family);
>> +	if (err)
>> +		goto nf_ct_failure;
> 
> You just:
> 
>                 return err;
> 
> here, if nf_ct_netns_get() fails.
> 
>> +
>> +	switch (ctx->family) {
>> +	case NFPROTO_IPV4:
>> +		err = nf_synproxy_ipv4_init(snet, ctx->net);
>> +		if (err)
>> +			goto nf_ct_failure;
>> +		snet->hook_ref4++;
> 
> Why this manual bump of the reference counter? Doesn't
> nf_synproxy_ipv4_init() deal with this?
> 
>> +		break;
>> +#if IS_ENABLED(IPV6)
>> +	case NFPROTO_IPV6:
>> +		err = nf_synproxy_ipv6_init(snet, ctx->net);
>> +		if (err)
>> +			goto nf_ct_failure;
>> +		snet->hook_ref6++;
>> +		break;
>> +	case NFPROTO_INET:
>> +	case NFPROTO_BRIDGE:
>> +		err = nf_synproxy_ipv4_init(snet, ctx->net);
>> +		if (err)
>> +			goto nf_ct_failure;
>> +		err = nf_synproxy_ipv6_init(snet, ctx->net);
>> +		if (err)
>> +			goto nf_ct_failure;
>> +		snet->hook_ref4++;
>> +		snet->hook_ref6++;
>> +		break;
>> +#endif
>> +	}
>> +
>> +	if (tb[NFTA_SYNPROXY_MSS])
>> +		priv->info.mss = ntohs(nla_get_be16(tb[NFTA_SYNPROXY_MSS]));
>> +	if (tb[NFTA_SYNPROXY_WSCALE])
>> +		priv->info.wscale = nla_get_u8(tb[NFTA_SYNPROXY_WSCALE]);
>> +	if (tb[NFTA_SYNPROXY_FLAGS]) {
>> +		flags = ntohl(nla_get_be32(tb[NFTA_SYNPROXY_FLAGS]));
>> +		if (flags != 0 && (flags & NF_SYNPROXY_OPT_MASK) == 0)
>> +			return -EINVAL;
> 
> This -EINVAL ignores error nf_ct_failure error path. I suggest you
> move this code up to the top of nft_synproxy_init(), before calling
> nf_ct_netns_get().
> 
>> +		priv->info.options = flags;
>> +	}
>> +	return 0;
>> +
>> +nf_ct_failure:
>> +	nf_ct_netns_put(ctx->net, ctx->family);
>> +	return err;
>> +}
>> +
>> +static void nft_synproxy_destroy(const struct nft_ctx *ctx,
>> +				 const struct nft_expr *expr)
>> +{
>> +	struct synproxy_net *snet = synproxy_pernet(ctx->net);
>> +
>> +	switch (ctx->family) {
>> +	case NFPROTO_IPV4:
>> +		nf_synproxy_ipv4_fini(snet, ctx->net);
>> +		break;
>> +#if IS_ENABLED(IPV6)
> 
> This should be CONFIG_IPV6, right?
> 
>> +	case NFPROTO_IPV6:
>> +		nf_synproxy_ipv6_fini(snet, ctx->net);
>> +		break;
> 
> #endif
> 
> for IPV6 here.
> 
>> +	case NFPROTO_INET:
> 
> Missing NFPROTO_BRIDGE here.
> 
>> +		nf_synproxy_ipv4_fini(snet, ctx->net);
>> +		nf_synproxy_ipv6_fini(snet, ctx->net);
>> +		break;
>> +#endif
>> +	}
>> +	nf_ct_netns_put(ctx->net, ctx->family);
>> +}
>> +
>> +static int nft_synproxy_dump(struct sk_buff *skb, const struct nft_expr *expr)
>> +{
>> +	const struct nft_synproxy *priv = nft_expr_priv(expr);
>> +
>> +	if (nla_put_be16(skb, NFTA_SYNPROXY_MSS, ntohs(priv->info.mss)) ||
>> +	    nla_put_u8(skb, NFTA_SYNPROXY_WSCALE, priv->info.wscale) ||
>> +	    nla_put_be32(skb, NFTA_SYNPROXY_FLAGS, ntohl(priv->info.options)))
>> +		goto nla_put_failure;
>> +
>> +	return 0;
>> +
>> +nla_put_failure:
>> +	return -1;
>> +}
>> +
>> +static int nft_synproxy_validate(const struct nft_ctx *ctx,
>> +				 const struct nft_expr *expr,
>> +				 const struct nft_data **data)
>> +{
>> +	return nft_chain_validate_hooks(ctx->chain, (1 << NF_INET_LOCAL_IN) |
>> +						    (1 << NF_INET_FORWARD));
>> +}
>> +
>> +static struct nft_expr_type nft_synproxy_type;
>> +static const struct nft_expr_ops nft_synproxy_ops = {
>> +	.eval		= nft_synproxy_eval,
>> +	.size		= NFT_EXPR_SIZE(sizeof(struct nft_synproxy)),
>> +	.init		= nft_synproxy_init,
>> +	.destroy	= nft_synproxy_destroy,
>> +	.dump		= nft_synproxy_dump,
>> +	.type		= &nft_synproxy_type,
>> +	.validate	= nft_synproxy_validate,
>> +};
>> +
>> +static struct nft_expr_type nft_synproxy_type __read_mostly = {
>> +	.ops		= &nft_synproxy_ops,
>> +	.name		= "synproxy",
>> +	.owner		= THIS_MODULE,
>> +	.policy		= nft_synproxy_policy,
>> +	.maxattr	= NFTA_OSF_MAX,
>> +};
>> +
>> +static int __init nft_synproxy_module_init(void)
>> +{
>> +	return nft_register_expr(&nft_synproxy_type);
>> +}
>> +
>> +static void __exit nft_synproxy_module_exit(void)
>> +{
>> +	return nft_unregister_expr(&nft_synproxy_type);
>> +}
>> +
>> +module_init(nft_synproxy_module_init);
>> +module_exit(nft_synproxy_module_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Fernando Fernandez <ffmancera@riseup.net>");
>> +MODULE_ALIAS_NFT_EXPR("synproxy");
>> -- 
>> 2.20.1
>>
