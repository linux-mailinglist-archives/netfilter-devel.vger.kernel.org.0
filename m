Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0B97777FB
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Aug 2023 14:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjHJMQE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Aug 2023 08:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJMQE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:16:04 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161DA196
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Aug 2023 05:16:04 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qU4aA-00055W-Hr
        for netfilter-devel@vger.kernel.org; Thu, 10 Aug 2023 14:16:02 +0200
Date:   Thu, 10 Aug 2023 14:16:02 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 0/3] Chain counter fixes here and there
Message-ID: <ZNTVAnjB+b+7bEGf@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230810112325.20630-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810112325.20630-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:23:22PM +0200, Phil Sutter wrote:
> Resending patch 2 after the test I created for it in patch 3 exposed the
> iptables-nft bug fixed in patch 1.
> 
> Phil Sutter (3):
>   nft: Create builtin chains with counters enabled
>   Revert "libiptc: fix wrong maptype of base chain counters on restore"
>   tests: shell: Test chain policy counter behaviour

Series applied.
