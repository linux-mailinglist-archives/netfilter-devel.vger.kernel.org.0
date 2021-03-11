Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6D4338045
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Mar 2021 23:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCKWbV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Mar 2021 17:31:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36020 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCKWbM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:31:12 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id B56A84D0C0273;
        Thu, 11 Mar 2021 14:31:05 -0800 (PST)
Date:   Thu, 11 Mar 2021 14:31:01 -0800 (PST)
Message-Id: <20210311.143101.891849383248861921.davem@davemloft.net>
To:     pablo@netfilter.org
Cc:     kuba@kernel.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH net-next 00/23] netfilter: flowtable enhancements
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210311214505.GA5251@salvia>
References: <20210311003604.22199-1-pablo@netfilter.org>
        <20210311124705.0af44b8d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20210311214505.GA5251@salvia>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Thu, 11 Mar 2021 14:31:05 -0800 (PST)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Thu, 11 Mar 2021 22:45:05 +0100

> 
> I can extend the documentation to describe the invalidation problem in
> a follow up patch and to explicit state that this is not addressed at
> this stage.

Please do, thank you.
