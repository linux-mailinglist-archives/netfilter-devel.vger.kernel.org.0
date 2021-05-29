Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5472E394E22
	for <lists+netfilter-devel@lfdr.de>; Sat, 29 May 2021 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhE2URs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 29 May 2021 16:17:48 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48716 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhE2URs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 29 May 2021 16:17:48 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 6FA57644D0;
        Sat, 29 May 2021 22:15:06 +0200 (CEST)
Date:   Sat, 29 May 2021 22:16:07 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH nf-next] netfilter: nft_compat: fix bridge family target
 evaluation
Message-ID: <20210529201607.GA31934@salvia>
References: <20210529165025.146435-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210529165025.146435-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, May 29, 2021 at 06:50:25PM +0200, Florian Westphal wrote:
> This always evals to true, so all packets get dropped in the ebtables
> compat layer. ip(6)tables is fine.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 6d6dbfe7fe1e6e1 ("netfilter: nf_tables: remove xt_action_param from nft_pktinfo")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Pablo, feel free to squash if you prefer that.

Squashed, thanks.
