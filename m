Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F461327
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Jul 2019 00:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGFWg1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Jul 2019 18:36:27 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:34570 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726731AbfGFWg1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Jul 2019 18:36:27 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hjtI8-0000n1-0n; Sun, 07 Jul 2019 00:36:24 +0200
Date:   Sun, 7 Jul 2019 00:36:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Yonatan Goldschmidt <yon.goldschmidt@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: Update obsolete comments referring to
 ip_conntrack
Message-ID: <20190706223624.5vqap4gnrb47yojq@breakpoint.cc>
References: <20190705085156.GA14117@jong.localdomain>
 <20190706222824.29550-1-yon.goldschmidt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706222824.29550-1-yon.goldschmidt@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Yonatan Goldschmidt <yon.goldschmidt@gmail.com> wrote:
> In 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.") the new
> generic nf_conntrack was introduced, and it came to supersede the
> old ip_conntrack.
> This change updates (some) of the obsolete comments referring to old
> file/function names of the ip_conntrack mechanism, as well as removes
> a few self-referencing comments that we shouldn't maintain anymore.
> 
> I did not update any comments referring to historical actions (e.g,
> comments like "this file was derived from ..." were left untouched,
> even if the referenced file is no longer here).

Looks good, thanks for following up.
