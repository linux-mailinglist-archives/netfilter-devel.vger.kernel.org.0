Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A1D65E7FC
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Jan 2023 10:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjAEJiS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Jan 2023 04:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjAEJiP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:38:15 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A99551F0
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Jan 2023 01:38:13 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pDMhO-0008Rj-Vm; Thu, 05 Jan 2023 10:38:11 +0100
Date:   Thu, 5 Jan 2023 10:38:10 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH nf] selftests: netfilter: fix transaction test script
 timeout handling
Message-ID: <20230105093810.GA8857@breakpoint.cc>
References: <20230104115442.2427-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104115442.2427-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> The kselftest framework uses a default timeout of 45 seconds for
> all test scripts.
> 
> Increase the timeout to two minutes for the netfilter tests, this
> should hopefully be enough,
> 
> Make sure that, should the script be canceled, the net namespace and
> the spawned ping instances are removed.
> 
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

Fixes: 25d8bcedbf43 ("selftests: add script to stress-test nft packet path vs. control plane")
Reported-and-tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

I'll add those tags when applying the patch to nf.git, thanks for
testing.
