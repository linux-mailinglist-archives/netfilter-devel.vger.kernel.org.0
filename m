Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9ED141949
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 21:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgARUBH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 15:01:07 -0500
Received: from correo.us.es ([193.147.175.20]:46176 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgARUBG (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:01:06 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A4D852EFEA6
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Jan 2020 21:01:04 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 94C1DDA707
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Jan 2020 21:01:04 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 88A9EDA701; Sat, 18 Jan 2020 21:01:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 83193DA702;
        Sat, 18 Jan 2020 21:01:02 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 18 Jan 2020 21:01:02 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2B2F841E4801;
        Sat, 18 Jan 2020 21:01:01 +0100 (CET)
Date:   Sat, 18 Jan 2020 21:01:01 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v4 2/4] netfilter: flowtable: add indr block
 setup support
Message-ID: <20200118200101.pgzyg7isgb6kc5wb@salvia>
References: <1578996040-6413-1-git-send-email-wenxu@ucloud.cn>
 <1578996040-6413-3-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578996040-6413-3-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jan 14, 2020 at 06:00:38PM +0800, wenxu@ucloud.cn wrote:
[...]
> @@ -891,10 +909,76 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
>  }
>  EXPORT_SYMBOL_GPL(nf_flow_table_offload_setup);
>  
> +static struct nf_flowtable *__nf_flow_table_offload_get(struct net_device *dev)
> +{
> +	struct nf_flowtable *n_flowtable;
> +	struct nft_flowtable *flowtable;
> +	struct net *net = dev_net(dev);
> +	struct nft_table *table;
> +	struct nft_hook *hook;
> +
> +	list_for_each_entry(table, &net->nft.tables, list) {
> +		list_for_each_entry(flowtable, &table->flowtables, list) {
> +			list_for_each_entry(hook, &flowtable->hook_list, list) {
> +				if (hook->ops.dev != dev)
> +					continue;
> +
> +				n_flowtable = &flowtable->data;
> +				return n_flowtable;
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}

This assumes that there is a one to one mapping between flowtable and
netdevices. Actually, there might be several flowtables to the same
netdevice.

I'm still looking, it will take me a while to figure out where to go,
please stay tuned.

Thank you.
