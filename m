Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABC86CEA
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Aug 2019 00:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404372AbfHHWEO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Aug 2019 18:04:14 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34120 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404325AbfHHWEO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:04:14 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hvqW4-0003mn-IR; Fri, 09 Aug 2019 00:04:12 +0200
Date:   Fri, 9 Aug 2019 00:04:12 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Dirk Morris <dmorris@metaloft.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net v3] Use consistent ct id hash calculation
Message-ID: <20190808220412.nissxcfgwc36rswz@breakpoint.cc>
References: <51ae3971-1374-c8d0-e848-6574a5cdf4c1@metaloft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ae3971-1374-c8d0-e848-6574a5cdf4c1@metaloft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dirk Morris <dmorris@metaloft.com> wrote:
> Change ct id hash calculation to only use invariants.
> 
> Currently the ct id hash calculation is based on some fields that can
> change in the lifetime on a conntrack entry in some corner cases. The
> current hash uses the whole tuple which contains an hlist pointer
> which will change when the conntrack is placed on the dying list
> resulting in a ct id change.
> 
> This patch also removes the reply-side tuple and extension pointer
> from the hash calculation so that the ct id will will not change from
> initialization until confirmation.
> 
> Fixes: 3c79107631db1f7 ("netfilter: ctnetlink: don't use conntrack/expect object addresses as id")
> Signed-off-by: Dirk Morris <dmorris@metaloft.com>

Looks good, thanks Dirk.

Acked-by: Florian Westphal <fw@strlen.de>
