Return-Path: <netfilter-devel+bounces-5885-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B1A21377
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jan 2025 22:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA151623C0
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jan 2025 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996981DF25E;
	Tue, 28 Jan 2025 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="GxEtwT0A";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="BziDcorS"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF71DE4E0
	for <netfilter-devel@vger.kernel.org>; Tue, 28 Jan 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738098387; cv=none; b=GTXjM1XJ49FPW7rLcXVag8Ky8DMtqUmMcdGADGlWo4uVAj3H2OpftWkZILL+j2fVJ67vE8n6RvzXfsRg6gNJ70MUCOuQYONsC62WrMCdlBBuNhqR+fHgEF6i9nDjJcgIoEPX+wDZd1P61bHecr96Kil8zAB+30oPEhUvLM47fiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738098387; c=relaxed/simple;
	bh=H4gGqvC1C+dj2+5jT5NNEHkiHklwh+G4GNlUd8vUZcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A10knPOvtvNYYp/ehAjuZdUzoa5GX4tZexY01MsmaA94oIcPZ19nul2hPuIVJ9cO+N3v0MQdv0hFSkULX/1JArppq7RQG0T9CTMhCceD8yZi20Qbrm2lgc9f6rRWD1vbVcCJPVoagEeq693Jr8bIaCd9tv0jHpNNFHjwHvp44eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=GxEtwT0A; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=BziDcorS; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 21804602A0; Tue, 28 Jan 2025 22:06:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1738098382;
	bh=vv98bUkDQ8JHd37lOmO1Mfb54iO6ktVhnAGI3/bPMC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxEtwT0AcX2JjxxY/Ys/8Fx/y8R7pbQC8uR+W6pOYcFWpfq8Y+iuhH4R8ETRMi/WP
	 pNsxIdGgP+OybMrcTLO2Hao2UfnH/Up9OhGln7htMGMLz+phCDf8J/rIytr1mZbU3V
	 rND6+/OxCJ6GbbUXOafZacQoC+lW1AR01snbKC5UUaRaH3OGVLMn5BuBBWkxzI3FvR
	 XKcEOHu2Cv0Opqg73XIlB73T7jleY5gF/v+jnr37A/0SWQDMx7m4cdLqijatJrpMP6
	 9FvL0xmu4waZ5/MqADrRHOXAyi4dQAMIgcOqFPbkSs3Sok49aQaQw8Cm6jckr1SoxV
	 6vdMl7WJAt+PA==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id B938E60287;
	Tue, 28 Jan 2025 22:06:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1738098380;
	bh=vv98bUkDQ8JHd37lOmO1Mfb54iO6ktVhnAGI3/bPMC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BziDcorSj4+8AwhZAjsU8zDaBOS4vfUVA9jNT6NmstJb+cZwwzfwWbckMJbZZ+qYQ
	 CZE3nPG6aS+WnWI+w4egVoqcIrx03c5hkxkuI/p20hbe8Z9TWyvw7g5UV8GaO6O94A
	 N6qWUFgJi31XEfO0l8XIlFX4SNTu5ibO1I9nggroE3xjbpqdV8Agno7zt9Y2F3iNN4
	 IA9xMyaSr5Otod7xlnb1KWpPu2wWi9w9muROrt6LVSfNiyNsao/AxRmcMLsg6AQkKC
	 GHFsrlZPc7lnzyKCv30DOdKJeGfKRIR0gFRJpx3v7bF1kz2OG4/IufhV8Ep/GaC6Wb
	 MQyMQUspGtLTw==
Date: Tue, 28 Jan 2025 22:06:18 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel <netfilter-devel@vger.kernel.org>,
	Yi Chen <yiche@redhat.com>
Subject: Re: [PATCH nft] evaluate: allow to re-use existing metered set
Message-ID: <Z5lGyle4EDcBCJAh@calendula>
References: <20250121213312.GA16069@breakpoint.cc>
 <20250122091830.254604-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122091830.254604-1-fw@strlen.de>

Hi Florian,

LGTM, just a comestic comment, see below

