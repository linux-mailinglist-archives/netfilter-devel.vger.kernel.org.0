Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BF261026
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Sep 2020 12:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgIHKmp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Sep 2020 06:42:45 -0400
Received: from correo.us.es ([193.147.175.20]:59878 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbgIHKmi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:42:38 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 97380190C87
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Sep 2020 12:42:27 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 87F05DA789
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Sep 2020 12:42:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7CCAEDA78A; Tue,  8 Sep 2020 12:42:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 76036DA844;
        Tue,  8 Sep 2020 12:42:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 08 Sep 2020 12:42:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 586234301DE1;
        Tue,  8 Sep 2020 12:42:25 +0200 (CEST)
Date:   Tue, 8 Sep 2020 12:42:25 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     "Jose M. Guisado Gomez" <guigom@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 1/3] netfilter: nf_tables: add userdata support
 for nft_object
Message-ID: <20200908104225.GA14876@salvia>
References: <20200902091241.1379-1-guigom@riseup.net>
 <20200902091241.1379-2-guigom@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902091241.1379-2-guigom@riseup.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:12:39AM +0200, Jose M. Guisado Gomez wrote:
> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 6ccce2a2e715..55111aefd3db 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
[...]
> @@ -5954,32 +5957,48 @@ static int nf_tables_newobj(struct net *net, struct sock *nlsk,
>  	obj->key.name = nla_strdup(nla[NFTA_OBJ_NAME], GFP_KERNEL);
>  	if (!obj->key.name) {
>  		err = -ENOMEM;
> -		goto err2;
> +		goto err_strdup;
> +	}
> +
> +	if(nla[NFTA_OBJ_USERDATA]) {
> +		udlen = nla_len(nla[NFTA_OBJ_USERDATA]);
> +		obj->udata = kzalloc(udlen, GFP_KERNEL);
> +		if (obj->udata == NULL)
> +			goto err_userdata;
> +	} else {
> +		obj->udata = NULL;
> +	}
> +
> +	if (udlen) {
> +		nla_memcpy(obj->udata, nla[NFTA_OBJ_USERDATA], udlen);
> +		obj->udlen = udlen;
>  	}

Probably simplify this?

	if(nla[NFTA_OBJ_USERDATA]) {
		udlen = nla_len(nla[NFTA_OBJ_USERDATA]);
		obj->udata = kzalloc(udlen, GFP_KERNEL);
		if (obj->udata == NULL)
			goto err_userdata;

        	nla_memcpy(obj->udata, nla[NFTA_OBJ_USERDATA], udlen);
        	obj->udlen = udlen;
        }

obj is allocated via kzalloc(), so obj->udata is already guaranteed to
be initialized to NULL, no need for the 'else' side of the branch.

Thanks.
