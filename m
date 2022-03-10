Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4993F4D46BD
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Mar 2022 13:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiCJMXA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Mar 2022 07:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbiCJMXA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:23:00 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535213D567
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Mar 2022 04:21:59 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nSHnp-0003cX-UK; Thu, 10 Mar 2022 13:21:57 +0100
Date:   Thu, 10 Mar 2022 13:21:57 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables RFC 2/2] libxtables: Boost rule target checks by
 announcing chain names
Message-ID: <20220310122157.GB13772@breakpoint.cc>
References: <20220304131944.30801-1-phil@nwl.cc>
 <20220304131944.30801-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304131944.30801-3-phil@nwl.cc>
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
> This is kind of a double-edged blade: the obvious downside is that
> *tables-restore won't detect user-defined chain name and extension
> clashes anymore. The upside is a tremendous performance improvement
> restoring large rulesets. The same crooked ruleset as mentioned in
> earlier patches (50k chains, 130k rules of which 90k jump to a chain)
> yields these numbers:
> 
> variant	 unoptimized	non-targets cache	announced chains
> ----------------------------------------------------------------
> legacy   1m12s		37s			2.5s
> nft      1m35s		53s			8s

I think the benefits outweight the possible issues.

> Note that iptables-legacy-restore allows the clashes already as long as
> the name does not match a standard target, but with this patch it stops
> warning about it.

Hmm.  That seems fixable by refusing the announce in the clash case?

> iptables-nft-restore does not care at all, even allows
> adding a chain named 'ACCEPT' (and rules can't reach it because '-j
> ACCEPT' translates to a native nftables verdict). The latter is a bug by
> itself.

Agree, thats a bug, it should not allow users to do that.
