Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B476B3F09
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Mar 2023 13:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCJMTs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Mar 2023 07:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCJMTr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:19:47 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA73F1854
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Mar 2023 04:19:46 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pabiq-0001s0-Gi; Fri, 10 Mar 2023 13:19:44 +0100
Date:   Fri, 10 Mar 2023 13:19:44 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [ipset PATCH 0/4] Some testsuite improvements
Message-ID: <ZAsgYKVbW35rGPA4@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <20230307135812.25993-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307135812.25993-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 07, 2023 at 02:58:08PM +0100, Phil Sutter wrote:
> Patch 1 fixes the reason why xlate testuite failed for me - it was
> simply not testing the right binary. Make it adhere to what the regular
> testsuite does by calling the built ipset tool instead of the installed
> one.
> 
> Patch 2 is just bonus, the idea for it came from a "does this even work"
> sanity check while debugging the above.
> 
> Patch 3 fixes for missing 'netmask' tool on my system. Not entirely
> satisfying though, there's no 'sendip', either (but the testsuite may
> run without).
> 
> Patch 4 avoids a spurious testsuite failure for me. Not sure if it's a
> good solution or will just move the spurious failure to others' systems.
> 
> Phil Sutter (4):
>   tests: xlate: Test built binary by default
>   tests: xlate: Make test input valid
>   tests: cidr.sh: Add ipcalc fallback
>   tests: hash:ip,port.t: 'vrrp' is printed as 'carp'

Series applied.
