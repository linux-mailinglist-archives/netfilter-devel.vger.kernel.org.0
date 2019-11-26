Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD89109D8B
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Nov 2019 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfKZMJK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Nov 2019 07:09:10 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:36160 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfKZMJK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Nov 2019 07:09:10 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iZZeW-0001He-KB; Tue, 26 Nov 2019 13:09:08 +0100
Date:   Tue, 26 Nov 2019 13:09:08 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 2/2] segtree: restore automerge
Message-ID: <20191126120908.GC8016@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191126103422.29501-1-pablo@netfilter.org>
 <20191126103422.29501-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126103422.29501-2-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Tue, Nov 26, 2019 at 11:34:22AM +0100, Pablo Neira Ayuso wrote:
> Always close interval in non-anonymous sets unless the auto-merge
> feature is set on.
> 
> Fixes: a4ec05381261 ("segtree: always close interval in non-anonymous sets")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> Hi Phil,
> 
> this patch also supersedes https://patchwork.ozlabs.org/patch/1198896/.

I fear this doesn't fix the problem at hand. With your two patches
applied, tests/shell/testcases/sets/0039delete_interval_0 still fails
for me. Your revert removes executable bit from that script, maybe
that's why you didn't notice?

Cheers, Phil
