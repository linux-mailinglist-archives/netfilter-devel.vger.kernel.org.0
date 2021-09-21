Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97FD412ABA
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Sep 2021 03:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhIUB5Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Sep 2021 21:57:16 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39646 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbhIUBt4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:49:56 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 38B4B63EB1;
        Tue, 21 Sep 2021 03:47:10 +0200 (CEST)
Date:   Tue, 21 Sep 2021 03:48:25 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 0/2] netfilter: nf_nat_masquerade: don't block rtnl
 lock
Message-ID: <YUk56VxnSw1FzeCD@salvia>
References: <20210915144639.25024-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210915144639.25024-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 15, 2021 at 04:46:37PM +0200, Florian Westphal wrote:
> nf_nat_masquerade registers conntrack notifiers to early-expire
> conntracks that have been using the downed device/removed address.
> 
> With large number of disappearing devices (ppp), iterating the table
> for every notification blocks the rtnl lock for multiple seconds.
> 
> This change unconditionally defers the walk to the system work queue
> so that rtnl lock is not blocked longer than needed.
> 
> This is not a regression, the notifier and cleanup walk have existed
> since the functionality was added more than 20 years ago.

Series applied, thanks.
