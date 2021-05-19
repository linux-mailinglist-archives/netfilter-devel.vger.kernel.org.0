Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2108538992A
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 May 2021 00:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhESWR1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 May 2021 18:17:27 -0400
Received: from mail.netfilter.org ([217.70.188.207]:46936 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhESWR1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 May 2021 18:17:27 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 52DEB64185;
        Thu, 20 May 2021 00:15:08 +0200 (CEST)
Date:   Thu, 20 May 2021 00:16:01 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     Ali Abdallah <ali.abdallah@suse.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] Avoid potentially erroneos RST drop.
Message-ID: <20210519221601.GA17278@salvia>
References: <20210430093601.zibczc4cjnwx3qwn@Fryzen495>
 <YJL30q7mCUezag48@strlen.de>
 <20210519120749.gd32rnaaz6q2kggr@Fryzen495>
 <20210519122332.GD8317@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519122332.GD8317@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 19, 2021 at 02:23:32PM +0200, Florian Westphal wrote:
> Ali Abdallah <ali.abdallah@suse.com> wrote:
[...]
> > https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210428130911.cteglt52r5if7ynp@Fryzen495/
> > https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210430093601.zibczc4cjnwx3qwn@Fryzen495/
> 
> I will send this patch for inclusion tomorrow or later today.
> 
> Pablo, please mark both patches as "Changes Requested".

Done.
