Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FB0DA6DB
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405135AbfJQIAt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 04:00:49 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:55594 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392718AbfJQIAt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 04:00:49 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iL0iF-0002DV-LC; Thu, 17 Oct 2019 10:00:47 +0200
Date:   Thu, 17 Oct 2019 10:00:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/4] Revert "monitor: fix double cache update with
 --echo"
Message-ID: <20191017080047.GT25052@breakpoint.cc>
References: <20191016230322.24432-1-phil@nwl.cc>
 <20191016230322.24432-3-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016230322.24432-3-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> This reverts commit 9b032cd6477b847f48dc8454f0e73935e9f48754.
> 
> While it is true that a cache exists, we still need to capture new sets
> and their elements if they are anonymous. This is because the name
> changes and rules will refer to them by name.
> 
> Given that there is no easy way to identify the anonymous set in cache
> (kernel doesn't (and shouldn't) dump SET_ID value) to update its name,
> just go with cache updates. Assuming that echo option is typically used
> for single commands, there is not much cache updating happening anyway.

Acked-by: Florian Westphal <fw@strlen.de>

