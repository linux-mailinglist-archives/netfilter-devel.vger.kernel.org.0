Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53C6B3E80
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Mar 2023 12:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCJL46 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Mar 2023 06:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCJL4d (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:56:33 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19764DDB24
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Mar 2023 03:56:32 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:56:29 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [ipset PATCH 0/2] Two minor code fixes
Message-ID: <ZAsa7a2mF7wGk8fI@salvia>
References: <20230222170241.26208-1-phil@nwl.cc>
 <Y//RlHWq86REFVu6@salvia>
 <ZABmjujQuFgknGXR@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZABmjujQuFgknGXR@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 02, 2023 at 10:04:14AM +0100, Phil Sutter wrote:
> On Wed, Mar 01, 2023 at 11:28:36PM +0100, Pablo Neira Ayuso wrote:
> > On Wed, Feb 22, 2023 at 06:02:39PM +0100, Phil Sutter wrote:
> > > These were identified by Coverity tool, no problems in practice. Still
> > > worth fixing to reduce noise in code checkers.
> > 
> > LGTM.
> > 
> > Did you run ipset xlate tests? These should not break those but just
> > in case.
> 
> I didn't, thanks for the reminder. Testsuite fails, but it does with
> HEAD as well. And so does the other testsuite ("make tests"), BtW. I'll
> investigate.

Does this work after your testsuite updates? If so, push them out.
