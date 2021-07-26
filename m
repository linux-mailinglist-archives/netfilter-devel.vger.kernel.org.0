Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55F3D5BC7
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jul 2021 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhGZN4R (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Jul 2021 09:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhGZN4Q (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:56:16 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41F8C061757
        for <netfilter-devel@vger.kernel.org>; Mon, 26 Jul 2021 07:36:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1m81il-0000CS-3u; Mon, 26 Jul 2021 16:36:43 +0200
Date:   Mon, 26 Jul 2021 16:36:43 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] tests: shell: Fix bogus testsuite failure with 100Hz
Message-ID: <20210726143643.GM9904@breakpoint.cc>
References: <20210726140624.5757-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726140624.5757-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> On kernels with CONFIG_HZ=100, clock granularity does not allow tracking
> timeouts in single digit ms range. Change sets/0031set_timeout_size_0 to
> not expose this detail.

Acked-by: Florian Westphal <fw@strlen.de>
