Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3972A40D966
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Sep 2021 14:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbhIPMC0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Sep 2021 08:02:26 -0400
Received: from mail.netfilter.org ([217.70.188.207]:59216 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbhIPMC0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:02:26 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 43606606B6;
        Thu, 16 Sep 2021 13:59:51 +0200 (CEST)
Date:   Thu, 16 Sep 2021 14:01:00 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Martin Zatloukal <slezi2@pvfree.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: list vmap counter errot
Message-ID: <20210916120100.GA21799@salvia>
References: <ec914466-169b-b146-c216-e1faf1159068@pvfree.net>
 <20210916092702.GA31336@salvia>
 <d02072df-d5e5-b76d-0003-0a6ef62f5d00@pvfree.net>
 <20210916120005.GB11941@salvia>
 <20210916120027.GA21782@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916120027.GA21782@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 16, 2021 at 01:05:03PM +0200, Martin Zatloukal wrote:
[...]
> root@igw-test:~# cat /etc/firewall/test
> 
> #!/sbin/nft -f
> 
> flush ruleset
> 
> add table ip filter
> add chain ip filter FORWARD { type filter hook forward priority 0; policy
> drop; }
> 
> add map ip filter forwport { type ipv4_addr . inet_proto . inet_service:
> verdict; flags interval; counter;  }
> add rule ip filter FORWARD iifname enp0s8 ip daddr . ip protocol  . th dport
> vmap @forwport counter
> 
> add element ip filter forwport { 10.133.89.138 . tcp . 8081: accept }

Thanks, this repro is useful. I managed to reproduce it.

Fix it here:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210916115838.21724-1-pablo@netfilter.org/

Thanks for reporting.
