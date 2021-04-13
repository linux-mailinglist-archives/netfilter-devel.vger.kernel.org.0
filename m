Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC935E075
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Apr 2021 15:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345168AbhDMNpk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Apr 2021 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344847AbhDMNpk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:45:40 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB91C061574
        for <netfilter-devel@vger.kernel.org>; Tue, 13 Apr 2021 06:45:20 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lWJLx-00067R-Qs; Tue, 13 Apr 2021 15:45:17 +0200
Date:   Tue, 13 Apr 2021 15:45:17 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ali Abdallah <ali.abdallah@suse.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] conntrack_tcp: Reset the max ACK flag on SYN in ignore
 state
Message-ID: <20210413134517.GC14932@breakpoint.cc>
References: <20210408061203.35kbl44elgz4resh@Fryzen495>
 <20210408090459.GQ13699@breakpoint.cc>
 <20210413122436.aejo4pwaafwrlzsh@Fryzen495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413122436.aejo4pwaafwrlzsh@Fryzen495>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ali Abdallah <ali.abdallah@suse.com> wrote:
> Hi,
> 
> Please find out the updated patch with the fixed comment.
> 
> PS: I'm just wondering if isn't better to just reset the MAXACK_SET on
> both directions once an RST is observed on the tracked connection, what
> do you think?

Mhh, can you share a patch?  Your patch clears it when a SYN is
observed, so I am not sure what you mean.

I think the patch is good; we only need to handle the case where we
let a SYN through, and might be out of state.

So, we only need to handle the reply dir, no?
