Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D3B4B115
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Jun 2019 07:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfFSFKN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Jun 2019 01:10:13 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:56890 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbfFSFKN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:10:13 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hdSrK-0005j6-FR; Wed, 19 Jun 2019 07:10:10 +0200
Date:   Wed, 19 Jun 2019 07:10:10 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Simon Kirby <sim@hostway.ca>
Cc:     netfilter@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: nft ct original oddity
Message-ID: <20190619051010.aae7tvgptmgldawp@breakpoint.cc>
References: <20190618220508.twxiuzaxvtc7ya6u@hostway.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618220508.twxiuzaxvtc7ya6u@hostway.ca>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Simon Kirby <sim@hostway.ca> wrote:

[ moving to nf-devel ]

> I accidentally wrote "ct original" instead of "ct direction original",
> and this broke "nft list ruleset":
> 
> # nft add set filter myset '{ type ipv4_addr; }'
> # nft insert rule filter input ct original ip daddr @myset
> # nft list ruleset
> nft: netlink_delinearize.c:124: netlink_parse_concat_expr: Assertion `consumed > 0' failed.
> Abort

Indeed.

This will fix the immediate problem:

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -329,7 +329,7 @@ static void netlink_parse_lookup(struct netlink_parse_ctx *ctx,
                return netlink_error(ctx, loc,
                                     "Lookup expression has no left hand side");
 
-       if (left->len < set->key->len) {
+       if (left->len && left->len < set->key->len) {
                expr_free(left);
                left = netlink_parse_concat_expr(ctx, loc, sreg, set->key->len);
                if (left == NULL)

Pablo, the problem is that ct->key is NFT_CT_SRC, so expr->len is 0, so
we try to parse a concat expression.  Its not until the evaluation step
before we will figure out from context that SRC is asking for an ipv4
address and update the type and expression length.

AFAICS the plan was to stop using NFT_CT_SRC and use NFT_CT_SRC_IP(6)
instead so we have type and length info available directly.

Was there a problem with it (inet family)?
