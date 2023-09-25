Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CA17AD65E
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Sep 2023 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjIYKss (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Sep 2023 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjIYKsq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:48:46 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4EFF
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Sep 2023 03:48:39 -0700 (PDT)
Received: from [78.30.34.192] (port=43048 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qkj8m-00Fviq-5f; Mon, 25 Sep 2023 12:48:38 +0200
Date:   Mon, 25 Sep 2023 12:48:35 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf PATCH 2/5] netfilter: nf_tables: Add locking for
 NFT_MSG_GETRULE_RESET requests
Message-ID: <ZRFlgxT2cSoo0QjX@calendula>
References: <20230923013807.11398-1-phil@nwl.cc>
 <20230923013807.11398-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923013807.11398-3-phil@nwl.cc>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Sep 23, 2023 at 03:38:04AM +0200, Phil Sutter wrote:
[...]
> +static int nf_tables_getrule_reset(struct sk_buff *skb,
> +				   const struct nfnl_info *info,
> +				   const struct nlattr * const nla[])
> +{
> +	struct nftables_pernet *nft_net = nft_pernet(info->net);
> +	u8 family = info->nfmsg->nfgen_family;
> +	u32 portid = NETLINK_CB(skb).portid;
> +	char *tablename, *buf;
> +	struct sk_buff *skb2;
> +
> +	if (info->nlh->nlmsg_flags & NLM_F_DUMP) {
> +		struct netlink_dump_control c = {
> +			.start= nf_tables_dumpreset_rules_start,
> +			.dump = nf_tables_dumpreset_rules,
> +			.done = nf_tables_dump_rules_done,
> +			.module = THIS_MODULE,
> +			.data = (void *)nla,
> +		};
> +
> +		return nft_netlink_dump_start_rcu(info->sk, skb, info->nlh, &c);
> +	}
> +
> +	if (!nla[NFTA_RULE_TABLE])
> +		return -EINVAL;
> +
> +	tablename = nla_strdup(nla[NFTA_RULE_TABLE], GFP_ATOMIC);
> +	if (!tablename)
> +		return -ENOMEM;
> +
> +	spin_lock(&nft_net->reset_lock);
> +	skb2 = nf_tables_getrule_single(portid, info, nla, true);
> +	spin_unlock(&nft_net->reset_lock);
> +	if (IS_ERR(skb2))

This leaks tablename?

> +		return PTR_ERR(skb2);
> +
> +	buf = kasprintf(GFP_ATOMIC, "%s:%u", tablename, nft_net->base_seq);
> +	audit_log_nfcfg(buf, family, 1, AUDIT_NFT_OP_RULE_RESET, GFP_ATOMIC);
> +	kfree(buf);
> +	kfree(tablename);
> +
> +	return nfnetlink_unicast(skb2, info->net, portid);
>  }
>  
>  void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
