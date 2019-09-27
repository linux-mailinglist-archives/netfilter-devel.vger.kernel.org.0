Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085DFC0772
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Sep 2019 16:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfI0O1Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Sep 2019 10:27:16 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:50316 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728004AbfI0O1Q (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:27:16 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iDrDG-0002ag-OW; Fri, 27 Sep 2019 16:27:14 +0200
Date:   Fri, 27 Sep 2019 16:27:14 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 06/24] xtables-restore: Minimize caching when
 flushing
Message-ID: <20190927142714.GG9938@breakpoint.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
 <20190925212605.1005-7-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925212605.1005-7-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Unless --noflush was given, xtables-restore merely needs the list of
> tables to decide whether to delete it or not. Introduce nft_fake_cache()
> function which populates table list, initializes chain lists (so
> nft_chain_list_get() returns an empty list instead of NULL) and sets
> 'have_cache' to turn any later calls to nft_build_cache() into nops.
> 
> If --noflush was given, call nft_build_cache() just once instead of for
> each table line in input.

LGTM.
Acked-by: Florian Westphal <fw@strlen.de>
