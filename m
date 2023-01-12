Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E756670B0
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Jan 2023 12:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjALLPY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Jan 2023 06:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjALLOa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:14:30 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3BBD1177
        for <netfilter-devel@vger.kernel.org>; Thu, 12 Jan 2023 03:06:58 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:06:55 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf-next PATCH v2] netfilter: nf_tables: Introduce
 NFTA_RULE_ACTUAL_EXPR
Message-ID: <Y7/pzxvu2v4t4PgZ@salvia>
References: <20221221142221.27211-1-phil@nwl.cc>
 <Y7/drsGvc8MkQiTY@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7/drsGvc8MkQiTY@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:15:10AM +0100, Phil Sutter wrote:
> Bump?
> 
> On Wed, Dec 21, 2022 at 03:22:21PM +0100, Phil Sutter wrote:
> > Allow for user space to provide an improved variant of the rule for
> > actual use. The variant in NFTA_RULE_EXPRESSIONS may provide maximum
> > compatibility for old user space tools (e.g. in outdated containers).
> > 
> > The new attribute is also dumped back to user space, e.g. for comparison
> > against the compatible variant.
> > 
> > While being at it, improve nft_rule_policy for NFTA_RULE_EXPRESSIONS.

Could you split this in two patches?

I still don't see how this is improving the situation for the scenario
you describe, if you could extend a bit on how you plan to use this
I'd appreciate.

Thanks.
