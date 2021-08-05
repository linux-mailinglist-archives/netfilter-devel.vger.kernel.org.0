Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2D93E136A
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Aug 2021 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbhHELD4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Aug 2021 07:03:56 -0400
Received: from mail.netfilter.org ([217.70.188.207]:58638 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbhHELDz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:03:55 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id E166960043;
        Thu,  5 Aug 2021 13:03:02 +0200 (CEST)
Date:   Thu, 5 Aug 2021 13:03:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH nf] netfilter: conntrack: collect all entries in one cycle
Message-ID: <20210805110334.GA3995@salvia>
References: <20210726222919.5659-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210726222919.5659-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:29:19AM +0200, Florian Westphal wrote:
> Michal Kubecek reports that conntrack gc is responsible for frequent
> wakeups (every 125ms) on idle systems.
> 
> On busy systems, timed out entries are evicted during lookup.
> The gc worker is only needed to remove entries after system becomes idle
> after a busy period.
> 
> To resolve this, always scan the entire table.
> If the scan is taking too long, reschedule so other work_structs can run
> and resume from next bucket.
> 
> After a completed scan, wait for 2 minutes before the next cycle.
> Heuristics for faster re-schedule are removed.
> 
> GC_SCAN_INTERVAL could be exposed as a sysctl in the future to allow
> tuning this as-needed or even turn the gc worker off.

Applied, thanks.
