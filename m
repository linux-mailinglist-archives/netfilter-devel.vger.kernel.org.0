Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A91513971
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Apr 2022 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbiD1QQF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Apr 2022 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiD1QQE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:16:04 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EE113D3E
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Apr 2022 09:12:48 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nk6l4-0002Q4-PL; Thu, 28 Apr 2022 18:12:46 +0200
Date:   Thu, 28 Apr 2022 18:12:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Steve Brecher <steve@sbrecher.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: Minor issue in iptables(8) man page
Message-ID: <20220428161246.GG9849@breakpoint.cc>
References: <f7f0656d-4634-caad-c562-3121756f5afb@sbrecher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f0656d-4634-caad-c562-3121756f5afb@sbrecher.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Steve Brecher <steve@sbrecher.com> wrote:
> Hi,
> 
> The 4th section of the page, Tables, begins, "There are currently three
> independent tables ..." but lists four tables (filter, nat, mangle, and
> raw).

Update :-)  This was fixed in 2013.
