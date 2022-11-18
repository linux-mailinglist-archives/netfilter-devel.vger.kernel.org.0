Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABD62F6DA
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Nov 2022 15:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiKROLA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Nov 2022 09:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbiKROK7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:10:59 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6924A30550
        for <netfilter-devel@vger.kernel.org>; Fri, 18 Nov 2022 06:10:58 -0800 (PST)
Date:   Fri, 18 Nov 2022 15:10:54 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2 0/4] xt: Implement dump and restore support
Message-ID: <Y3eSbhQ+ihCNeSpE@salvia>
References: <20221117174546.21715-1-phil@nwl.cc>
 <20221117211347.GB15714@breakpoint.cc>
 <Y3dUxJZ6J4mg/KNh@orbyte.nwl.cc>
 <Y3daXmuU0Nsyeij6@salvia>
 <Y3dhhVpfoA73W3kA@orbyte.nwl.cc>
 <20221118114643.GD15714@breakpoint.cc>
 <Y3d2qqm2r8Z8Tbih@orbyte.nwl.cc>
 <Y3d4JEmztrNTbK99@salvia>
 <Y3d5eqTGTwEAa2Dq@orbyte.nwl.cc>
 <20221118133431.GE15714@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221118133431.GE15714@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:34:31PM +0100, Florian Westphal wrote:
> Phil Sutter <phil@nwl.cc> wrote:
> > This one:
> > 
> > Subject: [nft PATCH] Warn for tables with compat expressions in rules
> > Date: Wed, 12 Oct 2022 17:31:07 +0200
> > Message-Id: <20221012153107.24574-1-phil@nwl.cc>
> 
> This is:
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20221012153107.24574-1-phil@nwl.cc/
> 
> LGTM, no objections from me.

LGTM.
