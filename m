Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D48E4FEA87
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Apr 2022 01:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiDLXcD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 Apr 2022 19:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiDLXby (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:31:54 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0444A8F9BF
        for <netfilter-devel@vger.kernel.org>; Tue, 12 Apr 2022 15:17:40 -0700 (PDT)
Date:   Wed, 13 Apr 2022 00:17:37 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables 0/9] nftables: add support for wildcard string
 as set keys
Message-ID: <YlX6gfgq4SFPTU+B@salvia>
References: <20220409135832.17401-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220409135832.17401-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Apr 09, 2022 at 03:58:23PM +0200, Florian Westphal wrote:
> Allow to match something like
> 
> meta iifname { eth0, ppp* }.

This series LGTM, thanks for working on this.

> Set ranges or concatenations are not yet supported.
> Test passes on x86_64 and s390 (bigendian), however, the test fails dump
> validation:
> 
> -  iifname { "eth0", "abcdef0" } counter packets 0 bytes 0
> +  iifname { "abcdef0", "eth0" } counter packets 0 bytes 0

Hm. Is it reordering the listing?

> This happens with other tests as well.  Other tests fail
> on s390 too but there are no new failures.
> 
> I wil try to get string range support working and will
> then ook into concat set support.

OK, so then this is a WIP?
