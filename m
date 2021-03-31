Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A62350878
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Mar 2021 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhCaUqp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Mar 2021 16:46:45 -0400
Received: from mail.netfilter.org ([217.70.188.207]:48974 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhCaUqj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:46:39 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1421463E47;
        Wed, 31 Mar 2021 22:46:23 +0200 (CEST)
Date:   Wed, 31 Mar 2021 22:46:35 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        twoerner@redhat.com, tgraf@infradead.org, dan.carpenter@oracle.com,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
Subject: Re: [PATCH v5] audit: log nftables configuration change events once
 per table
Message-ID: <20210331204635.GA4634@salvia>
References: <28de34275f58b45fd4626a92ccae96b6d2b4e287.1616702731.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28de34275f58b45fd4626a92ccae96b6d2b4e287.1616702731.git.rgb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 26, 2021 at 01:38:59PM -0400, Richard Guy Briggs wrote:
> @@ -8006,12 +7966,65 @@ static void nft_commit_notify(struct net *net, u32 portid)
>  	WARN_ON_ONCE(!list_empty(&net->nft.notify_list));
>  }
>  
> +static int nf_tables_commit_audit_alloc(struct list_head *adl,
> +				 struct nft_table *table)
> +{
> +	struct nft_audit_data *adp;
> +
> +	list_for_each_entry(adp, adl, list) {
> +		if (adp->table == table)
> +			return 0;
> +	}
> +	adp = kzalloc(sizeof(*adp), GFP_KERNEL);
> +	if (!adp)
> +		return -ENOMEM;
> +	adp->table = table;
> +	INIT_LIST_HEAD(&adp->list);

This INIT_LIST_HEAD is not required for an object that is going to be
inserted into the 'adl' list.

> +	list_add(&adp->list, adl);

If no objections, I'll amend this patch. I'll include the UAF fix and
remove this unnecessary INIT_LIST_HEAD.
