Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4102D735EC9
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Jun 2023 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjFSVEX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Jun 2023 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSVEW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:04:22 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2559E4E;
        Mon, 19 Jun 2023 14:04:20 -0700 (PDT)
Date:   Mon, 19 Jun 2023 23:04:17 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     netfilter-devel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com
Subject: Re: [PATCH net 02/14] netfilter: nf_tables: fix chain binding
 transaction logic
Message-ID: <ZJDC0QSZpWLY83YQ@calendula>
References: <20230619145805.303940-1-pablo@netfilter.org>
 <20230619145805.303940-3-pablo@netfilter.org>
 <ZJCzcufoMlCGE64U@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJCzcufoMlCGE64U@corigine.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 19, 2023 at 09:58:42PM +0200, Simon Horman wrote:
> Hi Pablo,
> 
> Maybe something got mixed up here somehow.
> It seems that on x86_64 allmodconfig bind is not defined here.
> 
> gcc says:
> 
>  net/netfilter/nf_tables_api.c: In function 'nft_chain_trans_bind':
>  net/netfilter/nf_tables_api.c:214:63: error: 'bind' undeclared (first use in this function)
>    214 |                                 nft_trans_rule_bound(trans) = bind;
>        |                                                               ^~~~
>  net/netfilter/nf_tables_api.c:214:63: note: each undeclared identifier is reported only once for each function it appears in

Thanks, I will fix and revamp.
