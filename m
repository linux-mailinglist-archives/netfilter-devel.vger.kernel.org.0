Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984BA6F82FD
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 May 2023 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjEEMc3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 May 2023 08:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjEEMc1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 May 2023 08:32:27 -0400
Received: from Chamillionaire.breakpoint.cc (unknown [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598A611B56
        for <netfilter-devel@vger.kernel.org>; Fri,  5 May 2023 05:32:25 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1puubY-0005oh-S8
        for netfilter-devel@vger.kernel.org; Fri, 05 May 2023 14:32:08 +0200
Date:   Fri, 5 May 2023 14:32:08 +0200
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: nft transaction semantics and flowtable hw offload
Message-ID: <20230505123208.GB6126@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Following dummy ruleset only works on first load:

$ cat bug
flush ruleset
table inet filter {
  flowtable f1 {
  hook ingress priority 10
  flags offload
  devices = { dummy0, dummy1 }
 }
}
$ nft -f bug
$ nft -f bug
bug:3:13-14: Error: Could not process rule: Device or resource busy

This works when 'offload' flag is removed.

Transaction will *first* try to register the flowtable hook,
then it unregisters the existing flowtable hook.

When 'offload' flag is enabled, hook registration fails because
the device offload capability is already busy.

Any suggestions on how to fix this?
Or would you say this is as expected/designed?

I don't see a way to resolve this.

We could swap register/unregister, but this has two major issues:

1. it gives a window where no hook is registered on hw side
2. after unreg, we cannot assume that (re)registering works, so
   'nft -f' may cause loss of functionality.

Adding a 'refcount' scheme doesn't really work either, we'd need
an extra data structure to record the known offload settings, so that
on a 'hook flowtable f1 to dummy0' request we can figure out that this
is expected to be busy and then we could skip the register request.

But that has to problem that the batch might not have an unregister
request, i.e. we would accept a bogus ruleset that *should* have failed
with -EBUSY.

Any ideas?

If not, i'd add a paragraph to the man page wrt. offload caveats.

Thanks,
Florian
