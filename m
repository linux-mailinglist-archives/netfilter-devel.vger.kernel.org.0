Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A80534F0ED
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Mar 2021 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhC3SVs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Mar 2021 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhC3SVi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:21:38 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7EDC061574
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Mar 2021 11:21:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lRIzg-0006DM-Js; Tue, 30 Mar 2021 20:21:36 +0200
Date:   Tue, 30 Mar 2021 20:21:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     Florian Westphal <fw@strlen.de>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "pablo@netfilter.org" <pablo@netfilter.org>
Subject: Re: [iptables PATCH v2 2/2] extensions: libxt_conntrack: print xlate
 status as set
Message-ID: <20210330182136.GC17285@breakpoint.cc>
References: <20210330141524.747259-1-alexander.mikhalitsyn@virtuozzo.com>
 <20210330141524.747259-2-alexander.mikhalitsyn@virtuozzo.com>
 <20210330173900.GB17285@breakpoint.cc>
 <DB7PR08MB357940C3E31AFB983408FFE7E87D9@DB7PR08MB3579.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <DB7PR08MB357940C3E31AFB983408FFE7E87D9@DB7PR08MB3579.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com> wrote:
> Hi Florian,
> 
> Thank you!
> So, I need to fix nft and support that syntax?

That would be one way.  The other is to fix the != translation
to use binary logic (the example i gave).

> Do I understand correctly, that the same issue for state flags like
> "established, related, ..."?

Yes and no.  A connection can't be both established and related at the
same time, so anonymous set will work in that case.