On Wed, Jan 22, 2025 at 10:18:04AM +0100, Florian Westphal wrote:
> Blamed commit translates old meter syntax (which used to allocate an
> anonymous set) to dynamic sets.
> 
> A side effect of this is that re-adding a meter rule after chain was
> flushed results in an error, unlike anonymous sets named sets are not
> impacted by the flush.
> 
> Refine this: if a set of the same name exists and is compatible, then
> re-use it instead of returning an error.
> 
> Also pick up the reproducer kindly provided by the reporter and place it
> in the shell test directory.
> 
> Fixes: b8f8ddfff733 ("evaluate: translate meter into dynamic set")
> Reported-by: Yi Chen <yiche@redhat.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  src/evaluate.c                                |  46 ++++++--
>  .../sets/dumps/meter_set_reuse.json-nft       | 105 ++++++++++++++++++
>  .../testcases/sets/dumps/meter_set_reuse.nft  |  11 ++
>  tests/shell/testcases/sets/meter_set_reuse    |  20 ++++
>  4 files changed, 173 insertions(+), 9 deletions(-)
>  create mode 100644 tests/shell/testcases/sets/dumps/meter_set_reuse.json-nft
>  create mode 100644 tests/shell/testcases/sets/dumps/meter_set_reuse.nft
>  create mode 100755 tests/shell/testcases/sets/meter_set_reuse
> 
> diff --git a/src/evaluate.c b/src/evaluate.c
> index 919ef90707d9..50443df14df4 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
> @@ -3356,7 +3356,7 @@ static int stmt_evaluate_payload(struct eval_ctx *ctx, struct stmt *stmt)
>  
>  static int stmt_evaluate_meter(struct eval_ctx *ctx, struct stmt *stmt)
>  {
> -	struct expr *key, *set, *setref;
> +	struct expr *key, *setref;
>  	struct set *existing_set;
>  	struct table *table;
>  
> @@ -3367,7 +3367,9 @@ static int stmt_evaluate_meter(struct eval_ctx *ctx, struct stmt *stmt)
>  		return table_not_found(ctx);
>  
>  	existing_set = set_cache_find(table, stmt->meter.name);
> -	if (existing_set)
> +	if (existing_set &&
> +	    (!set_is_meter_compat(existing_set->flags) ||
> +	     set_is_map(existing_set->flags)))
>  		return cmd_error(ctx, &stmt->location,
>  				 "%s; meter '%s' overlaps an existing %s '%s' in family %s",
>  				 strerror(EEXIST),
> @@ -3388,17 +3390,43 @@ static int stmt_evaluate_meter(struct eval_ctx *ctx, struct stmt *stmt)
>  
>  	/* Declare an empty set */
>  	key = stmt->meter.key;
> -	set = set_expr_alloc(&key->location, NULL);
> -	set->set_flags |= NFT_SET_EVAL;
> -	if (key->timeout)
> -		set->set_flags |= NFT_SET_TIMEOUT;
> +	if (existing_set) {
> +		if ((existing_set->flags & NFT_SET_TIMEOUT) && !key->timeout)
> +			return expr_error(ctx->msgs, stmt->meter.key,
> +					  "existing set '%s' has timeout flag",
> +					  stmt->meter.name);
> +
> +		if ((existing_set->flags & NFT_SET_TIMEOUT) == 0 && key->timeout)
> +			return expr_error(ctx->msgs, stmt->meter.key,
> +					  "existing set '%s' lacks timeout flag",
> +					  stmt->meter.name);
> +
> +		if (stmt->meter.size > 0 && existing_set->desc.size != stmt->meter.size)
> +			return expr_error(ctx->msgs, stmt->meter.key,
> +					  "existing set '%s' has size %u, meter has %u",
> +					  stmt->meter.name, existing_set->desc.size,
> +					  stmt->meter.size);
> +	}
        ^
remove this..

> +
> +	if (existing_set) {
        ^^^^^^^^^^^^^^^^^^^
and remove this too, then:

> +		setref = set_ref_expr_alloc(&key->location, existing_set);

just stays on the existing branch.

no need to send v2, just amend and push if you are happy with this.

> +	} else {
> +		struct expr *set;
> +
> +		set = set_expr_alloc(&key->location, existing_set);
> +		if (key->timeout)
> +			set->set_flags |= NFT_SET_TIMEOUT;
> +
> +		set->set_flags |= NFT_SET_EVAL;
> +		setref = implicit_set_declaration(ctx, stmt->meter.name,
> +						  expr_get(key), NULL, set, 0);
> +		if (setref)
> +			setref->set->desc.size = stmt->meter.size;
> +	}
>  
> -	setref = implicit_set_declaration(ctx, stmt->meter.name,
> -					  expr_get(key), NULL, set, 0);
>  	if (!setref)
>  		return -1;
>  
> -	setref->set->desc.size = stmt->meter.size;
>  	stmt->meter.set = setref;
>  
>  	if (stmt_evaluate(ctx, stmt->meter.stmt) < 0)
> diff --git a/tests/shell/testcases/sets/dumps/meter_set_reuse.json-nft b/tests/shell/testcases/sets/dumps/meter_set_reuse.json-nft
> new file mode 100644
> index 000000000000..ab4ac06184d0
> --- /dev/null
> +++ b/tests/shell/testcases/sets/dumps/meter_set_reuse.json-nft
> @@ -0,0 +1,105 @@
> +{
> +  "nftables": [
> +    {
> +      "metainfo": {
> +        "version": "VERSION",
> +        "release_name": "RELEASE_NAME",
> +        "json_schema_version": 1
> +      }
> +    },
> +    {
> +      "table": {
> +        "family": "ip",
> +        "name": "filter",
> +        "handle": 0
> +      }
> +    },
> +    {
> +      "chain": {
> +        "family": "ip",
> +        "table": "filter",
> +        "name": "input",
> +        "handle": 0
> +      }
> +    },
> +    {
> +      "set": {
> +        "family": "ip",
> +        "name": "http1",
> +        "table": "filter",
> +        "type": [
> +          "inet_service",
> +          "ipv4_addr"
> +        ],
> +        "handle": 0,
> +        "size": 65535,
> +        "flags": [
> +          "dynamic"
> +        ]
> +      }
> +    },
> +    {
> +      "rule": {
> +        "family": "ip",
> +        "table": "filter",
> +        "chain": "input",
> +        "handle": 0,
> +        "expr": [
> +          {
> +            "match": {
> +              "op": "==",
> +              "left": {
> +                "payload": {
> +                  "protocol": "tcp",
> +                  "field": "dport"
> +                }
> +              },
> +              "right": 80
> +            }
> +          },
> +          {
> +            "set": {
> +              "op": "add",
> +              "elem": {
> +                "concat": [
> +                  {
> +                    "payload": {
> +                      "protocol": "tcp",
> +                      "field": "dport"
> +                    }
> +                  },
> +                  {
> +                    "payload": {
> +                      "protocol": "ip",
> +                      "field": "saddr"
> +                    }
> +                  }
> +                ]
> +              },
> +              "set": "@http1",
> +              "stmt": [
> +                {
> +                  "limit": {
> +                    "rate": 200,
> +                    "burst": 5,
> +                    "per": "second",
> +                    "inv": true
> +                  }
> +                }
> +              ]
> +            }
> +          },
> +          {
> +            "counter": {
> +              "packets": 0,
> +              "bytes": 0
> +            }
> +          },
> +          {
> +            "drop": null
> +          }
> +        ]
> +      }
> +    }
> +  ]
> +}
> diff --git a/tests/shell/testcases/sets/dumps/meter_set_reuse.nft b/tests/shell/testcases/sets/dumps/meter_set_reuse.nft
> new file mode 100644
> index 000000000000..f911acaffb85
> --- /dev/null
> +++ b/tests/shell/testcases/sets/dumps/meter_set_reuse.nft
> @@ -0,0 +1,11 @@
> +table ip filter {
> +	set http1 {
> +		type inet_service . ipv4_addr
> +		size 65535
> +		flags dynamic
> +	}
> +
> +	chain input {
> +		tcp dport 80 add @http1 { tcp dport . ip saddr limit rate over 200/second burst 5 packets } counter packets 0 bytes 0 drop
> +	}
> +}
> diff --git a/tests/shell/testcases/sets/meter_set_reuse b/tests/shell/testcases/sets/meter_set_reuse
> new file mode 100755
> index 000000000000..94eccc1a7b82
> --- /dev/null
> +++ b/tests/shell/testcases/sets/meter_set_reuse
> @@ -0,0 +1,20 @@
> +#!/bin/bash
> +
> +set -e
> +
> +addrule()
> +{
> +	$NFT add rule ip filter input tcp dport 80 meter http1 { tcp dport . ip saddr limit rate over 200/second } counter drop
> +}
> +
> +$NFT add table filter
> +$NFT add chain filter input
> +addrule
> +
> +$NFT list meters
> +
> +# This used to remove the anon set, but not anymore
> +$NFT flush chain filter input
> +
> +# This re-add should work.
> +addrule
> -- 
> 2.48.1
> 
> 

