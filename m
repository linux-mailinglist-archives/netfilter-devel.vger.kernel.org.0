Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA734DB86B
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Mar 2022 20:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbiCPTPI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Mar 2022 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiCPTPH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:15:07 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6F28E35
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Mar 2022 12:13:53 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nUZ5j-0007nc-S5; Wed, 16 Mar 2022 20:13:51 +0100
Date:   Wed, 16 Mar 2022 20:13:51 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 3/3] libxtables: Boost rule target checks by
 announcing chain names
Message-ID: <20220316191351.GG9936@breakpoint.cc>
References: <20220316174443.1930-1-phil@nwl.cc>
 <20220316174443.1930-4-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316174443.1930-4-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> When restoring a ruleset, feed libxtables with chain names from
> respective lines to avoid an extension search.
> 
> While the user's intention is clear, this effectively disables the
> sanity check for clashes with target extensions. But:
> 
> * The check yielded only a warning and the clashing chain was finally
>   accepted.
> 
> * Users crafting iptables dumps for feeding into iptables-restore likely
>   know what they're doing.

Acked-by: Florian Westphal <fw@strlen.de>
