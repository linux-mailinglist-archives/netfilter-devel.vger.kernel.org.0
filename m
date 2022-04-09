Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38424FA759
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 Apr 2022 13:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiDILou (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 9 Apr 2022 07:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDILot (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:44:49 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699117A9E
        for <netfilter-devel@vger.kernel.org>; Sat,  9 Apr 2022 04:42:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nd9UG-0007oD-RL; Sat, 09 Apr 2022 13:42:40 +0200
Date:   Sat, 9 Apr 2022 13:42:40 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] doc: Document that kernel may accept unimplemented
 expressions
Message-ID: <20220409114240.GG19371@breakpoint.cc>
References: <20220409094402.22567-1-toiwoton@gmail.com>
 <20220409095152.GA19371@breakpoint.cc>
 <9277ac40-4175-62b3-d777-bdfa9434d187@gmail.com>
 <20220409102216.GF19371@breakpoint.cc>
 <f926a231-6224-f6ca-841f-8a56531b33f8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f926a231-6224-f6ca-841f-8a56531b33f8@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> wrote:
> Would it be possible to add such checks in the future?

We could add socket skuid, socket skgid, its not hard.

> Note that the kernel may accept expressions without errors even if it
> doesn't implement the feature. For example, input chain filters using
> expressions such as *meta skuid*, *meta skgid*, *meta cgroup* or

Those can not be made to work.

> *socket cgroupv2* are silently accepted but they don't work reliably

socket should work, at least for tcp and udp.
The cgroupv2 is buggy.  I sent a patch, feel free to test it.
