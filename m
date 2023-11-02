Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CC7DF738
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Nov 2023 16:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377035AbjKBP6v (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Nov 2023 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377044AbjKBP6u (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:58:50 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758D137
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Nov 2023 08:58:48 -0700 (PDT)
Received: from [78.30.35.151] (port=58730 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qya5k-009lF6-7I; Thu, 02 Nov 2023 16:58:46 +0100
Date:   Thu, 2 Nov 2023 16:58:43 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tproxy: Drop artificial port printing restriction
Message-ID: <ZUPHM9FnAE7AGTKT@calendula>
References: <20231102135258.17214-1-phil@nwl.cc>
 <ZUPGsLWmneAY6QGF@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUPGsLWmneAY6QGF@calendula>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 02, 2023 at 04:56:37PM +0100, Pablo Neira Ayuso wrote:
> On Thu, Nov 02, 2023 at 02:52:58PM +0100, Phil Sutter wrote:
[...]
> > diff --git a/src/statement.c b/src/statement.c
> > index 475611664946a..f5176e6d87f95 100644
> > --- a/src/statement.c
> > +++ b/src/statement.c
> > @@ -989,7 +989,7 @@ static void tproxy_stmt_print(const struct stmt *stmt, struct output_ctx *octx)
> >  			expr_print(stmt->tproxy.addr, octx);
> >  		}
> >  	}
> > -	if (stmt->tproxy.port && stmt->tproxy.port->etype == EXPR_VALUE) {
> > +	if (stmt->tproxy.port) {

Question: is this pattern used elsewhere?

The original author of this might have taken (copied) this code from
an existing statement?
