Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2127063248E
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Nov 2022 14:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiKUN7j (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Nov 2022 08:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiKUN7P (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:59:15 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0362A817D
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Nov 2022 05:58:09 -0800 (PST)
Date:   Mon, 21 Nov 2022 14:58:04 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Vishwanath Pai <vpai@akamai.com>
Cc:     kadlec@netfilter.org, fw@strlen.de, johunt@akamai.com,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: ipset: regression in ip_set_hash_ip.c
Message-ID: <Y3uD7DyMxY8ZEiiY@salvia>
References: <20220928182651.602811-1-vpai@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220928182651.602811-1-vpai@akamai.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:26:50PM -0400, Vishwanath Pai wrote:
> This patch introduced a regression: commit 48596a8ddc46 ("netfilter:
> ipset: Fix adding an IPv4 range containing more than 2^31 addresses")
> 
> The variable e.ip is passed to adtfn() function which finally adds the
> ip address to the set. The patch above refactored the for loop and moved
> e.ip = htonl(ip) to the end of the for loop.
> 
> What this means is that if the value of "ip" changes between the first
> assignement of e.ip and the forloop, then e.ip is pointing to a
> different ip address than "ip".
> 
> Test case:
> $ ipset create jdtest_tmp hash:ip family inet hashsize 2048 maxelem 100000
> $ ipset add jdtest_tmp 10.0.1.1/31
> ipset v6.21.1: Element cannot be added to the set: it's already added
> 
> The value of ip gets updated inside the  "else if (tb[IPSET_ATTR_CIDR])"
> block but e.ip is still pointing to the old value.

Applied to nf.git, thanks
