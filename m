Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355C82D77EF
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Dec 2020 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406245AbgLKOcl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Dec 2020 09:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406259AbgLKOcU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:32:20 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB00C0619D2
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Dec 2020 06:30:55 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1knjRa-0007Ub-TG; Fri, 11 Dec 2020 15:30:50 +0100
Date:   Fri, 11 Dec 2020 15:30:50 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 0/10] nft: add automatic icmp/icmpv6 dependencies
Message-ID: <20201211143050.GK4647@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
References: <20201209174924.27720-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209174924.27720-1-fw@strlen.de>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Florian,

On Wed, Dec 09, 2020 at 06:49:14PM +0100, Florian Westphal wrote:
> This series allows nft to automatically add the dependency so that
> the type-dependant field is not evaluated for any type.

Great work, thanks for taking care of this long-standing issue!

Thanks, Phil
