Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1688514DAE6
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Jan 2020 13:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgA3MoV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Jan 2020 07:44:21 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:46342 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727158AbgA3MoV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:44:21 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ix9BD-0004ei-C9; Thu, 30 Jan 2020 13:44:19 +0100
Date:   Thu, 30 Jan 2020 13:44:19 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de, pablo@netfilter.org,
        Manoj Basapathi <manojbm@codeaurora.org>
Subject: Re: [PATCH nf-next] netfilter: xtables: Add snapshot of
 hardidletimer target
Message-ID: <20200130124419.GG795@breakpoint.cc>
References: <1580344627-2452-1-git-send-email-subashab@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580344627-2452-1-git-send-email-subashab@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org> wrote:
> From: Manoj Basapathi <manojbm@codeaurora.org>
> 
> This is a snapshot of hardidletimer netfilter target.
> 
> This patch implements a hardidletimer Xtables target that can be
> used to identify when interfaces have been idle for a certain period
> of time.
> 
> Timers are identified by labels and are created when a rule is set
> with a new label. The rules also take a timeout value (in seconds) as
> an option. If more than one rule uses the same timer label, the timer
> will be restarted whenever any of the rules get a hit.
> 
> One entry for each timer is created in sysfs. This attribute contains
> the timer remaining for the timer to expire. The attributes are
> located under the xt_idletimer class:
> 
> /sys/class/xt_hardidletimer/timers/<label>
> 
> When the timer expires, the target module sends a sysfs notification
> to the userspace, which can then decide what to do (eg. disconnect to
> save power)
> 
> Compared to IDLETIMER, HARDIDLETIMER can send notifications when
> CPU is in suspend too, to notify the timer expiry.
> 
> v1->v2: Moved all functionality into IDLETIMER module to avoid
> code duplication per comment from Florian.
> 
> Signed-off-by: Manoj Basapathi <manojbm@codeaurora.org>
> Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
> ---
>  include/uapi/linux/netfilter/xt_IDLETIMER.h |  3 +
>  net/netfilter/xt_IDLETIMER.c                | 85 ++++++++++++++++++++++++++---
>  2 files changed, 79 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/netfilter/xt_IDLETIMER.h b/include/uapi/linux/netfilter/xt_IDLETIMER.h
> index 3c586a1..10a40bb 100644
> --- a/include/uapi/linux/netfilter/xt_IDLETIMER.h
> +++ b/include/uapi/linux/netfilter/xt_IDLETIMER.h
> @@ -33,12 +33,15 @@
>  #include <linux/types.h>
>  
>  #define MAX_IDLETIMER_LABEL_SIZE 28
> +#define XT_IDLETIMER_ALARM 0x01
>  
>  struct idletimer_tg_info {
>  	__u32 timeout;
>  
>  	char label[MAX_IDLETIMER_LABEL_SIZE];
>  
> +	__u8 timer_type;
> +

This breaks binary abi of idletimer_tg_info.

You will need to add a new target revision for this, i.e.
struct idletimer_tg_info_v1.

See net/netfilter/xt_CT.c for an example target that has
several revisions.
