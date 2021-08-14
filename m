Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD53EC551
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Aug 2021 23:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhHNVNJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 Aug 2021 17:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhHNVNJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 Aug 2021 17:13:09 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84980C061764
        for <netfilter-devel@vger.kernel.org>; Sat, 14 Aug 2021 14:12:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1mF0xK-0005DS-Ur; Sat, 14 Aug 2021 23:12:39 +0200
Date:   Sat, 14 Aug 2021 23:12:38 +0200
From:   Florian Westphal <fw@strlen.de>
To:     alexandre.ferrieux@orange.com
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: nfnetlink_queue -- why linear lookup ?
Message-ID: <20210814211238.GH607@breakpoint.cc>
References: <11790_1628855682_61165D82_11790_25_1_3f865faa-9fd8-40aa-6e49-5d85dd596b5b@orange.com>
 <20210814210103.GG607@breakpoint.cc>
 <14552_1628975094_61182FF6_14552_82_1_d4901cb2-0852-a524-436c-62bf06f95d0e@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14552_1628975094_61182FF6_14552_82_1_d4901cb2-0852-a524-436c-62bf06f95d0e@orange.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

alexandre.ferrieux@orange.com <alexandre.ferrieux@orange.com> wrote:
> > Because when this was implemented "highly asynchronous" was not on the
> > radar.  All users of this (that I know of) do in-order verdicts.
> 
> So, O(N) instead of O(1) just because "I currently can't imagine N>5" ?

Seems so. THis code was written 21 years ago.

> Would a patch to that effect be rejected ?

Probably not, depends on the implementation.
