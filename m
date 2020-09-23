Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734FB275713
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Sep 2020 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIWLUs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Sep 2020 07:20:48 -0400
Received: from correo.us.es ([193.147.175.20]:39098 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWLUr (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:20:47 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 20DCBDA708
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Sep 2020 13:20:45 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1019BDA84D
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Sep 2020 13:20:45 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 05B30DA84B; Wed, 23 Sep 2020 13:20:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0F41FDA704;
        Wed, 23 Sep 2020 13:20:43 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 23 Sep 2020 13:20:43 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E784E4301DE0;
        Wed, 23 Sep 2020 13:20:42 +0200 (CEST)
Date:   Wed, 23 Sep 2020 13:20:42 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Jose M. Guisado" <guigom@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2 nf-next] netfilter: nf_tables: add userdata attributes
 to nft_chain
Message-ID: <20200923112042.GB3218@salvia>
References: <20200923105517.1480-1-guigom@riseup.net>
 <20200923112007.GA3218@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923112007.GA3218@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:55:17PM +0200, Jose M. Guisado Gomez wrote:
> @@ -2079,15 +2098,21 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
>  	err = nft_chain_add(table, chain);
>  	if (err < 0) {
>  		nft_trans_destroy(trans);
> -		goto err2;
> +		goto err_chain_add;
>  	}
>  
>  	table->use++;
>  
>  	return 0;
> -err2:
> +err_chain_add:
> +err_trans:

I suggest to replace these two tags by:

err_unregister_hook:

>  	nf_tables_unregister_hook(net, table, chain);
> -err1:
> +err_register_hook:
> +err_alloc_rules:

and these two above by:

err_free_udata:

> +	kfree(chain->udata);
> +err_userdata:
> +err_chain_name:
> +err_flag:

and these three by:

err_destroy_chain:

>  	nf_tables_chain_destroy(ctx);
>  
>  	return err;

Thanks.
