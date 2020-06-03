Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD631ED5DF
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2020 20:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgFCSKh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Jun 2020 14:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgFCSKh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:10:37 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B2C08C5C0
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2020 11:10:36 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 3180D58781303; Wed,  3 Jun 2020 20:10:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 2DA6E60E6E485;
        Wed,  3 Jun 2020 20:10:35 +0200 (CEST)
Date:   Wed, 3 Jun 2020 20:10:35 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Harald Welte <laforge@gnumonks.org>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>, netfilter@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [MAINTENANCE] Shutting down FTP services at netfilter.org
In-Reply-To: <20200603171621.GC717800@nataraja>
Message-ID: <nycvar.YFH.7.77.849.2006032004220.24581@n3.vanv.qr>
References: <20200603113712.GA24918@salvia> <20200603171621.GC717800@nataraja>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2020-06-03 19:16, Harald Welte wrote:
>
>On Wed, Jun 03, 2020 at 01:37:12PM +0200, Pablo Neira Ayuso wrote:
>> So netfilter.org will also be shutting down FTP services by
>> June 12th 2020.
>
>I always find that somewhat sad, as with HTTP there is no real convenient
>way to get directory listings in a standardized / parseable format.

There was convention, but no standard.
Which is just like what the default directory index modules of the httpd
implementations are.

>I think the important part would be some way to conveniently obtain a
>full clone, e.g. by rsync.  This way both public and private mirrors
>can exist in an efficient way, without having to resort to 'wget -r'
>or related hacks, which then only use file size as an indication if a
>file might have changed, ...

For completeness though, there is the "Last-Modified" HTTP header (similar to
what rsync bases its heuristic on). rsync is of course always preferable..
