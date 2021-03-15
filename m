Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73F533C4C1
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Mar 2021 18:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhCORmb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 Mar 2021 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhCORmW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:42:22 -0400
X-Greylist: delayed 110955 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Mar 2021 10:42:21 PDT
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5FFBC06174A;
        Mon, 15 Mar 2021 10:42:21 -0700 (PDT)
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id C272D63535;
        Mon, 15 Mar 2021 18:42:18 +0100 (CET)
Date:   Mon, 15 Mar 2021 18:42:17 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     kadlec@netfilter.org, fw@strlen.de, subashab@codeaurora.org,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Don't use RCU for x_tables synchronization
Message-ID: <20210315174217.GA25425@salvia>
References: <20210308012413.14383-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308012413.14383-1-mark.tomlinson@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Mar 08, 2021 at 02:24:10PM +1300, Mark Tomlinson wrote:
> The patches to change to using RCU synchronization in x_tables cause
> updating tables to be slowed down by an order of magnitude. This has
> been tried before, see https://lore.kernel.org/patchwork/patch/151796/
> and ultimately was rejected. As mentioned in the patch description, a
> different method can be used to ensure ordering of reads/writes. This
> can simply be done by changing from smp_wmb() to smp_mb().

Applied.
