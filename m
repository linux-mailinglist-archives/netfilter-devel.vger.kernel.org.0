Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C3923B0A7
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Aug 2020 01:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgHCXDi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 3 Aug 2020 19:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgHCXDi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:03:38 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248C2C06174A;
        Mon,  3 Aug 2020 16:03:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5D4EF12779195;
        Mon,  3 Aug 2020 15:46:52 -0700 (PDT)
Date:   Mon, 03 Aug 2020 16:03:36 -0700 (PDT)
Message-Id: <20200803.160336.2163577709608656066.davem@davemloft.net>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/7] Netfilter updates for net-next
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200802183149.2808-1-pablo@netfilter.org>
References: <20200802183149.2808-1-pablo@netfilter.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Aug 2020 15:46:52 -0700 (PDT)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Sun,  2 Aug 2020 20:31:41 +0200

> 1) UAF in chain binding support from previous batch, from Dan Carpenter.
> 
> 2) Queue up delayed work to expire connections with no destination,
>    from Andrew Sy Kim.
> 
> 3) Use fallthrough pseudo-keyword, from Gustavo A. R. Silva.
> 
> 4) Replace HTTP links with HTTPS, from Alexander A. Klimov.
> 
> 5) Remove superfluous null header checks in ip6tables, from
>    Gaurav Singh.
> 
> 6) Add extended netlink error reporting for expression.
> 
> 7) Report EEXIST on overlapping chain, set elements and flowtable
>    devices.
> 
> Please, pull these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next.git

Pulled, thank you.
