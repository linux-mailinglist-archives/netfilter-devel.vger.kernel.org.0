Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FBD7CC0D6
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Oct 2023 12:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjJQKnL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Oct 2023 06:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQKnK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:43:10 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACE1FA;
        Tue, 17 Oct 2023 03:43:08 -0700 (PDT)
Received: from [78.30.34.192] (port=50662 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qshXU-004p5p-Hl; Tue, 17 Oct 2023 12:43:06 +0200
Date:   Tue, 17 Oct 2023 12:43:03 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, David Miller <davem@davemloft.net>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [net-next PATCH v2] net: skb_find_text: Ignore patterns
 extending past 'to'
Message-ID: <ZS5lNz5bqMus/K9L@calendula>
References: <20231017093906.26310-1-phil@nwl.cc>
 <20231017100939.GC10901@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017100939.GC10901@breakpoint.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:09:39PM +0200, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > Assume that caller's 'to' offset really represents an upper boundary for
> > the pattern search, so patterns extending past this offset are to be
> > rejected.
> > 
> > The old behaviour also was kind of inconsistent when it comes to
> > fragmentation (or otherwise non-linear skbs): If the pattern started in
> > between 'to' and 'from' offsets but extended to the next fragment, it
> > was not found if 'to' offset was still within the current fragment.
> > 
> > Test the new behaviour in a kselftest using iptables' string match.
> 
> Reviewed-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
