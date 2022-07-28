Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F97583FEE
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Jul 2022 15:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiG1N0j (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Jul 2022 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiG1N0j (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:26:39 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBC04B4AE
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Jul 2022 06:26:37 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oH3X8-0003rc-NP; Thu, 28 Jul 2022 15:26:34 +0200
Date:   Thu, 28 Jul 2022 15:26:34 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org,
        Erik Skultety <eskultet@redhat.com>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH 1/3] tests: shell: Fix testcases for changed
 ip6tables opts output
Message-ID: <20220728132634.GC4816@breakpoint.cc>
References: <20220728113136.24376-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728113136.24376-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Adjust captured output, ip6tables prints '--' instead of spaces since
> the commit in Fixes: tag.

Thanks, all 3 patches look good to me.
