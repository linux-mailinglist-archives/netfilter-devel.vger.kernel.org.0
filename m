Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1905DB1ABB
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbfIMJ1U (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 05:27:20 -0400
Received: from correo.us.es ([193.147.175.20]:40588 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387623AbfIMJ1T (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:27:19 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7F9E739626C
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Sep 2019 11:27:15 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 71AABB8007
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Sep 2019 11:27:15 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6769EB8005; Fri, 13 Sep 2019 11:27:15 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6830BB7FFB;
        Fri, 13 Sep 2019 11:27:13 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 13 Sep 2019 11:27:13 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 45FDC42EE396;
        Fri, 13 Sep 2019 11:27:13 +0200 (CEST)
Date:   Fri, 13 Sep 2019 11:27:14 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf-next v3 14/18] netfilter: move nf_conntrack code to
 linux/nf_conntrack_common.h.
Message-ID: <20190913092714.tu37kmch6d3e6ypl@salvia>
References: <20190913081318.16071-1-jeremy@azazel.net>
 <20190913081318.16071-15-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913081318.16071-15-jeremy@azazel.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 13, 2019 at 09:13:14AM +0100, Jeremy Sowden wrote:
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
> index 88d4127df863..410809c669e1 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -1167,7 +1167,6 @@ static int __init nf_conntrack_standalone_init(void)
>  	if (ret < 0)
>  		goto out_start;
>  
> -	BUILD_BUG_ON(SKB_NFCT_PTRMASK != NFCT_PTRMASK);

Why do you need to remove this?

>  	BUILD_BUG_ON(NFCT_INFOMASK <= IP_CT_NUMBER);
>  
>  #ifdef CONFIG_SYSCTL
> -- 
> 2.23.0
> 
