Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A572D9C43
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Dec 2020 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440199AbgLNQO2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Dec 2020 11:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440194AbgLNQOT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:14:19 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65233C0613D3
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Dec 2020 08:13:39 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1koqTi-0007NF-3u; Mon, 14 Dec 2020 17:13:38 +0100
Date:   Mon, 14 Dec 2020 17:13:38 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] nft: trace: print packet unconditionally
Message-ID: <20201214161338.GB8710@breakpoint.cc>
References: <20201212183625.71140-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212183625.71140-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> The kernel includes the packet dump once for each base hook.
> This means that in case a table contained no matching rule(s),
> the packet dump will be included in the base policy dump.
> 
> Simply move the packet dump request out of the switch statement
> so the debug output shows current packet even with no matched rule.

Pushed this series with the one change (PRIx64) suggested by Phil.
