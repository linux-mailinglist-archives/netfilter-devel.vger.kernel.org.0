Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097E762F235
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Nov 2022 11:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiKRKLs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Nov 2022 05:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiKRKLp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:11:45 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C471171F31
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Nov 2022 02:11:44 -0800 (PST)
Date:   Fri, 18 Nov 2022 11:11:42 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2 0/4] xt: Implement dump and restore support
Message-ID: <Y3daXmuU0Nsyeij6@salvia>
References: <20221117174546.21715-1-phil@nwl.cc>
 <20221117211347.GB15714@breakpoint.cc>
 <Y3dUxJZ6J4mg/KNh@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3dUxJZ6J4mg/KNh@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Merging threads.

On Fri, Nov 18, 2022 at 10:55:04AM +0100, Phil Sutter wrote:
[...]
> > I think this more or less a summary of what we discussed in the NFWS.
>
> Pablo, I think you're mixing up two things here:
>
> This "support dump and load of compat expression" feature is to sanitize
> the current situation with up to date iptables and nftables.

OK, then the problem we discuss is mixing iptables-nft and nftables.

On Fri, Nov 18, 2022 at 10:47:48AM +0100, Phil Sutter wrote:
[...]
> > At this time I'd rather like a time machine to prevent nft_compat.c from
> > getting merged :-(
>
> If you do, please convince Pablo to not push iptables commit 384958620a.
> I think it opened the can of worms we're trying to confine here.

It could be worst, if iptables-nft would not be in place, then old
iptables-legacy and new nftables rules would have no visibility each
other.

With iptables-nft we have a way to move forward:

- Replace nft_compat by native expressions from iptables-nft.
- Extend iptables-nft to understand more complex expressions, worst
  case dump a native representation.

Why don't we just move ahead this path instead of spinning around the
compat layer? This only requires userspace updates on iptables-nft.
