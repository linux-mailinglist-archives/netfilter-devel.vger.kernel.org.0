Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31033C92D4
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Oct 2019 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfJBUXf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Oct 2019 16:23:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36568 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfJBUXf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:23:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 12C6415502E62;
        Wed,  2 Oct 2019 13:23:35 -0700 (PDT)
Date:   Wed, 02 Oct 2019 13:23:34 -0700 (PDT)
Message-Id: <20191002.132334.2195253982240577012.davem@davemloft.net>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] Netfilter fixes for net
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191002185345.3137-1-pablo@netfilter.org>
References: <20191002185345.3137-1-pablo@netfilter.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 02 Oct 2019 13:23:35 -0700 (PDT)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Wed,  2 Oct 2019 20:53:43 +0200

> The following patchset contains Netfilter fixes for net:
> 
> 1) Remove the skb_ext_del from nf_reset, and renames it to a more
>    fitting nf_reset_ct(). Patch from Florian Westphal.
> 
> 2) Fix deadlock in nft_connlimit between packet path updates and
>    the garbage collector.
> 
> You can pull these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git

Pulled, thanks Pablo.
