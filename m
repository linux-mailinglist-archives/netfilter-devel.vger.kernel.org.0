Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75F43657D0
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Apr 2021 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhDTLpq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Apr 2021 07:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhDTLpp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:45:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D16C06174A
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Apr 2021 04:45:14 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lYooZ-00081s-Mu; Tue, 20 Apr 2021 13:45:11 +0200
Date:   Tue, 20 Apr 2021 13:45:11 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ali Abdallah <ali.abdallah@suse.com>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] conntrack_tcp: Reset the max ACK flag on SYN in ignore
 state
Message-ID: <20210420114511.GB4841@breakpoint.cc>
References: <20210408061203.35kbl44elgz4resh@Fryzen495>
 <20210408090459.GQ13699@breakpoint.cc>
 <20210413122436.aejo4pwaafwrlzsh@Fryzen495>
 <20210413134517.GC14932@breakpoint.cc>
 <20210413135810.pquz7skzqso6gden@Fryzen495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413135810.pquz7skzqso6gden@Fryzen495>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ali Abdallah <ali.abdallah@suse.com> wrote:

[..]

Can you resend your patch as a new submission, so patchwork can pick
it up properly?

The v2 was not, patchwork treated it as a comment to version 1.

Please also run your patch through scripts/checkpatch.pl before
doing so, the patch lacks at least a 'Signed-off-by' line.
