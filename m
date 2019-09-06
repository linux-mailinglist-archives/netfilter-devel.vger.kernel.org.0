Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F55AAFDD
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Sep 2019 02:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389986AbfIFAeR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Sep 2019 20:34:17 -0400
Received: from correo.us.es ([193.147.175.20]:34590 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733029AbfIFAeQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Sep 2019 20:34:16 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2CD1FDA387
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Sep 2019 02:34:13 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 201A0DA840
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Sep 2019 02:34:13 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 15EBADA72F; Fri,  6 Sep 2019 02:34:13 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E713FDA7B6;
        Fri,  6 Sep 2019 02:34:10 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 06 Sep 2019 02:34:10 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C6BEF4265A5A;
        Fri,  6 Sep 2019 02:34:10 +0200 (CEST)
Date:   Fri, 6 Sep 2019 02:34:12 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v3 3/4] netfilter: nf_tables_offload: add
 nft_offload_netdev_iterate function
Message-ID: <20190906003412.eftkpvvhqedmq3de@salvia>
References: <1567656019-6881-1-git-send-email-wenxu@ucloud.cn>
 <1567656019-6881-4-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567656019-6881-4-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:00:18PM +0800, wenxu@ucloud.cn wrote:
[...]
> +static void nft_indr_block_cb(struct net_device *dev,
> +			      flow_indr_block_bind_cb_t *cb, void *cb_priv,
> +			      enum flow_block_command cmd)
> +{
> +	struct net *net = dev_net(dev);
> +	struct nft_chain *chain;
> +
> +	mutex_lock(&net->nft.commit_mutex);
> +	chain = nft_offload_netdev_iterate(dev);

Ah, right, not an interator. Probably __nft_offload_get_basechain(dev) ?

The initial __nft_... suggests the reader that the mutex is required.

> +	if (chain) {
> +		struct nft_base_chain *basechain;
> +
> +		basechain = nft_base_chain(chain);
> +		nft_indr_block_ing_cmd(dev, basechain, cb, cb_priv, cmd);
> +	}
>  	mutex_unlock(&net->nft.commit_mutex);
>  }
>  
> -- 
> 1.8.3.1
> 
