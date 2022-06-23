Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E727F557F85
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Jun 2022 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiFWQOZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 23 Jun 2022 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiFWQOW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:14:22 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EC8139810
        for <netfilter-devel@vger.kernel.org>; Thu, 23 Jun 2022 09:14:20 -0700 (PDT)
Date:   Thu, 23 Jun 2022 18:14:17 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: large set overlap and automerge
Message-ID: <YrSRWQ8uz+sTPdXs@salvia>
References: <20220616093541.277164-1-pablo@netfilter.org>
 <YrSN+A2I2stpx2z/@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrSN+A2I2stpx2z/@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 23, 2022 at 05:59:52PM +0200, Phil Sutter wrote:
> On Thu, Jun 16, 2022 at 11:35:41AM +0200, Pablo Neira Ayuso wrote:
> > Add a test to validate set overlap and automerge for large set. This
> > test runs nft -f twice to cover for set reload without flush.
> 
> I had this in mind as well, but didn't like to hard-code any thresholds.
> Your test is useful only for manual result review and will always pass,
> therefore will only increase testsuite run time without any benefit.

Yes, I run them manually often and it won't work for a robot, unless
time is printed somewhere and the robot identifies an anomaly there.

I can remove it if you like.
