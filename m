Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6387D717E09
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 May 2023 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjEaL3X (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 May 2023 07:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjEaL3W (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 May 2023 07:29:22 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34FA196
        for <netfilter-devel@vger.kernel.org>; Wed, 31 May 2023 04:28:51 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1q4K00-0007Pm-Hi; Wed, 31 May 2023 13:28:16 +0200
Date:   Wed, 31 May 2023 13:28:16 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Eric Garver <e@erig.me>, danw@redhat.com, aauren@gmail.com
Subject: Re: [iptables PATCH 3/4] Add --compat option to *tables-nft and
 *-nft-restore commands
Message-ID: <20230531112816.GA26130@breakpoint.cc>
References: <20230505183446.28822-1-phil@nwl.cc>
 <20230505183446.28822-4-phil@nwl.cc>
 <ZHaR1M+EFjUHLOc/@calendula>
 <ZHcNDxfJmxcEEDB8@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHcNDxfJmxcEEDB8@orbyte.nwl.cc>
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
> Then I revived my "rule bytecode for output" approach and got it working
> apart from lookup expression. But finally you axed it since it requires
> kernel adjustments.

Can you remind me what the problem with userdata is/was?
Brief summary will hopefully be enough ...

I agree text representation sucks due to two different formats, but what
about storing binary blob (xt format) of the rule in userdata?
