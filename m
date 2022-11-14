Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDF2628715
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Nov 2022 18:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiKNR3q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Nov 2022 12:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNR3p (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:29:45 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD50EA476
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Nov 2022 09:29:43 -0800 (PST)
Date:   Mon, 14 Nov 2022 18:29:40 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [nf-next RFC] netfilter: nf_tables: Compatibility interface for
 nft_rule
Message-ID: <Y3J7BD0hxG5BEMkz@salvia>
References: <20221104221827.30335-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221104221827.30335-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Phil,

Comments below.

On Fri, Nov 04, 2022 at 11:18:27PM +0100, Phil Sutter wrote:
> Accept extra expressions from user space which should replace active
> one(s) when the rule is being dumped. Each of those expressions
> specifies the index of the first expression to replace, the number of
> consecutive expressions it replaces and a blob of data to dump. While
> the latter should adhere to the expected NFTA_LIST_ELEM content format,
> the kernel actually treats it as opaque data and therefore may not even
> support the expression type being dumped.
> 
> The practical application of this is to enable iptables-nft to use
> native nftables expressions while still maintaining compatibility
> towards older versions not expecting (or correctly parsing) them.
> 
> Here's the effect in practice with a customized iptables-nft. First add
> a rule with two matches that had been converted already, netlink dump
> shows the native expressions used:
> 
> | # iptables-nft -vv -A FORWARD -m limit --limit 3/hour -m mark --mark 0x23/0x42
> |   all opt -- in * out *  0.0.0.0/0  -> 0.0.0.0/0   limit: avg 3/hour burst 5 mark match 0x23/0x42
> | table filter ip flags 0 use 0 handle 0
> | ip filter FORWARD use 0 type filter hook forward prio 0 policy accept packets 0 bytes 0
> | ip filter FORWARD
> |   [ limit rate 3/hour burst 5 type packets flags 0x0 ]
> |   [ meta load mark => reg 1 ]
> |   [ bitwise reg 1 = ( reg 1 & 0x00000042 ) ^ 0x00000000 ]
> |   [ cmp eq reg 1 0x00000023 ]
> |   [ counter pkts 0 bytes 0 ]
> 
> Listing the rule shows how the previously attached compat expressions
> replaced the native code in output:
> 
> | # iptables-nft -vv -S
> | ip filter FORWARD 2
> |   [ match name limit rev 0 ]
> |   [ match name mark rev 1 ]
> |   [ counter pkts 0 bytes 0 ]
> |
> | -P INPUT ACCEPT -c 0 0
> | -P FORWARD ACCEPT -c 0 0
> | -P OUTPUT ACCEPT -c 0 0
> | -A FORWARD -m limit --limit 3/hour -m mark --mark 0x23/0x42 -c 0 0
> 
> Note also how the rule is correctly interpreted since iptables-nft
> continues to support the legacy limit and mark match extensions.
> 
> This patch should have relatively low impact if not in use: struct
> nft_rule increases by one pointer which has to be checked upon dumping
> or freeing of the rule.
> 
> Disclaimer: This is not the much simpler "attach the rule as text" we
> discussed, but I would like to at least propose it since it works for
> existing releases.

I prefer this "structured" representation than resorting to using the
userdata area to store a string.

> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  include/net/netfilter/nf_tables.h        |   8 ++
>  include/uapi/linux/netfilter/nf_tables.h |  18 ++++
>  net/netfilter/nf_tables_api.c            | 129 ++++++++++++++++++++++-
>  3 files changed, 153 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
> index cdb7db9b0e252..cf00753b1446e 100644
> --- a/include/net/netfilter/nf_tables.h
> +++ b/include/net/netfilter/nf_tables.h
> @@ -939,6 +939,13 @@ struct nft_expr_ops {
>  	void				*data;
>  };
>  
> +struct nft_compat_expr {
> +        int pos;
> +        int len;
> +        int dlen;
> +        void *data;
> +};
> +
>  /**
>   *	struct nft_rule - nf_tables rule
>   *
> @@ -951,6 +958,7 @@ struct nft_expr_ops {
>   */
>  struct nft_rule {
>  	struct list_head		list;
> +	struct nft_compat_expr		*compat_exprs;
>  	u64				handle:42,
>  					genmask:2,
>  					dlen:12,
> diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
> index 466fd3f4447c2..c8c0f1b2bd395 100644
> --- a/include/uapi/linux/netfilter/nf_tables.h
> +++ b/include/uapi/linux/netfilter/nf_tables.h
> @@ -278,15 +278,33 @@ enum nft_rule_compat_flags {
>   *
>   * @NFTA_RULE_COMPAT_PROTO: numeric value of handled protocol (NLA_U32)
>   * @NFTA_RULE_COMPAT_FLAGS: bitmask of enum nft_rule_compat_flags (NLA_U32)
> + * @NFTA_RULE_COMPAT_EXPRESSIONS: Replacement expressions in dumps (NLA_NESTED)
>   */
>  enum nft_rule_compat_attributes {
>  	NFTA_RULE_COMPAT_UNSPEC,
>  	NFTA_RULE_COMPAT_PROTO,
>  	NFTA_RULE_COMPAT_FLAGS,
> +	NFTA_RULE_COMPAT_EXPRESSIONS,
>  	__NFTA_RULE_COMPAT_MAX
>  };
>  #define NFTA_RULE_COMPAT_MAX	(__NFTA_RULE_COMPAT_MAX - 1)
>  
> +/**
> + * enum nft_rule_compat_expression - compat expression data
> + *
> + * @NFTA_RULE_COMPAT_EXPR_POS: index of expression this replaces (NLA_U32)
> + * @NFTA_RULE_COMPAT_EXPR_LEN: number of expressions this replaces (NLA_U32)
> + * @NFTA_RULE_COMPAT_EXPR_INFO: expression blob to dump (NLA_BINARY)
> + */
> +enum nft_rule_compat_expression {
> +	NFTA_RULE_COMPAT_EXPR_UNSPEC,
> +	NFTA_RULE_COMPAT_EXPR_POS,
> +	NFTA_RULE_COMPAT_EXPR_LEN,
> +	NFTA_RULE_COMPAT_EXPR_INFO,
> +	__NFTA_RULE_COMPAT_EXPR_MAX
> +};

Is this extra metainformation really required? I mean, this position
and length mapping wrt. native representation.

Why not simply use the NFTA_RULE_COMPAT_EXPRESSIONS to dump the rule
fully using the xt blobs instead?

That is, the rule is expressed using native expressions, but the
original output using the blob dump is also available.

> +#define NFTA_RULE_COMPAT_EXPR_MAX	(__NFTA_RULE_COMPAT_EXPR_MAX - 1)
> +
>  /**
>   * enum nft_set_flags - nf_tables set flags
>   *
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index a0653a8dfa827..3a867a52bc3ad 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -16,6 +16,7 @@
>  #include <linux/netfilter.h>
>  #include <linux/netfilter/nfnetlink.h>
>  #include <linux/netfilter/nf_tables.h>
> +#include <linux/netfilter/nf_tables_compat.h>
>  #include <net/netfilter/nf_flow_table.h>
>  #include <net/netfilter/nf_tables_core.h>
>  #include <net/netfilter/nf_tables.h>
> @@ -2992,6 +2993,36 @@ static const struct nla_policy nft_rule_policy[NFTA_RULE_MAX + 1] = {
>  	[NFTA_RULE_CHAIN_ID]	= { .type = NLA_U32 },
>  };
>  
> +static int nft_rule_dump_compat_exprs(struct sk_buff *skb,
> +				      const struct nft_rule *rule)
> +{
> +	const struct nft_compat_expr *cur = rule->compat_exprs;
> +	const struct nft_expr *expr, *next;
> +	int expr_idx = -1, skip = 0;
> +
> +	nft_rule_for_each_expr(expr, next, rule) {
> +		expr_idx++;
> +
> +		if (skip) {
> +			skip--;
> +			continue;
> +		}
> +
> +		if (!cur->len || expr_idx != cur->pos) {
> +			if (nft_expr_dump(skb, NFTA_LIST_ELEM, expr) < 0)
> +				return -1;
> +			continue;
> +		}
> +
> +		if (nla_put(skb, NFTA_LIST_ELEM, cur->dlen, cur->data) < 0)
> +			return -1;
> +
> +		skip = cur->len - 1;
> +		cur++;
> +	}
> +	return 0;
> +}
> +
>  static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
>  				    u32 portid, u32 seq, int event,
>  				    u32 flags, int family,
> @@ -3029,9 +3060,14 @@ static int nf_tables_fill_rule_info(struct sk_buff *skb, struct net *net,
>  	list = nla_nest_start_noflag(skb, NFTA_RULE_EXPRESSIONS);
>  	if (list == NULL)
>  		goto nla_put_failure;
> -	nft_rule_for_each_expr(expr, next, rule) {
> -		if (nft_expr_dump(skb, NFTA_LIST_ELEM, expr) < 0)
> +	if (rule->compat_exprs) {
> +		if (nft_rule_dump_compat_exprs(skb, rule) < 0)
>  			goto nla_put_failure;
> +	} else {
> +		nft_rule_for_each_expr(expr, next, rule) {
> +			if (nft_expr_dump(skb, NFTA_LIST_ELEM, expr) < 0)
> +				goto nla_put_failure;
> +		}
>  	}

Instead of one-or-another, dump both native and xt representation?

So userspace can fall back to use compat_exprs if it fails to decode
the native representation?

>  	nla_nest_end(skb, list);
>  
> @@ -3318,6 +3354,15 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
>  		nf_tables_expr_destroy(ctx, expr);
>  		expr = next;
>  	}
> +	if (rule->compat_exprs) {
> +		struct nft_compat_expr *cur = rule->compat_exprs;
> +
> +		while (cur->len) {
> +			kfree(cur->data);
> +			cur++;
> +		}
> +		kfree(rule->compat_exprs);
> +	}
>  	kfree(rule);
>  }
>  
> @@ -3385,12 +3430,83 @@ static struct nft_rule *nft_rule_lookup_byid(const struct net *net,
>  
>  #define NFT_RULE_MAXEXPRS	128
>  
> +static const struct nla_policy
> +nft_rule_compat_expression_policy[NFTA_RULE_COMPAT_EXPR_MAX + 1] = {
> +	[NFTA_RULE_COMPAT_EXPR_POS]	= { .type = NLA_U32 },
> +	[NFTA_RULE_COMPAT_EXPR_LEN]	= { .type = NLA_U32 },
> +	[NFTA_RULE_COMPAT_EXPR_INFO]	= { .type = NLA_BINARY },
> +};
> +
> +static struct nft_compat_expr *
> +nft_parse_compat_exprs_nla(const struct nlattr *nla)
> +{
> +	struct nft_compat_expr *compat_exprs, *cur;
> +	int idx = 0, num_exprs = 0;
> +	struct nlattr *tmp;
> +	int err, rem;
> +
> +	nla = nla_find_nested(nla, NFTA_RULE_COMPAT_EXPRESSIONS);
> +	if (!nla)
> +		return NULL;
> +
> +	nla_for_each_nested(tmp, nla, rem)
> +		num_exprs++;
> +
> +	if (!num_exprs)
> +		return NULL;
> +
> +	compat_exprs = kvmalloc_array(num_exprs + 1,
> +				      sizeof(*compat_exprs), GFP_KERNEL);
> +	if (!compat_exprs)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cur = compat_exprs;
> +	nla_for_each_nested(tmp, nla, rem) {
> +		struct nlattr *tb[NFTA_RULE_COMPAT_EXPR_MAX + 1];
> +		int err;
> +
> +		if (idx >= NFT_RULE_MAXEXPRS)
> +			return ERR_PTR(-ENOMEM);
> +
> +		err = nla_parse_nested_deprecated(tb, NFTA_RULE_COMPAT_EXPR_MAX,
> +						  tmp, nft_rule_compat_expression_policy, NULL);
> +		if (err < 0)
> +			return ERR_PTR(err);
> +
> +		if (!tb[NFTA_RULE_COMPAT_EXPR_POS] ||
> +		    !tb[NFTA_RULE_COMPAT_EXPR_LEN] ||
> +		    !tb[NFTA_RULE_COMPAT_EXPR_INFO]) {
> +			err = -EINVAL;
> +			goto out_free;
> +		}
> +
> +		cur->pos = nla_get_u32(tb[NFTA_RULE_COMPAT_EXPR_POS]);
> +		cur->len = nla_get_u32(tb[NFTA_RULE_COMPAT_EXPR_LEN]);
> +		cur->dlen = nla_len(tb[NFTA_RULE_COMPAT_EXPR_INFO]);
> +		cur->data = kvmalloc(cur->dlen, GFP_KERNEL);
> +		if (!cur->data) {
> +			err = -ENOMEM;
> +			goto out_free;
> +		}
> +
> +		nla_memcpy(cur->data,
> +			   tb[NFTA_RULE_COMPAT_EXPR_INFO], cur->dlen);
> +		cur++;
> +	}
> +	cur->len = 0;
> +	return compat_exprs;
> +out_free:
> +	kfree(compat_exprs);
> +	return ERR_PTR(err);
> +}

Probably move this code to nft_compat.c?
