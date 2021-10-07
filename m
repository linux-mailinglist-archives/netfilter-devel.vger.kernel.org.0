Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B4E425016
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Oct 2021 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhJGJbw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 7 Oct 2021 05:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhJGJbv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:31:51 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D7C061746
        for <netfilter-devel@vger.kernel.org>; Thu,  7 Oct 2021 02:29:58 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1mYPiu-0006ys-GJ; Thu, 07 Oct 2021 11:29:56 +0200
Date:   Thu, 7 Oct 2021 11:29:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Eugene Crosser <crosser@average.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: In raw prerouting, `iif` matches different interfaces in
 different kernels when enslaved in a vrf
Message-ID: <20211007092956.GB25730@breakpoint.cc>
References: <17326577-1ab7-aaaa-0911-13ee131bdee0@average.org>
 <20211002185036.GJ2935@breakpoint.cc>
 <dc693a0b-cb3f-877e-1352-cfeb97f2f092@average.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc693a0b-cb3f-877e-1352-cfeb97f2f092@average.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Eugene Crosser <crosser@average.org> wrote:
> It would seem that you have an existing filter that drops packets and
> prevents creation of conntrack entries? I can reproduce the behaviour on
> freshly installed Debian and Ubuntu VMs without any modifications, with and
> without `unshare`.

FWIW, this was due to different default setting of rp_filter.
Adding
sysctl net.ipv4.conf.all.rp_filter=0
sysctl net.ipv4.conf.default.rp_filter=0

to start of script makes it work on my side too.
