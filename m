Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35B39F2B1
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 11:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhFHJpr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 05:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHJpq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:45:46 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549EAC061574
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Jun 2021 02:43:54 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lqYH1-0008R5-Oy; Tue, 08 Jun 2021 11:43:51 +0200
Date:   Tue, 8 Jun 2021 11:43:51 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf-next PATCH v2] netfilter: nft_exthdr: Fix for unsafe packet
 data read
Message-ID: <20210608094351.GF20020@breakpoint.cc>
References: <20210608094057.24598-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608094057.24598-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> While iterating through an SCTP packet's chunks, skb_header_pointer() is
> called for the minimum expected chunk header size. If (that part of) the
> skbuff is non-linear, the following memcpy() may read data past
> temporary buffer '_sch'. Use skb_copy_bits() instead which does the
> right thing in this situation.
> 
> Fixes: 133dc203d77df ("netfilter: nft_exthdr: Support SCTP chunks")
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Reviewed-by: Florian Westphal <fw@strlen.de>
