Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C4C86B80
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Aug 2019 22:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404351AbfHHU2H (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Aug 2019 16:28:07 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:33790 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404270AbfHHU2G (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:28:06 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hvp13-0003JO-8f; Thu, 08 Aug 2019 22:28:05 +0200
Date:   Thu, 8 Aug 2019 22:28:05 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Dirk Morris <dmorris@metaloft.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net v2] netfilter: Use consistent ct id hash calculation
Message-ID: <20190808202805.ugyzrexglauwzwgn@breakpoint.cc>
References: <42f0ed4e-d070-b398-44de-15c65221f30c@metaloft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f0ed4e-d070-b398-44de-15c65221f30c@metaloft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dirk Morris <dmorris@metaloft.com> wrote:
> Change ct id hash calculation to only use invariants.
> 
> Currently the ct id hash calculation is based on some fields that can
> change in the lifetime on a conntrack entry in some corner cases. This
> results on the ct id change after the conntrack has been confirmed.
> This changes the hash to be based on attributes which should never
> change. Now the ct id hash is also consistent from initialization to
> conntrack confirmation either even though it is unconfirmed.

Looks good, but can you also fix up the comment at the top of this
function?  (Alternatively, delete those things that are not relevant
anymore).

Also, please add following Tag:

Fixes: 3c79107631db1f7 ("netfilter: ctnetlink: don't use conntrack/expect object addresses as id")

perhaps also mention that hashing the full tuplehash includes
the hlist pointer address, which will change when a conntrack is placed
on the dying list -- this affects reliable delete event delivery --
on redelivery, the id will be different, so your commit is not
just an improvement, it also fixes a bug.

Thanks!
