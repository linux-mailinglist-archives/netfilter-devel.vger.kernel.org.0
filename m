Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7D6A7500
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 22:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfICUew (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Sep 2019 16:34:52 -0400
Received: from correo.us.es ([193.147.175.20]:60036 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfICUev (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:34:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3A96CB6C65
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 22:34:48 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2D809B7FF9
        for <netfilter-devel@vger.kernel.org>; Tue,  3 Sep 2019 22:34:48 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 22B0BDA72F; Tue,  3 Sep 2019 22:34:48 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EF26EDA72F;
        Tue,  3 Sep 2019 22:34:45 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 03 Sep 2019 22:34:45 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id CEBA04265A5A;
        Tue,  3 Sep 2019 22:34:45 +0200 (CEST)
Date:   Tue, 3 Sep 2019 22:34:47 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [conntrack-tools PATCH] conntrack: Fix CIDR to mask conversion
 on Big Endian
Message-ID: <20190903203447.saqplkgbbxlajkqr@salvia>
References: <20190902164431.18398-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902164431.18398-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 02, 2019 at 06:44:31PM +0200, Phil Sutter wrote:
> Code assumed host architecture to be Little Endian. Instead produce a
> proper mask by pushing the set bits into most significant position and
> apply htonl() on the result.
> 
> Fixes: 3f6a2e90936bb ("conntrack: add support for CIDR notation")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  src/conntrack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/conntrack.c b/src/conntrack.c
> index c980a13f33d2c..baafcbd869c12 100644
> --- a/src/conntrack.c
> +++ b/src/conntrack.c
> @@ -2210,7 +2210,7 @@ nfct_build_netmask(uint32_t *dst, int b, int n)
>  			dst[i] = 0xffffffff;
>  			b -= 32;
>  		} else if (b > 0) {
> -			dst[i] = (1 << b) - 1;
> +			dst[i] = htonl(((1 << b) - 1) << (32 - b));

Simply this instead?

                        dst[i] = htonl(((1 << b) - 1);

>  			b = 0;
>  		} else {
>  			dst[i] = 0;
> -- 
> 2.22.0
> 
