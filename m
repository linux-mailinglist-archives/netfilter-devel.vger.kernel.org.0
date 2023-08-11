Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511AB779128
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Aug 2023 15:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjHKN7B (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Aug 2023 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjHKN7A (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:59:00 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF17CD7
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Aug 2023 06:58:59 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qUSfJ-0008QT-DK
        for netfilter-devel@vger.kernel.org; Fri, 11 Aug 2023 15:58:57 +0200
Date:   Fri, 11 Aug 2023 15:58:57 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 0/4] Implement a best-effort forward compat
 solution
Message-ID: <ZNY+ocQhqescnjB7@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230810185452.24387-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810185452.24387-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:54:48PM +0200, Phil Sutter wrote:
> Initial attempts of keeping a compatible version of each rule in the
> kernel for being dumped so any old user space will be able to parse it
> despite what conversions to native expressions have taken place have
> failed: The dump-only bytecode may contain a lookup expression,
> therefore requires updating and an extra set and so on. This will be a
> nightmare to maintain in kernel. Any alternative to this is not
> transparent to old user space which can't be touched in a scenario of
> $RANDOM old container has to parse the host's ruleset.
> 
> Instead of the above, follow a much simpler route by implementing a
> compat-mode into current *tables-nft which avoids any of the later
> internal changes which may prevent an old iptables-nft from parsing a
> kernel's rule correctly. An up to date host expecting outdated
> containers accessing its ruleset may create it in a compatible form,
> trading potential performance regressions in for compatibility.
> 
> Patch 1 is just prep work, patch 2 adds the core logic, patch 3 exposes
> it to CLI and patch 4 finally adds some testing.
> 
> This should resolve nfbz#1632[1], albeit requiring adjustments in how
> users call iptables.
> 
> [1] https://bugzilla.netfilter.org/show_bug.cgi?id=1632
> 
> Changes since v1:
> - Rebase to current HEAD
> - Add missing parser and man page adjustments in patch 3
> 
> Phil Sutter (4):
>   nft: Pass nft_handle to add_{target,action}()
>   nft: Introduce and use bool nft_handle::compat
>   Add --compat option to *tables-nft and *-nft-restore commands
>   tests: Test compat mode

Series applied.
