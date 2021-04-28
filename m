Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8F36D837
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Apr 2021 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhD1NYZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Apr 2021 09:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbhD1NYZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:24:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F805C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Apr 2021 06:23:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lbkAE-0004Tm-CG; Wed, 28 Apr 2021 15:23:38 +0200
Date:   Wed, 28 Apr 2021 15:23:38 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ali Abdallah <ali.abdallah@suse.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] Avoid potentially erroneos RST check
Message-ID: <20210428132338.GF975@breakpoint.cc>
References: <20210428131147.w2ppmrt6hpcjin5i@Fryzen495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428131147.w2ppmrt6hpcjin5i@Fryzen495>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ali Abdallah <ali.abdallah@suse.com> wrote:
> In 'commit b303e7b80ff1 ("Reset the max ACK flag on SYN in ignore state")'
> we reset the max ACK number to avoid dropping valid RST that is a
> response to a SYN.
> 
> Unfortunately that might not be enough, an out of order ACK in origin
> might reset it back, and we might end up again dropping valid RST.
> 
> This patch disables the RST check when we are not in established state
> and  we receive an RST with SEQ=0 that is most likely a response to a
> SYN we had let it go through.
> 
> Signed-off-by: Ali Abdallah <aabdallah@suse.de>

Looks good, thanks!

Acked-by: Florian Westphal <fw@strlen.de>
