Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A75EDBF6
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Sep 2022 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiI1Lmo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Sep 2022 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiI1Lmn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:42:43 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC442F3A5
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Sep 2022 04:42:42 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1odVSb-0003wr-AL; Wed, 28 Sep 2022 13:42:41 +0200
Date:   Wed, 28 Sep 2022 13:42:41 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 0/5] Fixes around ebtables' --proto match
Message-ID: <20220928114241.GJ12777@breakpoint.cc>
References: <20220927221512.7400-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927221512.7400-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> During some code merge, I created an ugly situation where local OPT_*
> defines in xtables-eb.c override OPT_* enum values from xshared.h with
> same name but different value.
> 
> The above became problematic when I curtly added --verbose support to
> ebtables-nft in order to support -vv debug output. The used OPT_VERBOSE
> symbol stemmed from xshared.h and its value clashed with OPT_PROTOCOL.
> In practice, this turned verbose mode on for rules with protocol match.
> 
> Fix all the above by merging the different OPT_* symbols in the first
> three patches.
> 
> The second more relevant issue was ebtables' lack of support for '-p
> LENGTH', foremost a mandatory prerequisite for 802_3 extension matches
> validity. The last two patches resolve this.

Series:
Reviewed-by: Florian Westphal <fw@strlen.de>
