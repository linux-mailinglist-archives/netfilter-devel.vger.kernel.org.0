Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62B7599919
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Aug 2022 11:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347997AbiHSJuJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Aug 2022 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347931AbiHSJuF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:50:05 -0400
Received: from zeeaster.vergenet.net (zeeaster.vergenet.net [206.189.110.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC35E3981;
        Fri, 19 Aug 2022 02:50:04 -0700 (PDT)
Received: from madeliefje.horms.nl (86-88-72-229.fixed.kpn.net [86.88.72.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by zeeaster.vergenet.net (Postfix) with ESMTPSA id C3CEB20537;
        Fri, 19 Aug 2022 09:50:01 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
        id 4EF223E5E; Fri, 19 Aug 2022 11:50:01 +0200 (CEST)
Date:   Fri, 19 Aug 2022 11:50:01 +0200
From:   Simon Horman <horms@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Julian Anastasov <ja@ssi.bg>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: move from strlcpy with unused retval to
 strscpy
Message-ID: <Yv9cya3UyvJsh0Ah@vergenet.net>
References: <20220818210224.8563-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818210224.8563-1-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:02:24PM +0200, Wolfram Sang wrote:
> Follow the advice of the below link and prefer 'strscpy' in this
> subsystem. Conversion is 1:1 because the return value is not used.
> Generated by a coccinelle script.
> 
> Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks Wolfram,

FWIIW, for the IPVS portion:

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  net/netfilter/ipset/ip_set_core.c |  4 ++--
>  net/netfilter/ipvs/ip_vs_ctl.c    |  8 ++++----
>  net/netfilter/nf_log.c            |  4 ++--
>  net/netfilter/nf_tables_api.c     |  2 +-
>  net/netfilter/nft_osf.c           |  2 +-
>  net/netfilter/x_tables.c          | 20 ++++++++++----------
>  net/netfilter/xt_RATEEST.c        |  2 +-
>  7 files changed, 21 insertions(+), 21 deletions(-)

...
