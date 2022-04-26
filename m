Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B630950FBE2
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Apr 2022 13:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347253AbiDZLZx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Apr 2022 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiDZLZx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:25:53 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B717715F398
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Apr 2022 04:22:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1njJHI-0002um-8n; Tue, 26 Apr 2022 13:22:44 +0200
Date:   Tue, 26 Apr 2022 13:22:44 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src: fix always-true assertions
Message-ID: <20220426112244.GA9849@breakpoint.cc>
References: <20220426102935.14950-1-fw@strlen.de>
 <YmfNP3VBYN5F2vJ3@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmfNP3VBYN5F2vJ3@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Tue, Apr 26, 2022 at 12:29:35PM +0200, Florian Westphal wrote:
> > assert(1) is a no-op, this should be assert(0). Use BUG() instead.
> > Add missing CATCHALL to avoid BUG().
> 
> LGTM.
> 
> So this is fixing a bug with catch-all element, correct?

Not really, the default label is hit, assert(1) does not do anything.
After making the assertion work we need to avoid the 'default' label.
