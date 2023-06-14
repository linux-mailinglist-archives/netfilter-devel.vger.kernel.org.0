Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFDC71FFD6
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Jun 2023 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjFBK5M (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Jun 2023 06:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjFBK5L (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:57:11 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3330123
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Jun 2023 03:57:07 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1q52Sv-0001wW-H2; Fri, 02 Jun 2023 12:57:05 +0200
Date:   Fri, 2 Jun 2023 12:57:05 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables] nft: check for source and destination address
 in first place
Message-ID: <ZHnLATyfSjTrcTM2@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20230601192828.86384-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601192828.86384-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 01, 2023 at 09:28:28PM +0200, Pablo Neira Ayuso wrote:
> When generating bytecode, check for source and destination address in
> first place, then, check for the input and output device. In general,
> the first expression in the rule is the most evaluated during the
> evaluation process. These selectors are likely to show more variability
> in rulesets.

The change is effective only for rules which match on both address(es)
and interface(s) anyway.

Patch applied, thanks!
