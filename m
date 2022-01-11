Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4626B48AD01
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Jan 2022 12:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiAKLwO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Jan 2022 06:52:14 -0500
Received: from mail.netfilter.org ([217.70.188.207]:46140 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbiAKLwM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:52:12 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 752B5605C6;
        Tue, 11 Jan 2022 12:49:18 +0100 (CET)
Date:   Tue, 11 Jan 2022 12:52:05 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, Yi Chen <yiche@redhat.com>
Subject: Re: [PATCH nft] evaluate: attempt to set_eval flag if dynamic
 updates requested
Message-ID: <Yd1vZdw0nV1ArMhj@salvia>
References: <20220111113531.4849-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220111113531.4849-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jan 11, 2022 at 12:35:31PM +0100, Florian Westphal wrote:
> When passing no upper size limit, the dynset expression forces
> an internal 64k upperlimit.
> 
> In some cases, this can result in 'nft -f' to restore the ruleset.
> Avoid this by always setting the EVAL flag on a set definition when
> we encounter packet-path update attempt in the batch.

LGTM.

> Reported-by: Yi Chen <yiche@redhat.com>
> Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  src/evaluate.c                                | 10 ++++++
>  .../testcases/sets/dumps/dynset_missing.nft   | 12 +++++++
>  tests/shell/testcases/sets/dynset_missing     | 32 +++++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100644 tests/shell/testcases/sets/dumps/dynset_missing.nft
>  create mode 100755 tests/shell/testcases/sets/dynset_missing
> 
> diff --git a/src/evaluate.c b/src/evaluate.c
> index 8edefbd1be21..437eacb8209f 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
> @@ -3621,6 +3621,7 @@ static int stmt_evaluate_log(struct eval_ctx *ctx, struct stmt *stmt)
>  
>  static int stmt_evaluate_set(struct eval_ctx *ctx, struct stmt *stmt)
>  {
> +	struct set *this_set;
>  	struct stmt *this;
>  
>  	expr_set_context(&ctx->ectx, NULL, 0);
> @@ -3650,6 +3651,15 @@ static int stmt_evaluate_set(struct eval_ctx *ctx, struct stmt *stmt)
>  					  "statement must be stateful");
>  	}
>  
> +	this_set = stmt->set.set->set;
> +
> +	/* Make sure EVAL flag is set on set definition so that kernel
> +	 * picks a set that allows updates from the packet path.
> +	 *
> +	 * Alternatively we could error out in case 'flags dynamic' was
> +	 * not given, but we can repair this here.
> +	 */
> +	this_set->flags |= NFT_SET_EVAL;
>  	return 0;
>  }
>  
> diff --git a/tests/shell/testcases/sets/dumps/dynset_missing.nft b/tests/shell/testcases/sets/dumps/dynset_missing.nft
> new file mode 100644
> index 000000000000..6c8ed323bdc9
> --- /dev/null
> +++ b/tests/shell/testcases/sets/dumps/dynset_missing.nft
> @@ -0,0 +1,12 @@
> +table ip test {
> +	set dlist {
> +		type ipv4_addr
> +		size 65535
> +		flags dynamic
> +	}
> +
> +	chain output {
> +		type filter hook output priority filter; policy accept;
> +		udp dport 1234 update @dlist { ip daddr } counter packets 0 bytes 0
> +	}
> +}
> diff --git a/tests/shell/testcases/sets/dynset_missing b/tests/shell/testcases/sets/dynset_missing
> new file mode 100755
> index 000000000000..fdf5f49edb9c
> --- /dev/null
> +++ b/tests/shell/testcases/sets/dynset_missing
> @@ -0,0 +1,32 @@
> +#!/bin/bash
> +
> +set -e
> +
> +$NFT -f /dev/stdin <<EOF
> +table ip test {
> +	chain output { type filter hook output priority 0;
> +	}
> +}
> +EOF
> +
> +# misses 'flags dynamic'
> +$NFT 'add set ip test dlist {type ipv4_addr; }'
> +
> +# picks rhash backend because 'size' was also missing.
> +$NFT 'add rule ip test output udp dport 1234 update @dlist { ip daddr } counter'
> +
> +tmpfile=$(mktemp)
> +
> +trap "rm -rf $tmpfile" EXIT
> +
> +# kernel has forced an 64k upper size, i.e. this restore file
> +# has 'size 65536' but no 'flags dynamic'.
> +$NFT list ruleset > $tmpfile
> +
> +# this restore works, because set is still the rhash backend.
> +$NFT -f $tmpfile # success
> +$NFT flush ruleset
> +
> +# fails without commit 'attempt to set_eval flag if dynamic updates requested',
> +# because set in $tmpfile has 'size x' but no 'flags dynamic'.
> +$NFT -f $tmpfile
> -- 
> 2.34.1
> 
