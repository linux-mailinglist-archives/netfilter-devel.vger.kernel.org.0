Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C544AC84D
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Feb 2022 19:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiBGSKb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Feb 2022 13:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378369AbiBGSCl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:02:41 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08031C0401E0
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Feb 2022 10:02:41 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4D639601C0;
        Mon,  7 Feb 2022 19:02:36 +0100 (CET)
Date:   Mon, 7 Feb 2022 19:02:37 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/2] nft: Use verbose flag to toggle debug output
Message-ID: <YgFevUBNBFagWjMx@salvia>
References: <20220128203700.27071-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128203700.27071-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jan 28, 2022 at 09:36:59PM +0100, Phil Sutter wrote:
> Copy legacy iptables' behaviour, printing debug output if verbose flag
> is given more than once.
> 
> Since nft debug output applies to netlink messages which are not created
> until nft_action() phase, carrying verbose value is non-trivial -
> introduce a field in struct nft_handle for that.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  iptables/nft-shared.h |  1 -
>  iptables/nft.c        | 38 ++++++++++++++++++++------------------
>  iptables/nft.h        |  1 +
>  iptables/xtables.c    |  1 +
>  4 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
> index c3241f4b8c726..d4222ae05adc3 100644
> --- a/iptables/nft-shared.h
> +++ b/iptables/nft-shared.h
> @@ -13,7 +13,6 @@
>  #include "xshared.h"
>  
>  #ifdef DEBUG
> -#define NLDEBUG
>  #define DEBUG_DEL
>  #endif
>  
> diff --git a/iptables/nft.c b/iptables/nft.c
> index b5de687c5c4cd..ae41384fe8180 100644
> --- a/iptables/nft.c
> +++ b/iptables/nft.c
> @@ -926,15 +926,16 @@ void nft_fini(struct nft_handle *h)
>  	mnl_socket_close(h->nl);
>  }
>  
> -static void nft_chain_print_debug(struct nftnl_chain *c, struct nlmsghdr *nlh)
> +static void nft_chain_print_debug(struct nft_handle *h,
> +				  struct nftnl_chain *c, struct nlmsghdr *nlh)
>  {
> -#ifdef NLDEBUG
> -	char tmp[1024];
> -
> -	nftnl_chain_snprintf(tmp, sizeof(tmp), c, 0, 0);
> -	printf("DEBUG: chain: %s\n", tmp);
> -	mnl_nlmsg_fprintf(stdout, nlh, nlh->nlmsg_len, sizeof(struct nfgenmsg));
> -#endif
> +	if (h->verbose > 1) {
> +		nftnl_chain_fprintf(stdout, c, 0, 0);
> +		fprintf(stdout, "\n");
> +	}
> +	if (h->verbose > 2)
> +		mnl_nlmsg_fprintf(stdout, nlh, nlh->nlmsg_len,
> +				  sizeof(struct nfgenmsg));

OK, so -v is netlink byte printing and -vv means print netlink message
too. LGTM.

I'd mention this in the commit description before applying.

>  }
>  
>  static struct nftnl_chain *nft_chain_new(struct nft_handle *h,
> @@ -1386,15 +1387,16 @@ int add_log(struct nftnl_rule *r, struct iptables_command_state *cs)
>  	return 0;
>  }
>  
> -static void nft_rule_print_debug(struct nftnl_rule *r, struct nlmsghdr *nlh)
> +static void nft_rule_print_debug(struct nft_handle *h,
> +				 struct nftnl_rule *r, struct nlmsghdr *nlh)
>  {
> -#ifdef NLDEBUG
> -	char tmp[1024];
> -
> -	nftnl_rule_snprintf(tmp, sizeof(tmp), r, 0, 0);
> -	printf("DEBUG: rule: %s\n", tmp);
> -	mnl_nlmsg_fprintf(stdout, nlh, nlh->nlmsg_len, sizeof(struct nfgenmsg));
> -#endif
> +	if (h->verbose > 1) {
> +		nftnl_rule_fprintf(stdout, r, 0, 0);
> +		fprintf(stdout, "\n");
> +	}
> +	if (h->verbose > 2)
> +		mnl_nlmsg_fprintf(stdout, nlh, nlh->nlmsg_len,
> +				  sizeof(struct nfgenmsg));
>  }
>  
>  int add_counters(struct nftnl_rule *r, uint64_t packets, uint64_t bytes)
> @@ -2698,7 +2700,7 @@ static void nft_compat_chain_batch_add(struct nft_handle *h, uint16_t type,
>  	nlh = nftnl_chain_nlmsg_build_hdr(nftnl_batch_buffer(h->batch),
>  					type, h->family, flags, seq);
>  	nftnl_chain_nlmsg_build_payload(nlh, chain);
> -	nft_chain_print_debug(chain, nlh);
> +	nft_chain_print_debug(h, chain, nlh);
>  }
>  
>  static void nft_compat_rule_batch_add(struct nft_handle *h, uint16_t type,
> @@ -2710,7 +2712,7 @@ static void nft_compat_rule_batch_add(struct nft_handle *h, uint16_t type,
>  	nlh = nftnl_rule_nlmsg_build_hdr(nftnl_batch_buffer(h->batch),
>  				       type, h->family, flags, seq);
>  	nftnl_rule_nlmsg_build_payload(nlh, rule);
> -	nft_rule_print_debug(rule, nlh);
> +	nft_rule_print_debug(h, rule, nlh);
>  }
>  
>  static void batch_obj_del(struct nft_handle *h, struct obj_update *o)
> diff --git a/iptables/nft.h b/iptables/nft.h
> index 4c78f761e1c4b..fd116c2e3e198 100644
> --- a/iptables/nft.h
> +++ b/iptables/nft.h
> @@ -109,6 +109,7 @@ struct nft_handle {
>  	int8_t			config_done;
>  	struct list_head	cmd_list;
>  	bool			cache_init;
> +	int			verbose;
>  
>  	/* meta data, for error reporting */
>  	struct {
> diff --git a/iptables/xtables.c b/iptables/xtables.c
> index 051d5c7b7f98b..c44b39acdcd97 100644
> --- a/iptables/xtables.c
> +++ b/iptables/xtables.c
> @@ -163,6 +163,7 @@ int do_commandx(struct nft_handle *h, int argc, char *argv[], char **table,
>  		h->ops->init_cs(&cs);
>  
>  	do_parse(argc, argv, &p, &cs, &args);
> +	h->verbose = p.verbose;
>  
>  	if (!nft_table_builtin_find(h, p.table))
>  		xtables_error(VERSION_PROBLEM,
> -- 
> 2.34.1
> 
