Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2EC6F83AC
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 May 2023 15:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjEENQw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 May 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjEENQt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 May 2023 09:16:49 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE40132
        for <netfilter-devel@vger.kernel.org>; Fri,  5 May 2023 06:16:46 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1puvIg-0001CB-2t; Fri, 05 May 2023 15:16:42 +0200
Date:   Fri, 5 May 2023 15:16:42 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/3] netfilter: nf_tables: reject loads from
 uninitialized registers
Message-ID: <ZFUBusxUvWw//ENx@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20230505111656.32238-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505111656.32238-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi!

On Fri, May 05, 2023 at 01:16:53PM +0200, Florian Westphal wrote:
> Keep a per-rule bitmask that tracks registers that have seen a store,
> then reject loads when the accessed registers haven't been flagged.
> 
> This changes uabi contract, because we previously allowed this.
> Neither nftables nor iptables-nft create such rules.

Did you consider keeping this bitmask on a per base-chain level? One had
to perform this for each base chain of a table upon each rule change and
traverse the tree of chains jumped to from there. I guess the huge
overhead disqualifies this, though.

Cheers, Phil
