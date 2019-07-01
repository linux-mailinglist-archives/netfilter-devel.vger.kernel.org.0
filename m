Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64657487BB
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfFQPpz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 11:45:55 -0400
Received: from mail.us.es ([193.147.175.20]:43956 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfFQPpz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:45:55 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9F39D11EF4B
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 17:45:48 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8E3E3DA709
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 17:45:48 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 83A04DA706; Mon, 17 Jun 2019 17:45:48 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A691DDA70B;
        Mon, 17 Jun 2019 17:45:45 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 17 Jun 2019 17:45:45 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 75FE24265A2F;
        Mon, 17 Jun 2019 17:45:45 +0200 (CEST)
Date:   Mon, 17 Jun 2019 17:45:45 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next WIP] netfilter: nf_tables: Add SYNPROXY support
Message-ID: <20190617154545.pr2nhk4itydcya3e@salvia>
References: <20190617103234.1357-1-ffmancera@riseup.net>
 <20190617103234.1357-2-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617103234.1357-2-ffmancera@riseup.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 17, 2019 at 12:32:35PM +0200, Fernando Fernandez Mancera wrote:
> Add SYNPROXY module support in nf_tables. It preserves the behaviour of the
> SYNPROXY target of iptables but structured in a different way to propose
> improvements in the future.
> 
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
>  include/uapi/linux/netfilter/nf_SYNPROXY.h |   4 +
>  include/uapi/linux/netfilter/nf_tables.h   |  16 +
>  net/netfilter/Kconfig                      |  11 +
>  net/netfilter/Makefile                     |   1 +
>  net/netfilter/nft_synproxy.c               | 328 +++++++++++++++++++++
>  5 files changed, 360 insertions(+)
>  create mode 100644 net/netfilter/nft_synproxy.c
> 
> diff --git a/include/uapi/linux/netfilter/nf_SYNPROXY.h b/include/uapi/linux/netfilter/nf_SYNPROXY.h
> index 068d1b3a6f06..0e7c39191819 100644
> --- a/include/uapi/linux/netfilter/nf_SYNPROXY.h
> +++ b/include/uapi/linux/netfilter/nf_SYNPROXY.h
> @@ -9,6 +9,10 @@
>  #define NF_SYNPROXY_OPT_SACK_PERM	0x04
>  #define NF_SYNPROXY_OPT_TIMESTAMP	0x08
>  #define NF_SYNPROXY_OPT_ECN		0x10
> +#define NF_SYNPROXY_FLAGMASK		(NF_SYNPROXY_OPT_MSS | \
> +					 NF_SYNPROXY_OPT_WSCALE | \
> +					 NF_SYNPROXY_OPT_SACK_PERM | \
> +					 NF_SYNPROXY_OPT_TIMESTAMP)

Suggestion:

#define NF_SYNPROXY_OPT_MASK		(...

