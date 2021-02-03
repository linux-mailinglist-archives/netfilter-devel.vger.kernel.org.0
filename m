Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67530D7E5
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Feb 2021 11:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhBCKpv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Feb 2021 05:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhBCKpu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:45:50 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABBCC061573
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Feb 2021 02:45:09 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1l7Fel-0003KG-N8; Wed, 03 Feb 2021 11:45:07 +0100
Date:   Wed, 3 Feb 2021 11:45:07 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] erec: Sanitize erec location indesc
Message-ID: <20210203104507.GO3158@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210126175502.9171-1-phil@nwl.cc>
 <20210203003832.GA30866@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203003832.GA30866@salvia>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Wed, Feb 03, 2021 at 01:38:32AM +0100, Pablo Neira Ayuso wrote:
> On Tue, Jan 26, 2021 at 06:55:02PM +0100, Phil Sutter wrote:
> > erec_print() unconditionally dereferences erec->locations->indesc, so
> > make sure it is valid when either creating an erec or adding a location.
> 
> I guess your're trigger a bug where erec is indesc is NULL, thing is
> that indesc should be always set on. Is there a reproducer for this bug?

Yes, exactly. I hit it when trying to clean up the netdev family reject
support, while just "hacking around". You can trigger it with the
following change:

| --- a/src/evaluate.c
| +++ b/src/evaluate.c
| @@ -2718,7 +2718,7 @@ static int stmt_evaluate_reject_bridge(struct eval_ctx *ctx, struct stmt *stmt,
|         const struct proto_desc *desc;
|  
|         desc = ctx->pctx.protocol[PROTO_BASE_LL_HDR].desc;
| -       if (desc != &proto_eth && desc != &proto_vlan && desc != &proto_netdev)
| +       if (desc != &proto_eth && desc != &proto_vlan)
|                 return stmt_binary_error(ctx,
|                                          &ctx->pctx.protocol[PROTO_BASE_LL_HDR],
|                                          stmt, "unsupported link layer protocol");

and this ruleset:

| table netdev t {
| 	chain c {
| 		reject
| 	}
| }

Cheers, Phil
