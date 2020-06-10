Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E84A1F5521
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2020 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgFJMrG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 10 Jun 2020 08:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgFJMrG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:47:06 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F291C03E96B
        for <netfilter-devel@vger.kernel.org>; Wed, 10 Jun 2020 05:47:06 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jj08D-0006IT-Jp; Wed, 10 Jun 2020 14:47:01 +0200
Date:   Wed, 10 Jun 2020 14:47:01 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v4.10] netfilter: nf_conntrack_h323: lost .data_len
 definition for Q.931/ipv6
Message-ID: <20200610124701.GB21317@breakpoint.cc>
References: <c2385b5c-309c-cc64-2e10-a0ef62897502@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2385b5c-309c-cc64-2e10-a0ef62897502@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Vasily Averin <vvs@virtuozzo.com> wrote:
> Could you please push this patch into stable@?
> it fixes memory corruption in kernels  v3.5 .. v4.10
> 
> Lost .data_len definition leads to write beyond end of
> struct nf_ct_h323_master. Usually it corrupts following
> struct nf_conn_nat, however if nat is not loaded it corrupts
> following slab object.
> 
> In mainline this problem went away in v4.11,
> after commit 9f0f3ebeda47 ("netfilter: helpers: remove data_len usage
> for inkernel helpers") however many stable kernels are still affected.
> 
> cc: stable@vger.kernel.org
> Fixes: 1afc56794e03 ("netfilter: nf_ct_helper: implement variable length helper private data") # v3.5
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Florian Westphal <fw@strlen.de>
