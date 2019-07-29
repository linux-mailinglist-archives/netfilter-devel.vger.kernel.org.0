Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2259B782E7
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jul 2019 02:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfG2AuS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 28 Jul 2019 20:50:18 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:59626 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfG2AuS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:50:18 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hrtrY-000832-8H; Mon, 29 Jul 2019 02:50:04 +0200
Date:   Mon, 29 Jul 2019 02:49:58 +0200
From:   Florian Westphal <fw@strlen.de>
To:     hujunwei <hujunwei4@huawei.com>
Cc:     wensong@linux-vs.org, horms@verge.net.au, ja@ssi.bg,
        pablo@netfilter.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Mingfangsen <mingfangsen@huawei.com>, wangxiaogang3@huawei.com,
        xuhanbing@huawei.com
Subject: Re: [PATCH net] ipvs: Improve robustness to the ipvs sysctl
Message-ID: <20190729004958.GA19226@strlen.de>
References: <1997375e-815d-137f-20c9-0829a8587ee9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1997375e-815d-137f-20c9-0829a8587ee9@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

hujunwei <hujunwei4@huawei.com> wrote:

[ trimmed CC list ]

> The ipvs module parse the user buffer and save it to sysctl,
> then check if the value is valid. invalid value occurs
> over a period of time.
> Here, I add a variable, struct ctl_table tmp, used to read
> the value from the user buffer, and save only when it is valid.

Does this cause any problems?  If so, what are those?

> Fixes: f73181c8288f ("ipvs: add support for sync threads")
> Signed-off-by: Junwei Hu <hujunwei4@huawei.com>
> ---
>  net/netfilter/ipvs/ip_vs_ctl.c | 61 +++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 741d91aa4a8d..e78fd05f108b 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -1680,12 +1680,18 @@ proc_do_defense_mode(struct ctl_table *table, int write,
>  	int val = *valp;
>  	int rc;
> 
> -	rc = proc_dointvec(table, write, buffer, lenp, ppos);
> +	struct ctl_table tmp = {
> +		.data = &val,
> +		.maxlen = sizeof(int),
> +		.mode = table->mode,
> +	};
> +
> +	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);

Wouldn't it be better do use proc_dointvec_minmax and set the
constraints via .extra1,2 in the sysctl knob definition?
