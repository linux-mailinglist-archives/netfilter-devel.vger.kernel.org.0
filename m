Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE374D9ADA
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Mar 2022 13:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiCOMGw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Mar 2022 08:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbiCOMGw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:06:52 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814A52E75
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Mar 2022 05:05:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nU5vm-0000Am-Ca
        for netfilter-devel@vger.kernel.org; Tue, 15 Mar 2022 13:05:38 +0100
Date:   Tue, 15 Mar 2022 13:05:38 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: [RFC] conntrack event framework speedup
Message-ID: <20220315120538.GB16569@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

Due to net.netfilter.nf_conntrack_events=1 we eat some uncessesary
overhead:

1. allocation of new conntrack entries needs to alloc ct->ext
2. inverse for deletion/free.
3. Because the ctnetlink module is typically active, each packet will
   end up calling __nf_conntrack_eventmask_report via nf_confirm() and
   then in ctnetlink only to find that we have no listeners
   (and we can't call nfnetlink_has_listeners() from conntrack because
    that would yield a dependency of conntrack to nfnetlink).

I would propose to add minimal conntrack specific code
to nfnetlink, namely, to add bind()(/unbind() calls that inc/dec a
counter for each ctnetlink event listener/socket.
If counter becomes nonzero, flip a bit in struct net.

This would allow us to do the following:

add new net.netfilter.nf_conntrack_events default mode: 2, autodetect.
in nfnetlink bind, inc pernet counter when event group is bound.
in nfnetlink unbind, dec pernet counter when event group is unbound.
in init_conntrack() allocate the event cache extension only if
 a) nf_conntrack_events == 1, or
 b) nf_conntrack_events == 2 and pernet counter is nonzero.

Extend nf_confirm() to check of the pernet counter before
call to __nf_conntrack_eventmask_report().

If nobody spots a problem with this idea I'd start to work on
a prototype.

Thanks.
