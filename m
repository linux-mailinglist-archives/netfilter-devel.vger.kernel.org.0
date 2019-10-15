Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854C3D7A93
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 17:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfJOPxv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 11:53:51 -0400
Received: from correo.us.es ([193.147.175.20]:50004 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbfJOPxv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:53:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5AA40C1A10
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Oct 2019 17:53:46 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4B320DA840
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Oct 2019 17:53:46 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 49D2FDA7B6; Tue, 15 Oct 2019 17:53:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 42EE3B7FF2;
        Tue, 15 Oct 2019 17:53:44 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 15 Oct 2019 17:53:44 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 2060A42EE38E;
        Tue, 15 Oct 2019 17:53:44 +0200 (CEST)
Date:   Tue, 15 Oct 2019 17:53:46 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnftnl PATCH 4/6] set: Don't bypass checks in
 nftnl_set_set_u{32,64}()
Message-ID: <20191015155346.qgd55w7iypj44q6m@salvia>
References: <20191015141658.11325-1-phil@nwl.cc>
 <20191015141658.11325-5-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015141658.11325-5-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 15, 2019 at 04:16:56PM +0200, Phil Sutter wrote:
> By calling nftnl_set_set(), any data size checks are effectively
> bypassed. Better call nftnl_set_set_data() directly, passing the real
> size for validation.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>

Probably attribute((deprecated)) is better so we don't forget. Anyway,
we can probably nuke this function in the next release.

> ---
>  src/set.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/set.c b/src/set.c
> index e6db7258cc224..b1ffe7e6de975 100644
> --- a/src/set.c
> +++ b/src/set.c
> @@ -195,6 +195,7 @@ int nftnl_set_set_data(struct nftnl_set *s, uint16_t attr, const void *data,
>  	return 0;
>  }
>  
> +/* XXX: Deprecate this, it is simply unsafe */
>  EXPORT_SYMBOL(nftnl_set_set);
>  int nftnl_set_set(struct nftnl_set *s, uint16_t attr, const void *data)
>  {
> @@ -204,13 +205,13 @@ int nftnl_set_set(struct nftnl_set *s, uint16_t attr, const void *data)
>  EXPORT_SYMBOL(nftnl_set_set_u32);
>  void nftnl_set_set_u32(struct nftnl_set *s, uint16_t attr, uint32_t val)
>  {
> -	nftnl_set_set(s, attr, &val);
> +	nftnl_set_set_data(s, attr, &val, sizeof(uint32_t));
>  }
>  
>  EXPORT_SYMBOL(nftnl_set_set_u64);
>  void nftnl_set_set_u64(struct nftnl_set *s, uint16_t attr, uint64_t val)
>  {
> -	nftnl_set_set(s, attr, &val);
> +	nftnl_set_set_data(s, attr, &val, sizeof(uint64_t));
>  }
>  
>  EXPORT_SYMBOL(nftnl_set_set_str);
> -- 
> 2.23.0
> 
