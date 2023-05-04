Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97996F5EA0
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 May 2023 20:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjECSyd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 May 2023 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjECSya (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 May 2023 14:54:30 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808753C16
        for <netfilter-devel@vger.kernel.org>; Wed,  3 May 2023 11:54:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1puHcI-0000dE-23; Wed, 03 May 2023 20:54:18 +0200
Date:   Wed, 3 May 2023 20:54:18 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc:     netfilter-devel@vger.kernel.org,
        Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH nf-next 04/19] selftest: netfilter: monitor result file
 sizes
Message-ID: <20230503185418.GE28036@breakpoint.cc>
References: <20230503125552.41113-1-boris.sukholitko@broadcom.com>
 <20230503125552.41113-5-boris.sukholitko@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503125552.41113-5-boris.sukholitko@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Boris Sukholitko <boris.sukholitko@broadcom.com> wrote:
> When running nft_flowtable.sh in VM on a busy server we've found that
> the time of the netcat file transfers vary wildly.
> 
> Therefore replace hardcoded 3 second sleep with the loop checking for
> a change in the file sizes. Once no change in detected we test the results.
> 
> Nice side effect is that we shave 1 second sleep in the fast case
> (hard-coded 3 second sleep vs two 1 second sleeps).

Much better than the old 'sleep', thanks.

Acked-by: Florian Westphal <fw@strlen.de>
