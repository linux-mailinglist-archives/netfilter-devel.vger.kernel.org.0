Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BAB48F7D1
	for <lists+netfilter-devel@lfdr.de>; Sat, 15 Jan 2022 17:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiAOQ2R (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 15 Jan 2022 11:28:17 -0500
Received: from mail.netfilter.org ([217.70.188.207]:56890 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiAOQ2R (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:28:17 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7FEE36070C;
        Sat, 15 Jan 2022 17:25:22 +0100 (CET)
Date:   Sat, 15 Jan 2022 17:28:12 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] nft-shared: support native tcp port delinearize
Message-ID: <YeL2HLW+EpJPXII7@salvia>
References: <20220115150316.14503-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220115150316.14503-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jan 15, 2022 at 04:03:16PM +0100, Florian Westphal wrote:
> This extends iptables-nft dissector to decode native tcp
> port matching.  nft ruleset:
> 
> table ip filter {
>         chain INPUT {
>                 type filter hook input priority filter; policy accept;
>                 tcp sport 12345
>                 tcp sport 12345 tcp dport 6789
>                 tcp sport < 1024
>                 tcp dport >= 1024
>         }
> }
> 
> $ iptables-nft-save
> -A INPUT -p tcp -m tcp --sport 12345
> -A INPUT -p tcp -m tcp --sport 12345 --dport 6789
> -A INPUT -p tcp -m tcp --sport 0:1023
> -A INPUT -p tcp -m tcp --dport 1024:65535

You can probably use the range expression, it has been there already
for quite some time and it is slightly more efficient than two cmp
expressions. nft still uses cmp for ranges for backward compatibility
reasons (range support is available since 4.9 and -stable 4.4 enters
EOL next month apparently), it only uses range for tcp dport != 0-1023.

> This would allow to extend iptables-nft to prefer
> native payload expressions for --sport,dport in the future.

Using the native payload for transport in the near future sounds a
good idea to me.

> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  iptables/nft-shared.c | 161 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 160 insertions(+), 1 deletion(-)
> 
> diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
> index 4394e8b7c4e8..f027c1b282ab 100644
> --- a/iptables/nft-shared.c
> +++ b/iptables/nft-shared.c
> @@ -466,6 +466,154 @@ static void nft_parse_bitwise(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
>  	ctx->flags |= NFT_XT_CTX_BITWISE;
>  }
>  
> +static struct xtables_match *
> +nft_create_match(struct nft_xt_ctx *ctx,
> +		 struct iptables_command_state *cs,
> +		 const char *name)
> +{
> +	struct xtables_match *match;
> +	struct xt_entry_match *m;
> +	unsigned int size;
> +
> +	match = xtables_find_match(name, XTF_TRY_LOAD,
> +				   &cs->matches);
> +	if (!match)
> +		return NULL;
> +
> +	size = XT_ALIGN(sizeof(struct xt_entry_match)) + match->size;
> +	m = xtables_calloc(1, size);
> +	m->u.match_size = size;
> +	m->u.user.revision = match->revision;
> +
> +	strcpy(m->u.user.name, match->name);
> +	match->m = m;
> +
> +	xs_init_match(match);
> +
> +	return match;
> +}
> +
> +static void nft_complete_tcp(struct nft_xt_ctx *ctx,
> +			     struct iptables_command_state *cs,
> +			     int sport, int dport,
> +			     uint8_t op)
> +{
> +	struct xtables_match *match;
> +	struct xt_tcp *tcp;
> +
> +	match = nft_create_match(ctx, cs, "tcp");
> +	if (!match)
> +		return;
> +
> +	tcp = (void*)match->m->data;
> +	if (sport >= 0) {
> +		switch (op) {
> +		case NFT_CMP_NEQ:
> +			tcp->invflags |= XT_TCP_INV_SRCPT;
> +			/* fallthrough */
> +		case NFT_CMP_EQ:
> +			tcp->spts[0] = sport;
> +			tcp->spts[1] = sport;
> +			break;
> +		case NFT_CMP_LT:
> +			tcp->spts[1] = sport > 1 ? sport - 1 : 1;
> +			break;
> +		case NFT_CMP_LTE:
> +			tcp->spts[1] = sport;
> +			break;
> +		case NFT_CMP_GT:
> +			tcp->spts[0] = sport < 0xffff ? sport + 1 : 0xffff;
> +			break;
> +		case NFT_CMP_GTE:
> +			tcp->spts[0] = sport;
> +			break;
> +		}
> +	}
> +
> +	if (dport >= 0) {
> +		switch (op) {
> +		case NFT_CMP_NEQ:
> +			tcp->invflags |= XT_TCP_INV_DSTPT;
> +			/* fallthrough */
> +		case NFT_CMP_EQ:
> +			tcp->dpts[0] = dport;
> +			tcp->dpts[1] = dport;
> +			break;
> +		case NFT_CMP_LT:
> +			tcp->dpts[1] = dport > 1 ? dport - 1 : 1;
> +			break;
> +		case NFT_CMP_LTE:
> +			tcp->dpts[1] = dport;
> +			break;
> +		case NFT_CMP_GT:
> +			tcp->dpts[0] = dport < 0xffff ? dport + 1 : 0xffff;
> +			break;
> +		case NFT_CMP_GTE:
> +			tcp->dpts[0] = dport;
> +			break;
> +		}
> +	}
> +}
> +
> +static void nft_complete_th_port(struct nft_xt_ctx *ctx,
> +				 struct iptables_command_state *cs,
> +				 uint8_t proto,
> +				 int sport, int dport, uint8_t op)
> +{
> +	switch (proto) {
> +	case IPPROTO_TCP:
> +		nft_complete_tcp(ctx, cs, sport, dport, op);
> +		break;
> +	}
> +}
> +
> +static void nft_complete_transport(struct nft_xt_ctx *ctx,
> +				   struct nftnl_expr *e, void *data)
> +{
> +	struct iptables_command_state *cs = data;
> +	uint32_t sdport;
> +	uint16_t port;
> +	uint8_t proto, op;
> +	unsigned int len;
> +
> +	switch (ctx->h->family) {
> +	case NFPROTO_IPV4:
> +		proto = ctx->cs->fw.ip.proto;
> +		break;
> +	case NFPROTO_IPV6:
> +		proto = ctx->cs->fw6.ipv6.proto;
> +		break;
> +	default:
> +		proto = 0;
> +		break;
> +	}
> +
> +	nftnl_expr_get(e, NFTNL_EXPR_CMP_DATA, &len);
> +	op = nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_OP);
> +
> +	switch(ctx->payload.offset) {
> +	case 0:
> +		switch (len) {
> +		case 2:
> +			port = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_CMP_DATA));
> +			nft_complete_th_port(ctx, cs, proto, port, -1, op);
> +			return;
> +		case 4:
> +			sdport = ntohl(nftnl_expr_get_u32(e, NFTNL_EXPR_CMP_DATA));
> +			nft_complete_th_port(ctx, cs, proto, sdport >> 16, sdport & 0xffff, op);
> +			return;
> +		}
> +		break;
> +	case 2:
> +		switch (len) {
> +		case 2:
> +			port = ntohs(nftnl_expr_get_u16(e, NFTNL_EXPR_CMP_DATA));
> +			nft_complete_th_port(ctx, cs, proto, -1, port, op);
> +			return;
> +		}
> +	}
> +}
> +
>  static void nft_parse_cmp(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
>  {
>  	void *data = ctx->cs;
> @@ -481,7 +629,18 @@ static void nft_parse_cmp(struct nft_xt_ctx *ctx, struct nftnl_expr *e)
>  	}
>  	/* bitwise context is interpreted from payload */
>  	if (ctx->flags & NFT_XT_CTX_PAYLOAD) {
> -		ctx->h->ops->parse_payload(ctx, e, data);
> +		switch (ctx->payload.base) {
> +		case NFT_PAYLOAD_LL_HEADER:
> +			if (ctx->h->family == NFPROTO_BRIDGE)
> +				ctx->h->ops->parse_payload(ctx, e, data);
> +			break;
> +		case NFT_PAYLOAD_NETWORK_HEADER:
> +			ctx->h->ops->parse_payload(ctx, e, data);
> +			break;
> +		case NFT_PAYLOAD_TRANSPORT_HEADER:
> +			nft_complete_transport(ctx, e, data);
> +			break;
> +		}
>  		ctx->flags &= ~NFT_XT_CTX_PAYLOAD;
>  	}
>  }
> -- 
> 2.34.1
> 