>  struct nf_synproxy_info {
>  	__u8	options;
[...]
> diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
> index 21025c2c605b..d59742408d9b 100644
> --- a/net/netfilter/Kconfig
> +++ b/net/netfilter/Kconfig
> @@ -651,6 +651,17 @@ config NFT_TPROXY
>  	help
>  	  This makes transparent proxy support available in nftables.
>  
> +config NFT_SYNPROXY
> +	tristate "Netfilter nf_tables SYNPROXY expression support"
> +	depends on NF_CONNTRACK && NETFILTER_ADVANCED
> +	select NETFILTER_SYNPROXY
> +	select SYN_COOKIES
> +	help
> +	  The SYNPROXY expression allows you to intercept TCP connections and
> +	  establish them using syncookies before they are passed on to the
> +	  server. This allows to avoid conntrack and server resource usage
> +	  during SYN-flood attacks.
> +
>  if NF_TABLES_NETDEV
>  
>  config NF_DUP_NETDEV
> diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
> index 72cca6b48960..deada20975ff 100644
> --- a/net/netfilter/Makefile
> +++ b/net/netfilter/Makefile
> @@ -110,6 +110,7 @@ obj-$(CONFIG_NFT_SOCKET)	+= nft_socket.o
>  obj-$(CONFIG_NFT_OSF)		+= nft_osf.o
>  obj-$(CONFIG_NFT_TPROXY)	+= nft_tproxy.o
>  obj-$(CONFIG_NFT_XFRM)		+= nft_xfrm.o
> +obj-$(CONFIG_NFT_SYNPROXY)	+= nft_synproxy.o
>  
>  obj-$(CONFIG_NFT_NAT)		+= nft_chain_nat.o
>  
> diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
> new file mode 100644
> index 000000000000..e94e0a1c1722
> --- /dev/null
> +++ b/net/netfilter/nft_synproxy.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/types.h>
> +
> +#include <net/ip.h>
> +#include <net/tcp.h>
> +#include <net/netlink.h>
> +
> +#include <net/netfilter/nf_tables.h>
> +#include <net/netfilter/nf_conntrack.h>
> +#include <net/netfilter/nf_conntrack_ecache.h>
> +#include <net/netfilter/nf_conntrack_extend.h>
> +#include <net/netfilter/nf_conntrack_seqadj.h>
> +#include <net/netfilter/nf_conntrack_synproxy.h>
> +#include <net/netfilter/nf_synproxy.h>
> +
> +#include <linux/netfilter/nf_tables.h>
> +#include <linux/netfilter/nf_SYNPROXY.h>
> +
> +struct nft_synproxy {
> +	u16			mss;
> +	u8			wscale;
> +	u32			flags;
> +};

maybe...

   struct nft_synproxy {
        struct nf_synproxy_info info;
   };

> +static const struct nla_policy nft_synproxy_policy[NFTA_SYNPROXY_MAX + 1] = {
> +	[NFTA_SYNPROXY_MSS]		= { .type = NLA_U16 },
> +	[NFTA_SYNPROXY_WSCALE]		= { .type = NLA_U8 },
> +	[NFTA_SYNPROXY_FLAGS]		= { .type = NLA_U32 },
> +};
> +
> +static struct nf_synproxy_info create_synproxy_info(struct nft_synproxy *expr)

... so you can remove this helper function?

> +{
> +	struct nf_synproxy_info info;
> +
> +	info.options = expr->flags;
> +	info.wscale = expr->wscale;
> +	info.mss = expr->mss;
> +
> +	return info;
> +}
> +
> +static void nft_synproxy_eval_v4(const struct nft_expr *expr,
> +				 struct nft_regs *regs,
> +				 const struct nft_pktinfo *pkt)
> +{
> +	struct nft_synproxy *priv = nft_expr_priv(expr);
> +	struct nf_synproxy_info info = create_synproxy_info(priv);
> +	struct synproxy_options opts = {};
> +	struct net *net = nft_net(pkt);
> +	struct synproxy_net *snet = synproxy_pernet(net);
> +	struct sk_buff *skb = pkt->skb;
> +	int thoff = pkt->xt.thoff;
> +	const struct tcphdr *tcp;
> +	struct tcphdr _tcph;
> +
> +	if (nf_ip_checksum(skb, nft_hook(pkt), thoff, IPPROTO_TCP)) {
> +		regs->verdict.code = NF_DROP;
> +		return;
> +	}
> +
> +	tcp = skb_header_pointer(skb, ip_hdrlen(skb),
> +				 sizeof(struct tcphdr), &_tcph);
> +	if (!tcp) {
> +		regs->verdict.code = NF_DROP;
> +		return;
> +	}
> +	if (!synproxy_parse_options(skb, thoff, tcp, &opts)) {
> +		regs->verdict.code = NF_DROP;
> +		return;
> +	}
> +
> +	if (tcp->syn) {
> +		/* Initial SYN from client */
> +		this_cpu_inc(snet->stats->syn_received);
> +
> +		if (tcp->ece && tcp->cwr)
> +			opts.options |= NF_SYNPROXY_OPT_ECN;
> +
> +		opts.options &= priv->flags;
> +		if (opts.options & NF_SYNPROXY_OPT_TIMESTAMP)
> +			synproxy_init_timestamp_cookie(&info, &opts);
> +		else
> +			opts.options &= ~(NF_SYNPROXY_OPT_WSCALE |
> +					  NF_SYNPROXY_OPT_SACK_PERM |
> +					  NF_SYNPROXY_OPT_ECN);
> +
> +		synproxy_send_client_synack(net, skb, tcp, &opts);
> +		consume_skb(skb);
> +		regs->verdict.code = NF_STOLEN;
> +		return;
> +	} else if (tcp->ack) {
> +		/* ACK from client */
> +		if (synproxy_recv_client_ack(net, skb, tcp, &opts,
> +					     ntohl(tcp->seq))) {
> +			consume_skb(skb);
> +			regs->verdict.code = NF_STOLEN;
> +		} else {
> +			regs->verdict.code = NF_DROP;
> +		}
> +		return;
> +	}
> +
> +	regs->verdict.code = NFT_CONTINUE;
> +}
> +
> +#if IS_ENABLED(CONFIG_NF_TABLES_IPV6)
> +static void nft_synproxy_eval_v6(const struct nft_expr *expr,
> +				 struct nft_regs *regs,
> +				 const struct nft_pktinfo *pkt)
> +{
> +	struct nft_synproxy *priv = nft_expr_priv(expr);
> +	struct nf_synproxy_info info = create_synproxy_info(priv);
> +	struct synproxy_options opts = {};
> +	struct net *net = nft_net(pkt);
> +	struct synproxy_net *snet = synproxy_pernet(net);
> +	struct sk_buff *skb = pkt->skb;
> +	int thoff = pkt->xt.thoff;
> +	const struct tcphdr *tcp;
> +	struct tcphdr _tcph;
> +
> +	if (nf_ip_checksum(skb, nft_hook(pkt), thoff, IPPROTO_TCP)) {
> +		regs->verdict.code = NF_DROP;
> +		return;
> +	}
> +
> +	tcp = skb_header_pointer(skb, ip_hdrlen(skb),
> +				 sizeof(struct tcphdr), &_tcph);
> +	if (!tcp) {
> +		regs->verdict.code = NF_DROP;
> +		return;
> +	}
> +
> +	if (!synproxy_parse_options(skb, thoff, tcp, &opts)) {
> +		regs->verdict.code = NF_DROP;
> +		return;
> +	}
> +
> +	if (tcp->syn) {
> +		/* Initial SYN from client */
> +		this_cpu_inc(snet->stats->syn_received);
> +
> +		if (tcp->ece && tcp->cwr)
> +			opts.options |= NF_SYNPROXY_OPT_ECN;
> +
> +		opts.options &= priv->flags;
> +		if (opts.options & NF_SYNPROXY_OPT_TIMESTAMP)
> +			synproxy_init_timestamp_cookie(&info, &opts);
> +		else
> +			opts.options &= ~(NF_SYNPROXY_OPT_WSCALE |
> +					  NF_SYNPROXY_OPT_SACK_PERM |
> +					  NF_SYNPROXY_OPT_ECN);
> +
> +		synproxy_send_client_synack_ipv6(net, skb, tcp, &opts);
> +		consume_skb(skb);
> +		regs->verdict.code = NF_STOLEN;
> +		return;
> +	} else if (tcp->ack) {
> +		/* ACK from client */
> +		if (synproxy_recv_client_ack_ipv6(net, skb, tcp, &opts,
> +						  ntohl(tcp->seq))) {
> +			consume_skb(skb);
> +			regs->verdict.code = NF_STOLEN;
> +		} else {
> +			regs->verdict.code = NF_DROP;
> +		}
> +		return;
> +	}
> +
> +	regs->verdict.code = NFT_CONTINUE;
> +}
> +#endif /* IPv6 support */
> +
> +static void nft_synproxy_eval(const struct nft_expr *expr,
> +			      struct nft_regs *regs,
> +			      const struct nft_pktinfo *pkt)
> +{

You have to check if this is TCP traffic in first place, otherwise UDP
packets may enter this path :-).

> +	switch (nft_pf(pkt)) {
> +	case NFPROTO_IPV4:
> +		nft_synproxy_eval_v4(expr, regs, pkt);
> +		return;
> +#if IS_ENABLED(CONFIG_NF_TABLES_IPV6)
> +	case NFPROTO_IPV6:
> +		nft_synproxy_eval_v6(expr, regs, pkt);
> +		return;
> +#endif

Please, use skb->protocol instead of nft_pf(), I would like we can use
nft_synproxy from NFPROTO_NETDEV (ingress) and NFPROTO_BRIDGE families
too.

> +	}
> +	regs->verdict.code = NFT_BREAK;
> +}
> +
> +static int nft_synproxy_init(const struct nft_ctx *ctx,
> +			     const struct nft_expr *expr,
> +			     const struct nlattr * const tb[])
> +{
> +	struct synproxy_net *snet = synproxy_pernet(ctx->net);
> +	struct nft_synproxy *priv = nft_expr_priv(expr);
> +	u32 flags;
> +	int err;
> +
> +	err = nf_ct_netns_get(ctx->net, ctx->family);
> +	if (err)
> +		goto nf_ct_failure;
> +
> +	switch (ctx->family) {
> +	case NFPROTO_IPV4:
> +		err = nf_synproxy_ipv4_init(snet, ctx->net);
> +		if (err)
> +			goto nf_ct_failure;
> +		snet->hook_ref4++;
> +		break;
> +	case NFPROTO_IPV6:
> +		err = nf_synproxy_ipv6_init(snet, ctx->net);
> +		if (err)
> +			goto nf_ct_failure;
> +		snet->hook_ref6++;
> +		break;
> +	case NFPROTO_INET:

Add NFPROTO_BRIDGE here too, ie.

        case NFPROTO_INET:
        case NFPROTO_BRIDGE:

the code below will handle both cases: inet and bridge.

> +		err = nf_synproxy_ipv4_init(snet, ctx->net);
> +		if (err)
> +			goto nf_ct_failure;
> +		err = nf_synproxy_ipv6_init(snet, ctx->net);
> +		if (err)
> +			goto nf_ct_failure;
> +		snet->hook_ref4++;
> +		snet->hook_ref6++;
> +		break;
> +	}
> +
> +	if (tb[NFTA_SYNPROXY_MSS])
> +		priv->mss = ntohs(nla_get_be16(tb[NFTA_SYNPROXY_MSS]));
> +	if (tb[NFTA_SYNPROXY_WSCALE])
> +		priv->wscale = nla_get_u8(tb[NFTA_SYNPROXY_WSCALE]);
> +	if (tb[NFTA_SYNPROXY_FLAGS]) {
> +		flags = ntohl(nla_get_be32(tb[NFTA_SYNPROXY_FLAGS]));
> +		if (flags != 0 && (flags & NF_SYNPROXY_FLAGMASK) == 0)
> +			return -EINVAL;
> +		priv->flags = flags;
> +	}
> +	return 0;
> +
> +nf_ct_failure:
> +	nf_ct_netns_put(ctx->net, ctx->family);
> +	return err;
> +}
> +
> +static void nft_synproxy_destroy(const struct nft_ctx *ctx,
> +				 const struct nft_expr *expr)
> +{
> +	struct synproxy_net *snet = synproxy_pernet(ctx->net);
> +
> +	switch (ctx->family) {
> +	case NFPROTO_IPV4:
> +		nf_synproxy_ipv4_fini(snet, ctx->net);
> +		break;
> +	case NFPROTO_IPV6:
> +		nf_synproxy_ipv6_fini(snet, ctx->net);
> +		break;
> +	case NFPROTO_INET:
> +		nf_synproxy_ipv4_fini(snet, ctx->net);
> +		nf_synproxy_ipv6_fini(snet, ctx->net);
> +		break;
> +	}
> +	nf_ct_netns_put(ctx->net, ctx->family);
> +}
> +
> +static int nft_synproxy_dump(struct sk_buff *skb, const struct nft_expr *expr)
> +{
> +	const struct nft_synproxy *priv = nft_expr_priv(expr);
> +
> +	if (nla_put_be16(skb, NFTA_SYNPROXY_MSS, ntohs(priv->mss)))
> +		goto nla_put_failure;
> +
> +	if (nla_put_u8(skb, NFTA_SYNPROXY_WSCALE, priv->wscale))
> +		goto nla_put_failure;
> +
> +	if (nla_put_be32(skb, NFTA_SYNPROXY_FLAGS, ntohl(priv->flags)))

Probably:

	if (nla_put_be16(skb, NFTA_SYNPROXY_MSS, ntohs(priv->mss)) ||
            nla_put_u8(skb, NFTA_SYNPROXY_WSCALE, priv->wscale) ||
            nla_put_be32(skb, NFTA_SYNPROXY_FLAGS, ntohl(priv->flags)))
		goto nla_put_failure;

so we save a bit of LoC.

> +	return 0;
> +
> +nla_put_failure:
> +	return -1;
> +}
> +
> +static int nft_synproxy_validate(const struct nft_ctx *ctx,
> +				 const struct nft_expr *expr,
> +				 const struct nft_data **data)
> +{
> +	return nft_chain_validate_hooks(ctx->chain, (1 << NF_INET_LOCAL_IN) |
> +						    (1 << NF_INET_FORWARD));
> +}
> +
> +static struct nft_expr_type nft_synproxy_type;
> +static const struct nft_expr_ops nft_synproxy_ops = {
> +	.eval		= nft_synproxy_eval,
> +	.size		= NFT_EXPR_SIZE(sizeof(struct nft_synproxy)),
> +	.init		= nft_synproxy_init,
> +	.destroy	= nft_synproxy_destroy,
> +	.dump		= nft_synproxy_dump,
> +	.type		= &nft_synproxy_type,
> +	.validate	= nft_synproxy_validate,
> +};
> +
> +static struct nft_expr_type nft_synproxy_type __read_mostly = {
> +	.ops		= &nft_synproxy_ops,
> +	.name		= "synproxy",
> +	.owner		= THIS_MODULE,
> +	.policy		= nft_synproxy_policy,
> +	.maxattr	= NFTA_OSF_MAX,
> +};
> +
> +static int __init nft_synproxy_module_init(void)
> +{
> +	return nft_register_expr(&nft_synproxy_type);
> +}
> +
> +static void __exit nft_synproxy_module_exit(void)
> +{
> +	return nft_unregister_expr(&nft_synproxy_type);
> +}
> +
> +module_init(nft_synproxy_module_init);
> +module_exit(nft_synproxy_module_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Fernando Fernandez <ffmancera@riseup.net>");
> +MODULE_ALIAS_NFT_EXPR("synproxy");
> -- 
> 2.20.1
> 
