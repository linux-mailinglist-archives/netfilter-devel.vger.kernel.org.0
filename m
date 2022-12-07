Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C99646349
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Dec 2022 22:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiLGVdD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Dec 2022 16:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiLGVdA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:33:00 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 803742FFE7
        for <netfilter-devel@vger.kernel.org>; Wed,  7 Dec 2022 13:32:54 -0800 (PST)
Date:   Wed, 7 Dec 2022 22:32:51 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     eric@garver.life
Subject: Re: [PATCH nft 2/2] netlink: swap byteorder of value component in
 interval set with concatenation
Message-ID: <Y5EGgxxzsqelwOD0@salvia>
References: <20221207212731.179911-1-pablo@netfilter.org>
 <20221207212731.179911-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207212731.179911-2-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Dec 07, 2022 at 10:27:31PM +0100, Pablo Neira Ayuso wrote:
> Store the meta mark value component of the element tuple in the set in
> big endian as it is required for the comparisons. This singleton value
> is actually represented as a range in the kernel.

Scratch this, it breaks otherwise, I'll send v2.

> Reported-by: Eric Garver <eric@garver.life>
> Fixes: 1017d323cafa ("src: support for selectors with different byteorder with interval concatenations")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  src/netlink.c                                 |  7 +++
>  tests/py/inet/meta.t                          |  1 +
>  tests/py/inet/meta.t.json                     | 51 +++++++++++++++++++
>  tests/py/inet/meta.t.payload                  | 13 +++++
>  tests/shell/testcases/sets/concat_interval_0  |  6 +++
>  .../sets/dumps/concat_interval_0.nft          |  7 +++
>  6 files changed, 85 insertions(+)
> 
> diff --git a/src/netlink.c b/src/netlink.c
> index db5e79f235d0..ce19af3b4db6 100644
> --- a/src/netlink.c
> +++ b/src/netlink.c
> @@ -281,6 +281,13 @@ static int netlink_gen_concat_data_expr(int end, const struct expr *i,
>  		}
>  		return netlink_export_pad(data, i->prefix->value, i);
>  	case EXPR_VALUE:
> +		if (end)
> +			break;
> +
> +		expr = (struct expr *)i;
> +		if (expr_basetype(expr)->type == TYPE_INTEGER &&
> +		    expr->byteorder == BYTEORDER_HOST_ENDIAN)
> +			mpz_switch_byteorder(expr->value, expr->len / BITS_PER_BYTE);
>  		break;
>  	default:
>  		BUG("invalid expression type '%s' in set", expr_ops(i)->name);
> diff --git a/tests/py/inet/meta.t b/tests/py/inet/meta.t
> index 0d7d5f255c00..5b8f4f42a28f 100644
> --- a/tests/py/inet/meta.t
> +++ b/tests/py/inet/meta.t
> @@ -23,3 +23,4 @@ meta obrname "br0";fail
>  meta mark set ct mark >> 8;ok
>  
>  meta mark . tcp dport { 0x0000000a-0x00000014 . 80-90, 0x00100000-0x00100123 . 100-120 };ok
> +ip saddr . meta mark { 1.2.3.4 . 0x00000100 , 1.2.3.6-1.2.3.8 . 0x00000200-0x00000300 };ok
> diff --git a/tests/py/inet/meta.t.json b/tests/py/inet/meta.t.json
> index bc268a2ef2ae..e99db14a20aa 100644
> --- a/tests/py/inet/meta.t.json
> +++ b/tests/py/inet/meta.t.json
> @@ -350,3 +350,54 @@
>      }
>  ]
>  
> +
> +# ip saddr . meta mark { 1.2.3.4 . 0x00000100 , 1.2.3.6-1.2.3.8 . 0x00000200-0x00000300 }
> +[
> +    {
> +        "match": {
> +            "left": {
> +                "concat": [
> +                    {
> +                        "payload": {
> +                            "field": "saddr",
> +                            "protocol": "ip"
> +                        }
> +                    },
> +                    {
> +                        "meta": {
> +                            "key": "mark"
> +                        }
> +                    }
> +                ]
> +            },
> +            "op": "==",
> +            "right": {
> +                "set": [
> +                    {
> +                        "concat": [
> +                            "1.2.3.4",
> +                            256
> +                        ]
> +                    },
> +                    {
> +                        "concat": [
> +                            {
> +                                "range": [
> +                                    "1.2.3.6",
> +                                    "1.2.3.8"
> +                                ]
> +                            },
> +                            {
> +                                "range": [
> +                                    512,
> +                                    768
> +                                ]
> +                            }
> +                        ]
> +                    }
> +                ]
> +            }
> +        }
> +    }
> +]
> +
> diff --git a/tests/py/inet/meta.t.payload b/tests/py/inet/meta.t.payload
> index 2b4e6c2d180d..94fb00bda955 100644
> --- a/tests/py/inet/meta.t.payload
> +++ b/tests/py/inet/meta.t.payload
> @@ -109,3 +109,16 @@ ip test-inet input
>    [ byteorder reg 1 = hton(reg 1, 4, 4) ]
>    [ payload load 2b @ transport header + 2 => reg 9 ]
>    [ lookup reg 1 set __set%d ]
> +
> +# ip saddr . meta mark { 1.2.3.4 . 0x00000100 , 1.2.3.6-1.2.3.8 . 0x00000200-0x00000300 }
> +__set%d test-inet 87 size 2
> +__set%d test-inet 0
> +        element 04030201 00010000  - 04030201 00010000  : 0 [end]       element 06030201 00020000  - 08030201 00030000  : 0 [end]
> +inet test-inet input
> +  [ meta load nfproto => reg 1 ]
> +  [ cmp eq reg 1 0x00000002 ]
> +  [ payload load 4b @ network header + 12 => reg 1 ]
> +  [ meta load mark => reg 9 ]
> +  [ byteorder reg 9 = hton(reg 9, 4, 4) ]
> +  [ lookup reg 1 set __set%d ]
> +
> diff --git a/tests/shell/testcases/sets/concat_interval_0 b/tests/shell/testcases/sets/concat_interval_0
> index 3812a94d18c8..4d90af9a6557 100755
> --- a/tests/shell/testcases/sets/concat_interval_0
> +++ b/tests/shell/testcases/sets/concat_interval_0
> @@ -9,6 +9,12 @@ RULESET="table ip t {
>  		counter
>  		elements = { 1.0.0.1 . udp . 53 }
>  	}
> +	set s2 {
> +		type ipv4_addr . mark
> +		flags interval
> +		elements = { 10.10.10.10 . 0x00000100,
> +			     20.20.20.20 . 0x00000200 }
> +	}
>  }"
>  
>  $NFT -f - <<< $RULESET
> diff --git a/tests/shell/testcases/sets/dumps/concat_interval_0.nft b/tests/shell/testcases/sets/dumps/concat_interval_0.nft
> index 875ec1d5c6a0..61547c5e75f9 100644
> --- a/tests/shell/testcases/sets/dumps/concat_interval_0.nft
> +++ b/tests/shell/testcases/sets/dumps/concat_interval_0.nft
> @@ -4,4 +4,11 @@ table ip t {
>  		flags interval
>  		counter
>  	}
> +
> +	set s2 {
> +		type ipv4_addr . mark
> +		flags interval
> +		elements = { 10.10.10.10 . 0x00000100,
> +			     20.20.20.20 . 0x00000200 }
> +	}
>  }
> -- 
> 2.30.2
> 
