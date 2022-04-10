Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05A4FAF8A
	for <lists+netfilter-devel@lfdr.de>; Sun, 10 Apr 2022 20:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiDJSWG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 10 Apr 2022 14:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiDJSWF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 10 Apr 2022 14:22:05 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613C322531
        for <netfilter-devel@vger.kernel.org>; Sun, 10 Apr 2022 11:19:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ndcAA-0004rD-KS; Sun, 10 Apr 2022 20:19:50 +0200
Date:   Sun, 10 Apr 2022 20:19:50 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nf-next] netfilter: nft_fib: reverse path filter for
 policy-based routing on iif
Message-ID: <20220410181950.GH5623@breakpoint.cc>
References: <20220330222713.867-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330222713.867-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> If policy-based routing using the iif selector is used, then the fib
> expression fails to look up for the reverse path from the prerouting
> hook because the input interface cannot be inferred. In order to support
> this scenario, extend the fib expression to allow to use after the route
> lookup, from the forward chain.

LGTM,
Acked-by: Florian Westphal <fw@strlen.de>
