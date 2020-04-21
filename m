Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1776A1B2F92
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2020 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgDUSuw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Apr 2020 14:50:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53574 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgDUSuw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:50:52 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3D0EC128BE107;
        Tue, 21 Apr 2020 11:50:49 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:50:46 -0700 (PDT)
Message-Id: <20200421.115046.1408252671809654975.davem@davemloft.net>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] Netfilter fixes for net
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200421103759.959074-1-pablo@netfilter.org>
References: <20200421103759.959074-1-pablo@netfilter.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Apr 2020 11:50:49 -0700 (PDT)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Tue, 21 Apr 2020 12:37:57 +0200

> The following patchset contains Netfilter fixes for net:
> 
> 1) flow_block_cb memleak in nf_flow_table_offload_del_cb(), from Roi Dayan.
> 
> 2) Fix error path handling in nf_nat_inet_register_fn(), from Hillf Danton.
> 
> You can pull these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git

Pulled, thanks Pablo.
