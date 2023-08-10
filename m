Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760FE7777FA
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Aug 2023 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjHJMPy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Aug 2023 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJMPx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:15:53 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4003F196
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Aug 2023 05:15:53 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qU4Zz-00055C-Dl; Thu, 10 Aug 2023 14:15:51 +0200
Date:   Thu, 10 Aug 2023 14:15:51 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Gaurav Gupta <g.gupta@samsung.com>
Subject: Re: [iptables PATCH] Use SOCK_CLOEXEC/O_CLOEXEC where available
Message-ID: <ZNTU9/lPcOBoeTQE@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org, Gaurav Gupta <g.gupta@samsung.com>
References: <20230810112542.21382-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810112542.21382-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:25:42PM +0200, Phil Sutter wrote:
> No need for the explicit fcntl() call, request the behaviour when
> opening the descriptor.
> 
> One fcntl() call setting FD_CLOEXEC remains in extensions/libxt_bpf.c,
> the indirect syscall seems not to support passing the flag directly.
> 
> Reported-by: Gaurav Gupta <g.gupta@samsung.com>
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1104
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.
