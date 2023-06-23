Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E856073BD36
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jun 2023 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjFWQwp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Jun 2023 12:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjFWQwb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:52:31 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EA02724
        for <netfilter-devel@vger.kernel.org>; Fri, 23 Jun 2023 09:52:27 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qCk1I-0004CN-07; Fri, 23 Jun 2023 18:52:24 +0200
Date:   Fri, 23 Jun 2023 18:52:23 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>,
        danw@redhat.com, aauren@gmail.com
Subject: Re: [iptables PATCH 3/4] Add --compat option to *tables-nft and
 *-nft-restore commands
Message-ID: <ZJXNx8Cw5oZ+h2ZR@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>,
        danw@redhat.com, aauren@gmail.com
References: <20230505183446.28822-1-phil@nwl.cc>
 <20230505183446.28822-4-phil@nwl.cc>
 <ZHaR1M+EFjUHLOc/@calendula>
 <ZHcNDxfJmxcEEDB8@orbyte.nwl.cc>
 <20230531112816.GA26130@breakpoint.cc>
 <ZHc5QmQ/rrCQ7r8W@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHc5QmQ/rrCQ7r8W@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 31, 2023 at 02:10:42PM +0200, Phil Sutter wrote:
> On Wed, May 31, 2023 at 01:28:16PM +0200, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > Then I revived my "rule bytecode for output" approach and got it working
> > > apart from lookup expression. But finally you axed it since it requires
> > > kernel adjustments.
> > 
> > Can you remind me what the problem with userdata is/was?
> > Brief summary will hopefully be enough ...
> > 
> > I agree text representation sucks due to two different formats, but what
> > about storing binary blob (xt format) of the rule in userdata?
> 
> It requires updated binaries to support it on the receiver side. Or are
> you suggesting the kernel to put the blob from userdata into
> NFTA_RULE_EXPRESSIONS in dumps?

Which would also not work if it contained lookup expressions as they
won't get initialized.

Any further feedback? I know it's not a perfect solution, but given the
constraints I see no good alternative.

Cheers, Phil
