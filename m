Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BAD4CB395
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Mar 2022 01:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiCCADJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Mar 2022 19:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiCCADH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:03:07 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F48DD78
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Mar 2022 16:02:22 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1836E62BC2;
        Thu,  3 Mar 2022 00:25:14 +0100 (CET)
Date:   Thu, 3 Mar 2022 00:26:43 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 0/7] netfilter: remove pcpu dying list
Message-ID: <Yh/9M0nBZWiAH8T4@salvia>
References: <20220224164446.23208-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224164446.23208-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Feb 24, 2022 at 05:44:39PM +0100, Florian Westphal wrote:
> v2: fix EXPORT_SYMBOL_GPL related build failure in patch 6.
> No other changes.
> 
> This is part 1 of a series that aims to remove both the unconfirmed
> and dying lists.
> 
> This moves the dying list into the ecache infrastructure.
> Entries are placed on this list only if the delivery of the destroy
> event has failed (which implies that at least one userspace listener
> did request redelivery).
> 
> The percpu dying list is removed in the last patch as it has no
> functionality anymore.  This avoids the extra spinlock for conntrack
> removal.

Applied, thanks
