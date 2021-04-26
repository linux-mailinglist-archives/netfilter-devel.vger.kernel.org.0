Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC86936AA4B
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Apr 2021 03:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhDZBZf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Apr 2021 21:25:35 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49800 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhDZBZf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:25:35 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 46E7B605A8;
        Mon, 26 Apr 2021 03:24:18 +0200 (CEST)
Date:   Mon, 26 Apr 2021 03:24:51 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 00/12] netfilter: x_tables: remove
 ipt_unregister_table
Message-ID: <20210426012451.GA31030@salvia>
References: <20210421075110.19334-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421075110.19334-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:50:58AM +0200, Florian Westphal wrote:
> This change removes all xt_table pointers from struct net.
> 
> v2: fix "no previous prototype for 'ipt_unregister_table'" warning
> in patch 2.
> 
> The various ip(6)table_foo incarnations are updated to expect
> that the table is passed as 'void *priv' argument that netfilter core
> passes to the hook functions.
> 
> This reduces the struct net size by 2 cachelines on x86_64.

Series applied, thanks.
