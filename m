Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCAC36B15A
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Apr 2021 12:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhDZKMZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Apr 2021 06:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhDZKMZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:12:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51410C061574
        for <netfilter-devel@vger.kernel.org>; Mon, 26 Apr 2021 03:11:44 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1layDO-0008IB-4E; Mon, 26 Apr 2021 12:11:42 +0200
Date:   Mon, 26 Apr 2021 12:11:42 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ali Abdallah <ali.abdallah@suse.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: RSTs being marked as invalid because of wrong td_maxack value
Message-ID: <20210426101142.GA19277@breakpoint.cc>
References: <20210423155443.fmlbssgi6pq7nfp4@Fryzen495>
 <20210423162628.GB18119@breakpoint.cc>
 <20210426075747.isyjkpoim5e7bgnb@Fryzen495>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210426075747.isyjkpoim5e7bgnb@Fryzen495>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ali Abdallah <ali.abdallah@suse.com> wrote:
> Yes, they do support timestamps, but I'm not sure if that will solve
> the problem, as the problematic out of order frame #5 has more recent
> timestamps.
> 
> 1: 703 → 2049 [ACK] Seq=1132947682 Ack=1202969688 Win=2661 Len = 0
> TSval=3506781692 TSecr=1717385629
> 
> 2: 2049 → 703 [RST, ACK] Seq=1202969688 Ack=1132949130 Win=69120 Len=0
> TSval=1717385630 TSecr=3506781692

Ok, right, I forgot we may have different clients behind NAT.
