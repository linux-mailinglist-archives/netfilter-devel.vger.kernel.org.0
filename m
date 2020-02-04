Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C72151E76
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Feb 2020 17:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgBDQom (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Feb 2020 11:44:42 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:36410 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbgBDQom (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:44:42 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iz1JY-0004aA-O6; Tue, 04 Feb 2020 17:44:40 +0100
Date:   Tue, 4 Feb 2020 17:44:40 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Manoj Basapathi <manojbm@codeaurora.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de, pablo@netfilter.org,
        sharathv@qti.qualcomm.com, ssaha@qti.qualcomm.com,
        vidulak@qti.qualcomm.com, manojbm@qti.qualcomm.com,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Subject: Re: [PATCH] [nf-next v3] netfilter: xtables: Add snapshot of
 hardidletimer target
Message-ID: <20200204164440.GJ15904@breakpoint.cc>
References: <20200204112153.24063-1-manojbm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204112153.24063-1-manojbm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Manoj Basapathi <manojbm@codeaurora.org> wrote:
> +	} else {
> +		timer_setup(&info->timer->timer, idletimer_tg_expired, 0);
> +	mod_timer(&info->timer->timer,
> +		  msecs_to_jiffies(info->timeout * 1000) + jiffies);

Looks like indendation is off here.

> +static unsigned int idletimer_tg_target_v1(struct sk_buff *skb,
> +					 const struct xt_action_param *par)
> +{
> +	const struct idletimer_tg_info_v1 *info = par->targinfo;
> +
> +	pr_debug("resetting timer %s, timeout period %u\n",
> +		 info->label, info->timeout);
> +
> +	if (info->timer->timer_type & XT_IDLETIMER_ALARM) {
> +		ktime_t tout = ktime_set(info->timeout, 0);
> +		alarm_start_relative(&info->timer->alarm, tout);
> +	} else {
> +	mod_timer(&info->timer->timer,
> +		  msecs_to_jiffies(info->timeout * 1000) + jiffies);

and here, then again later on.

> +static int idletimer_tg_checkentry_v1(const struct xt_tgchk_param *par)
> +{
> +	struct idletimer_tg_info_v1 *info = par->targinfo;
> +	int ret;
> +
> +	pr_debug("checkentry targinfo%s\n", info->label);
> +
> +	if (info->timeout == 0) {
> +		pr_debug("timeout value is zero\n");
> +		return -EINVAL;
> +	}
> +	if (info->timeout >= INT_MAX / 1000) {
> +		pr_debug("timeout value is too big\n");
> +		return -EINVAL;
> +	}
> +	if (info->label[0] == '\0' ||
> +		strnlen(info->label,
> +			MAX_IDLETIMER_LABEL_SIZE) == MAX_IDLETIMER_LABEL_SIZE) {
> +		pr_debug("label is empty or not nul-terminated\n");
> +		return -EINVAL;
> +	}
> +
> +	if (info->timer_type > XT_IDLETIMER_ALARM) {
> +		pr_debug("invalid value for timer type\n");
> +		return -EINVAL;
> +	}
> +

This looks like a lot of code duplication with v0 version of the target.
Any chance for code re-use?

The v1 struct you made is cast-able to v0 for timeout and label checks,
so you could try and split that to a helper that you can then call from
existing checkentry and the new one.

You can do this in a preparation patch.

Rest looks fine to me.
