Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366EF34F498
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Mar 2021 00:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhC3WvE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Mar 2021 18:51:04 -0400
Received: from mail.netfilter.org ([217.70.188.207]:46462 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhC3Wu6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:50:58 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4AAE163E4D;
        Wed, 31 Mar 2021 00:50:43 +0200 (CEST)
Date:   Wed, 31 Mar 2021 00:50:55 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, phil@nwl.cc
Subject: Re: [PATCH 0/8] netfilter: merge nf_log_proto modules
Message-ID: <20210330225055.GA14374@salvia>
References: <20210325172512.17729-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325172512.17729-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 25, 2021 at 06:25:04PM +0100, Florian Westphal wrote:
> Netfilter has multiple log modules:
>  nf_log_arp
>  nf_log_bridge
>  nf_log_ipv4
>  nf_log_ipv6
>  nf_log_netdev
>  nfnetlink_log
>  nf_log_common
> 
> With the exception of nfnetlink_log (packet is sent to userspace for
> dissection/logging) all of them log to the kernel ringbuffer.
> 
> This series merges all modules except nfnetlink_log into a single
> module, nf_log_syslog.
> 
> After the series, only two log modules remain:
> nfnetlink_log and nf_log_syslog. The latter provides the same
> functionality as the old per-af log modules.
> 
> Last patch allows to move log backend module load
> to nft_log to avoid a deadlock that can occur when request_module()
> is called with the nft transaction mutex held.

Series applied to nf-next, thanks.
