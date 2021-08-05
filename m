Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00153E13A5
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Aug 2021 13:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbhHELPC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Aug 2021 07:15:02 -0400
Received: from mail.netfilter.org ([217.70.188.207]:58676 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240777AbhHELPC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:15:02 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id DDDC260043;
        Thu,  5 Aug 2021 13:14:09 +0200 (CEST)
Date:   Thu, 5 Aug 2021 13:14:40 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, Oz Shlomo <ozsh@nvidia.com>,
        Paul Blakey <paulb@nvidia.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH v2 nf] netfilter: conntrack: remove offload_pickup sysctl
 again
Message-ID: <20210805111440.GA6246@salvia>
References: <20210804130215.3625-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804130215.3625-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 04, 2021 at 03:02:15PM +0200, Florian Westphal wrote:
> These two sysctls were added because the hardcoded defaults (2 minutes,
> tcp, 30 seconds, udp) turned out to be too low for some setups.
> 
> They appeared in 5.14-rc1 so it should be fine to remove it again.
> 
> Marcelo convinced me that there should be no difference between a flow
> that was offloaded vs. a flow that was not wrt. timeout handling.
> Thus the default is changed to those for TCP established and UDP stream,
> 5 days and 120 seconds, respectively.
> 
> Marcelo also suggested to account for the timeout value used for the
> offloading, this avoids increase beyond the value in the conntrack-sysctl
> and will also instantly expire the conntrack entry with altered sysctls.
> 
> Example:
>    nf_conntrack_udp_timeout_stream=60
>    nf_flowtable_udp_timeout=60
> 
> This will remove offloaded udp flows after one minute, rather than two.
> 
> An earlier version of this patch also cleared the ASSURED bit to
> allow nf_conntrack to evict the entry via early_drop (i.e., table full).
> However, it looks like we can safely assume that connection timed out
> via HW is still in established state, so this isn't needed.
> 
> Quoting Oz:
>  [..] the hardware sends all packets with a set FIN flags to sw.
>  [..] Connections that are aged in hardware are expected to be in the
>  established state.
> 
> In case it turns out that back-to-sw-path transition can occur for
> 'dodgy' connections too (e.g., one side disappeared while software-path
> would have been in RETRANS timeout), we can adjust this later.

Applied, thanks.
