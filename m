Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC226F4CF
	for <lists+netfilter-devel@lfdr.de>; Sun, 21 Jul 2019 20:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGUSye (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 21 Jul 2019 14:54:34 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50158 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbfGUSye (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 21 Jul 2019 14:54:34 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hpGye-0006JD-R9; Sun, 21 Jul 2019 20:54:32 +0200
Date:   Sun, 21 Jul 2019 20:54:32 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
        phil@nwl.cc
Subject: Re: [PATCH nft] doc: fib: explain example in more detail
Message-ID: <20190721185432.o2wke7wecfdbyzfr@breakpoint.cc>
References: <20190721104305.29594-1-fw@strlen.de>
 <20190721184212.2fxviqkcil27wzqp@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721184212.2fxviqkcil27wzqp@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Cc'ing Phil.
> 
> On Sun, Jul 21, 2019 at 12:43:05PM +0200, Florian Westphal wrote:
> > As noted by Felix Dreissig, fib documentation is quite terse, so explain
> > the 'saddr . iif' example with a few more words.
> 
> There are patches to disallow ifindex 0 from Phil

WHich ones?
I only see those that make meta write 0 in case iface doesn't exist,
so it does exactly what fib does.
