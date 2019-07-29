Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9077B799C9
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jul 2019 22:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfG2UUg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 29 Jul 2019 16:20:36 -0400
Received: from ja.ssi.bg ([178.16.129.10]:52836 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729250AbfG2UUg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:20:36 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id x6TKK6AN006015;
        Mon, 29 Jul 2019 23:20:06 +0300
Date:   Mon, 29 Jul 2019 23:20:06 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Florian Westphal <fw@strlen.de>
cc:     hujunwei <hujunwei4@huawei.com>, wensong@linux-vs.org,
        horms@verge.net.au, pablo@netfilter.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Mingfangsen <mingfangsen@huawei.com>, wangxiaogang3@huawei.com,
        xuhanbing@huawei.com
Subject: Re: [PATCH net] ipvs: Improve robustness to the ipvs sysctl
In-Reply-To: <20190729004958.GA19226@strlen.de>
Message-ID: <alpine.LFD.2.21.1907292305200.2909@ja.home.ssi.bg>
References: <1997375e-815d-137f-20c9-0829a8587ee9@huawei.com> <20190729004958.GA19226@strlen.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


	Hello,

On Mon, 29 Jul 2019, Florian Westphal wrote:

> > diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> > index 741d91aa4a8d..e78fd05f108b 100644
> > --- a/net/netfilter/ipvs/ip_vs_ctl.c
> > +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> > @@ -1680,12 +1680,18 @@ proc_do_defense_mode(struct ctl_table *table, int write,
> >  	int val = *valp;
> >  	int rc;
> > 
> > -	rc = proc_dointvec(table, write, buffer, lenp, ppos);
> > +	struct ctl_table tmp = {
> > +		.data = &val,
> > +		.maxlen = sizeof(int),
> > +		.mode = table->mode,
> > +	};
> > +
> > +	rc = proc_dointvec(&tmp, write, buffer, lenp, ppos);
> 
> Wouldn't it be better do use proc_dointvec_minmax and set the
> constraints via .extra1,2 in the sysctl knob definition?

	We store the 'ipvs' back-ptr in extra2, so may be we
can not use it in the table for proc_do_defense_mode, only for
tmp. proc_do_sync_mode may use extra1/2 in table for the
proc_dointvec_minmax call.

Regards

--
Julian Anastasov <ja@ssi.bg>
