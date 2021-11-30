Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5EA464124
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Nov 2021 23:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344916AbhK3WRO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Nov 2021 17:17:14 -0500
Received: from mail.netfilter.org ([217.70.188.207]:52060 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344811AbhK3WQm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:16:42 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id C06F8607C3;
        Tue, 30 Nov 2021 23:11:04 +0100 (CET)
Date:   Tue, 30 Nov 2021 23:13:17 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH nf] netfilter: nfnetlink_queue: silence bogus compiler
 warning
Message-ID: <Yaah/QNsGOdZoi3Q@salvia>
References: <20211126120403.12253-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211126120403.12253-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 26, 2021 at 01:04:03PM +0100, Florian Westphal wrote:
> net/netfilter/nfnetlink_queue.c:601:36: warning: variable 'ctinfo' is
> uninitialized when used here [-Wuninitialized]
>    if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
> 
> ctinfo is only uninitialized if ct == NULL.  Init it to 0 to silence this.

Applied, thanks
