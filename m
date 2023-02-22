Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0169F922
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Feb 2023 17:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBVQi7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Feb 2023 11:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjBVQi6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:38:58 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9721167D
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Feb 2023 08:38:46 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pUs8h-00059C-EN; Wed, 22 Feb 2023 17:38:43 +0100
Date:   Wed, 22 Feb 2023 17:38:43 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Thomas Devoogdt <thomas@devoogdt.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] [iptables] extensions: libxt_LOG.c: fix
 linux/netfilter/xt_LOG.h include on Linux < 3.4
Message-ID: <Y/ZFE5ybIYKTJrIA@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Thomas Devoogdt <thomas@devoogdt.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20230222072349.509917-1-thomas.devoogdt@barco.com>
 <Y/XouZlrtw/SN/C2@salvia>
 <Y/YFcwp/gyZY5Pmw@orbyte.nwl.cc>
 <Y/YZC1Feu9gOCdWF@salvia>
 <Y/Y1efOjGyBo0MAj@orbyte.nwl.cc>
 <Y/Y62lQorHG1PK2g@orbyte.nwl.cc>
 <CACXRmJgs2XkwO5ODjNwe9MExaVbNxCr7JqfuN-wSAC4iDFy0-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACXRmJgs2XkwO5ODjNwe9MExaVbNxCr7JqfuN-wSAC4iDFy0-Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 22, 2023 at 05:21:58PM +0100, Thomas Devoogdt wrote:
> I saw your new commit:
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20230222155601.31645-1-phil@nwl.cc/,
> 
> Thx in advance.
> No further action from my side is required I guess.

Thanks for confirming. I'll push the patch.

Cheers, Phil
