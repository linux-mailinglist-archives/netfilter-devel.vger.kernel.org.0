Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7413B60EA3E
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Oct 2022 22:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiJZU1C (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Oct 2022 16:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJZU1C (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:27:02 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8234696E5
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Oct 2022 13:27:00 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1onmzK-000411-86; Wed, 26 Oct 2022 22:26:58 +0200
Date:   Wed, 26 Oct 2022 22:26:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Jan Engelhardt <jengelh@inai.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH v2 00/12] Speed up iptables-test.py
Message-ID: <Y1mYEpLHDBxNuNoQ@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
References: <20221012151802.11339-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012151802.11339-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 12, 2022 at 05:17:50PM +0200, Phil Sutter wrote:
[...]
> I had this in mind for a while now and finally got around to do it: When
> testing an extensions/*.t file with iptables-tests.py, act in a "batch"
> mode applying all rules at once and checking the expected output in one
> go, thereby reducing the overhead per test file to a single
> iptables-restore and iptables-save call each. This was a bit optimistic,
> but the result is still significant - on my rather slow testing VM, a
> full iptables-tests.py run completes in ~7min instead of ~30min (yes,
> it's slow).

FTR: I tested this once more on a not entirely broken machine which
managed to complete a full testrun in 3min (i.e. a tenth of my VM). With
this patch applied, the same run took merely 40s - so still significant.

Series applied meanwhile.

Cheers, Phil
