Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E12A7442
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfICUGy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Sep 2019 16:06:54 -0400
Received: from correo.us.es ([193.147.175.20]:55958 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfICUGy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:06:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7AD47FC5E3
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 22:06:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6D7AAB7FFE
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 22:06:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 62D4DB7FF2; Tue,  3 Sep 2019 22:06:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3CBE5D2B1E;
        Tue,  3 Sep 2019 22:06:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 03 Sep 2019 22:06:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 1B4BC4265A5A;
        Tue,  3 Sep 2019 22:06:48 +0200 (CEST)
Date:   Tue, 3 Sep 2019 22:06:49 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     fw@strlen.de, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v3] netfilter: nf_table_offload: Fix the
 incorrect rcu usage in nft_indr_block_cb
Message-ID: <20190903200649.vmc5mh56dz3f3jlo@salvia>
References: <1567480527-27473-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567480527-27473-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 03, 2019 at 11:15:27AM +0800, wenxu@ucloud.cn wrote:
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> index 113ac40..ca9e0cb 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -357,11 +357,12 @@ static void nft_indr_block_cb(struct net_device *dev,
>  	const struct nft_table *table;
>  	const struct nft_chain *chain;
>  
> -	list_for_each_entry_rcu(table, &net->nft.tables, list) {
> +	mutex_lock(&net->nft.commit_mutex);
> +	list_for_each_entry(table, &net->nft.tables, list) {
>  		if (table->family != NFPROTO_NETDEV)
>  			continue;
>  
> -		list_for_each_entry_rcu(chain, &table->chains, list) {
> +		list_for_each_entry(chain, &table->chains, list) {
>  			if (!nft_is_base_chain(chain))
>  				continue;

nft_indr_block_cb() does not check for the offload flag in the
basechain...
