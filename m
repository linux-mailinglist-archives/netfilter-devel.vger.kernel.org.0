Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027C636AA49
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Apr 2021 03:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhDZBZM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Apr 2021 21:25:12 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49786 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhDZBZL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:25:11 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id C7D19605A8;
        Mon, 26 Apr 2021 03:23:53 +0200 (CEST)
Date:   Mon, 26 Apr 2021 03:24:26 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2 nf-next] netfilter: disable defrag once its no longer
 needed
Message-ID: <20210426012426.GA30996@salvia>
References: <20210421074540.18983-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421074540.18983-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:45:40AM +0200, Florian Westphal wrote:
> When I changed defrag hooks to no longer get registered by default I
> intentionally made it so that registration can only be un-done by unloading
> the nf_defrag_ipv4/6 module.
> 
> In hindsight this was too conservative; there is no reason to keep defrag
> on while there is no feature dependency anymore.
> 
> Moreover, this won't work if user isn't allowed to remove nf_defrag module.
> 
> This adds the disable() functions for both ipv4 and ipv6 and calls them
> from conntrack, TPROXY and the xtables socket module.
> 
> ipvs isn't converted here, it will behave as before this patch and
> will need module removal.

Applied, thanks.
