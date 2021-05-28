Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC892394190
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 May 2021 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbhE1LAM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 May 2021 07:00:12 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51538 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbhE1LAG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 May 2021 07:00:06 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 04354644D9;
        Fri, 28 May 2021 12:57:27 +0200 (CEST)
Date:   Fri, 28 May 2021 12:58:28 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/6] netfilter: reduce size of core data
 structures
Message-ID: <20210528105828.GA15924@salvia>
References: <20210528103008.17425-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210528103008.17425-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, May 28, 2021 at 12:30:02PM +0200, Florian Westphal wrote:
> This series reduces a few data structures by moving
> members around or switching to a smaller type.
> 
> Also, this removes xt_action_param from nft_pktinfo,
> the former can be inited on-stack when needed in the nft_compat
> expression.

Series applied, thanks.
