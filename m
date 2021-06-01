Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B5394C68
	for <lists+netfilter-devel@lfdr.de>; Sat, 29 May 2021 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhE2ONl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 29 May 2021 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhE2ONk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 29 May 2021 10:13:40 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8545CC061574
        for <netfilter-devel@vger.kernel.org>; Sat, 29 May 2021 07:12:04 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1lmzh2-0000Ks-Es; Sat, 29 May 2021 16:12:00 +0200
Date:   Sat, 29 May 2021 16:12:00 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH] netfilter: conntrack: remove the repeated declaration
Message-ID: <20210529141200.GB10732@breakpoint.cc>
References: <1622270966-36196-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622270966-36196-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> Variable 'nf_conntrack_net_id' is declared twice, so remove the
> repeated declaration.

Reviewed-by: Florian Westphal <fw@strlen.de>
