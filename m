Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7BB18C06F
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Mar 2020 20:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCSTcR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Mar 2020 15:32:17 -0400
Received: from correo.us.es ([193.147.175.20]:59968 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgCSTcR (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:32:17 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2EB34E0439
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Mar 2020 20:31:43 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1F75EFC5EA
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Mar 2020 20:31:43 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1511FFC5E0; Thu, 19 Mar 2020 20:31:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 153A1FC5E4;
        Thu, 19 Mar 2020 20:31:41 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 19 Mar 2020 20:31:41 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id EB1FA42EFB80;
        Thu, 19 Mar 2020 20:31:40 +0100 (CET)
Date:   Thu, 19 Mar 2020 20:32:11 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 4/4] nft_set_rbtree: Detect partial overlaps on
 insertion
Message-ID: <20200319193211.fcv6xg6mtr3t3mez@salvia>
References: <cover.1583438771.git.sbrivio@redhat.com>
 <e6f84fe980f55dde272f7c17e2423390a03e942d.1583438771.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f84fe980f55dde272f7c17e2423390a03e942d.1583438771.git.sbrivio@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Stefano,

Sorry for the late response to this one.

On Thu, Mar 05, 2020 at 09:33:05PM +0100, Stefano Brivio wrote:
> @@ -223,17 +258,40 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
>  		d = memcmp(nft_set_ext_key(&rbe->ext),
>  			   nft_set_ext_key(&new->ext),
>  			   set->klen);
> -		if (d < 0)
> +		if (d < 0) {
>  			p = &parent->rb_left;
> -		else if (d > 0)
> +
> +			if (nft_rbtree_interval_start(new)) {
> +				overlap = nft_rbtree_interval_start(rbe) &&
> +					  nft_set_elem_active(&rbe->ext,
> +							      genmask);
> +			} else {
> +				overlap = nft_rbtree_interval_end(rbe) &&
> +					  nft_set_elem_active(&rbe->ext,
> +							      genmask);
> +			}
> +		} else if (d > 0) {
>  			p = &parent->rb_right;
> -		else {
> +
> +			if (nft_rbtree_interval_end(new)) {
> +				overlap = nft_rbtree_interval_end(rbe) &&
> +					  nft_set_elem_active(&rbe->ext,
> +							      genmask);
> +			} else if (nft_rbtree_interval_end(rbe) &&
> +				   nft_set_elem_active(&rbe->ext, genmask)) {
> +				overlap = true;
> +			}
> +		} else {
>  			if (nft_rbtree_interval_end(rbe) &&
>  			    nft_rbtree_interval_start(new)) {
>  				p = &parent->rb_left;
> +

Instead of this inconditional reset of 'overlap':

> +				overlap = false;

I think this should be:

                        if (nft_set_elem_active(&rbe->ext, genmask))
        			overlap = false;

if the existing rbe is active, then reset 'overlap' to false.
