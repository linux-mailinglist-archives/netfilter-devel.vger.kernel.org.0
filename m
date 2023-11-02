Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2257DF876
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Nov 2023 18:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjKBROk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Nov 2023 13:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjKBROj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:14:39 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E823F18E
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Nov 2023 10:14:34 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qybH6-0007OK-VT; Thu, 02 Nov 2023 18:14:33 +0100
Date:   Thu, 2 Nov 2023 18:14:32 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org,
        =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
Subject: Re: [nft PATCH] tproxy: Drop artificial port printing restriction
Message-ID: <ZUPY+LpiupDoko60@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        =?utf-8?B?TcOhdMOp?= Eckl <ecklm94@gmail.com>
References: <20231102135258.17214-1-phil@nwl.cc>
 <ZUPGsLWmneAY6QGF@calendula>
 <ZUPHM9FnAE7AGTKT@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUPHM9FnAE7AGTKT@calendula>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 02, 2023 at 04:58:43PM +0100, Pablo Neira Ayuso wrote:
> On Thu, Nov 02, 2023 at 04:56:37PM +0100, Pablo Neira Ayuso wrote:
> > On Thu, Nov 02, 2023 at 02:52:58PM +0100, Phil Sutter wrote:
> [...]
> > > diff --git a/src/statement.c b/src/statement.c
> > > index 475611664946a..f5176e6d87f95 100644
> > > --- a/src/statement.c
> > > +++ b/src/statement.c
> > > @@ -989,7 +989,7 @@ static void tproxy_stmt_print(const struct stmt *stmt, struct output_ctx *octx)
> > >  			expr_print(stmt->tproxy.addr, octx);
> > >  		}
> > >  	}
> > > -	if (stmt->tproxy.port && stmt->tproxy.port->etype == EXPR_VALUE) {
> > > +	if (stmt->tproxy.port) {
> 
> Question: is this pattern used elsewhere?
> 
> The original author of this might have taken (copied) this code from
> an existing statement?

A quick grep for EXPR_VALUE didn't turn up anything suspicious.

Maybe Máté recalls why he did things this way back in 2018. FWIW, the
EXPR_VALUE check was already there in v1 of his patch.

Cheers, Phil
