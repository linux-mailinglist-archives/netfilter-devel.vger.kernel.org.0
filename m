Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3130A510917
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Apr 2022 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354171AbiDZTgG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Apr 2022 15:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354160AbiDZTgG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:36:06 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54EAC1892BF
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Apr 2022 12:32:57 -0700 (PDT)
Date:   Tue, 26 Apr 2022 21:32:53 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables 7/7] nft: support for dynamic register allocation
Message-ID: <YmhI5e/x/r2qtdtX@salvia>
References: <20220424215613.106165-1-pablo@netfilter.org>
 <20220424215613.106165-8-pablo@netfilter.org>
 <YmgYkZE7hZFVL0D4@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmgYkZE7hZFVL0D4@orbyte.nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:06:41PM +0200, Phil Sutter wrote:
[...]
> > Benchmark #3: match on mark
> > 
> >  *raw
> >  :PREROUTING DROP [9:2781]
> >  :OUTPUT ACCEPT [0:0]
> >  -A PREROUTING -m mark --mark 100 -j DROP
> >  [... 98 times same rule above to trigger mismatch ...]
> >  -A PREROUTING -d 198.18.0.42/32 -j DROP		# matching rule
> > 
> >  iptables-legacy	255Mb
> >  iptables-nft		865Mb (+239.21%)
> 
> Great results, but obviously biased test cases. Did you measure a more
> "realistic" ruleset?

The goal of the benchmark is to show that iptables-legacy is optimized
for five-tuple matching, while iptables-nft with dynamic register
allocation is generically optimized for any selector through native
nftables bytecode.

> > In these cases, iptables-nft generates netlink bytecode which uses the
> > native expressions, ie. payload + cmp and meta + cmp.
> 
> Sounds like a real point for further conversion into native nftables
> expressions where possible.

Exactly.
