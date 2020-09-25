Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3893E27898B
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Sep 2020 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgIYN2g (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 25 Sep 2020 09:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgIYN2g (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:28:36 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D83C0613CE
        for <netfilter-devel@vger.kernel.org>; Fri, 25 Sep 2020 06:28:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kLnm6-0005FZ-Pt; Fri, 25 Sep 2020 15:28:34 +0200
Date:   Fri, 25 Sep 2020 15:28:34 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/8] Fast bulk transfers of large sets of ct entries
Message-ID: <20200925132834.GC31471@breakpoint.cc>
References: <20200925124919.9389-1-mikhail.sennikovskii@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925124919.9389-1-mikhail.sennikovskii@cloud.ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com> wrote:
> In addition to this I have a question about the behavioural change
> of the "conntrack -L" done after conntrack v1.4.5.
> With the conntrack v1.4.5 used on Debian Buster the "conntrack -L"
> dumps both ipv4 and ipv6 ct entries, while with the current master, 
> presumably starting with the commit 2bcbae4c14b253176d7570e6f6acc56e521ceb5e 
> "conntrack -L" �only dumps ipv4 entries.
> 
> So is this really the desired behavior? 

I'd like conntrack to dump both by default.
