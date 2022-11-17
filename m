Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE162E68E
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Nov 2022 22:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiKQVOA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Nov 2022 16:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiKQVNy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:13:54 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3798556D41
        for <netfilter-devel@vger.kernel.org>; Thu, 17 Nov 2022 13:13:50 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ovmCh-00069N-JG; Thu, 17 Nov 2022 22:13:47 +0100
Date:   Thu, 17 Nov 2022 22:13:47 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2 0/4] xt: Implement dump and restore support
Message-ID: <20221117211347.GB15714@breakpoint.cc>
References: <20221117174546.21715-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117174546.21715-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> If nft can't translate a compat expression, dump it in a format that can
> be restored later without losing data, thereby keeping the ruleset
> intact.

Why? :-( This cements nft_compat.c forever.

If we're goping to do it lets at least dump it properly,
i.e.  nft ... add rule compat "-m conntrack --ctstate NEW".

At this time I'd rather like a time machine to prevent nft_compat.c from
getting merged :-(
