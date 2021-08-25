Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F213F7406
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Aug 2021 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbhHYLGj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Aug 2021 07:06:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51404 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhHYLGj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:06:39 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1982360100;
        Wed, 25 Aug 2021 13:04:58 +0200 (CEST)
Date:   Wed, 25 Aug 2021 13:05:48 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/5] netfilter: ecache: simplify event
 registration
Message-ID: <20210825110548.GA3434@salvia>
References: <20210816151626.28770-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210816151626.28770-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:16:21PM +0200, Florian Westphal wrote:
> This patchset simplifies event registration handling.
> 
> Event and expectation handler registration is merged into one.
> This reduces boilerplate code during netns register/unregister.
> 
> Also, there is only one implementation of the event handler
> (ctnetlink), so it makes no sense to return -EBUSY if another
> handler is registered already -- it cannot happen.
> 
> This also allows to remove the 'nf_exp_event_notifier' pointer
> from struct net.

Series applied, thanks.
