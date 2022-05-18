Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3452BBED
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 May 2022 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiERMtf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 May 2022 08:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiERMte (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 May 2022 08:49:34 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF1F318DAC3
        for <netfilter-devel@vger.kernel.org>; Wed, 18 May 2022 05:49:33 -0700 (PDT)
Date:   Wed, 18 May 2022 14:49:30 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nf_tables: restrict expression reduction to
 first expression
Message-ID: <YoTrWqp77oeC72Cs@salvia>
References: <20220518100842.1950-1-pablo@netfilter.org>
 <YoTPlIBany/aRvtK@orbyte.nwl.cc>
 <YoTSHls/on1S+/4N@salvia>
 <YoTbJTDxuQ131EDG@orbyte.nwl.cc>
 <20220518114807.GE4316@breakpoint.cc>
 <YoTl2oM6xiRg2/N8@salvia>
 <20220518123814.GF4316@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518123814.GF4316@breakpoint.cc>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 18, 2022 at 02:38:14PM +0200, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > This all seems fragile to me, with huge potential to add subtle bugs
> > > that will be hard to track down.
> > 
> > We can expose flags to indicate that an expression is reduced and
> > expressions that are prefetched.
> > 
> > New test infrastructure will help to catch bugs, more selftests and
> > userspace validation of bytecode through exposed flags.
> > 
> > It would be good not to re-fetch data into register that is already
> > there.
> 
> I wonder if we should explore doing this from userspace only, i.e.
> provide hints to kernel which expressions should be dropped in a given
> chain.
> 
> Thats more transparent and would permit to reshuffle expressions,
> e.g. first add all 'load instructions' and then do the comparisions
> register opererations.
> 
> Kind of reverse approach to what you and Phil are doing, instead of
> eliding expressions in the data path representation based on in-kernel
> logic and a debug infra that annotates 'soft off' expressions, annotate
> them in userspace and then tell kernel what it can discard.
> 
> Downside is that userspace would have to delete+re-add entire chain to
> keep the 'elide' as-is.

Problem is incremental ruleset updates, we'd go back to iptables way
(dump ruleset, rework, reload).

> With proposed scheme, we will have to patch kernel and then tell users
> that they must upgrade kernel or risk that their ruelset is incorrect.
> 
> With userspace approach, we could slowly extend nft and add explicit
> optimization flags to the commandline tool, with default of re-fetch.

I would revisit to enable expression reduction for keys that do not
depend on datapath data by canceling tracking in such case.
