Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105DC6FFF6
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 14:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGVMmr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 08:42:47 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:53208 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728396AbfGVMmr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:42:47 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hpXeQ-0002c4-6v; Mon, 22 Jul 2019 14:42:46 +0200
Date:   Mon, 22 Jul 2019 14:42:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] src: evaluate: support prefix expression in
 statements
Message-ID: <20190722124246.5pswhyf3qzq25dkp@breakpoint.cc>
References: <20190722093740.5176-1-fw@strlen.de>
 <20190722120107.76yebnqhmeinhowh@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722120107.76yebnqhmeinhowh@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1187
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> Please, double check before pushing this out that valgrind is happy
> with this (no memleaks).

Doesn't show any.  I removed the last expr_free() and then I can
see the expected leak when runnign the dnat.t test.

Thus, pushed to master, thanks for reviewing this.
