Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDD2037C8
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2020 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgFVNUu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jun 2020 09:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgFVNUu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:20:50 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208D0C061573
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jun 2020 06:20:50 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jnMNT-0005Ie-2A; Mon, 22 Jun 2020 15:20:47 +0200
Date:   Mon, 22 Jun 2020 15:20:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] doc: Document notrack statement
Message-ID: <20200622132047.GR26990@breakpoint.cc>
References: <20200622131013.25157-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622131013.25157-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Merely a stub, but better to mention it explicitly instead of having it
> appear in synproxy examples and letting users guess as to what it does.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Reviewed-by: Florian Westphal <fw@strlen.de>
