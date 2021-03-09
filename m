Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C7332424
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Mar 2021 12:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCILeP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Mar 2021 06:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhCILeD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:34:03 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E80C06174A;
        Tue,  9 Mar 2021 03:34:03 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lJacW-0005aP-OH; Tue, 09 Mar 2021 12:33:48 +0100
Date:   Tue, 9 Mar 2021 12:33:48 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        subashab@codeaurora.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] netfilter: x_tables: Use correct memory barriers.
Message-ID: <20210309113348.GE10808@breakpoint.cc>
References: <20210308012413.14383-1-mark.tomlinson@alliedtelesis.co.nz>
 <20210308012413.14383-4-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308012413.14383-4-mark.tomlinson@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz> wrote:
> When a new table value was assigned, it was followed by a write memory
> barrier. This ensured that all writes before this point would complete
> before any writes after this point. However, to determine whether the
> rules are unused, the sequence counter is read. To ensure that all
> writes have been done before these reads, a full memory barrier is
> needed, not just a write memory barrier. The same argument applies when
> incrementing the counter, before the rules are read.
> 
> Changing to using smp_mb() instead of smp_wmb() fixes the kernel panic
> reported in cc00bcaa5899 (which is still present), while still
> maintaining the same speed of replacing tables.
> 
> The smb_mb() barriers potentially slow the packet path, however testing
> has shown no measurable change in performance on a 4-core MIPS64
> platform.

Okay, thanks for testing.  I have no further feedback.
