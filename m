Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE50C258F
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Sep 2019 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfI3Q5n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Sep 2019 12:57:43 -0400
Received: from correo.us.es ([193.147.175.20]:33044 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbfI3Q5n (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:57:43 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BBAB4E34CB
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Sep 2019 18:57:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AD833FB362
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Sep 2019 18:57:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A264BCE17F; Mon, 30 Sep 2019 18:57:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9EBC7B8004;
        Mon, 30 Sep 2019 18:57:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 30 Sep 2019 18:57:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6E41A42EF9E0;
        Mon, 30 Sep 2019 18:57:37 +0200 (CEST)
Date:   Mon, 30 Sep 2019 18:57:39 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 08/24] nft: Fetch only chains in
 nft_chain_list_get()
Message-ID: <20190930165739.wr3f3tsysi5ghbga@salvia>
References: <20190925212605.1005-1-phil@nwl.cc>
 <20190925212605.1005-9-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925212605.1005-9-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 25, 2019 at 11:25:49PM +0200, Phil Sutter wrote:
> @@ -2238,6 +2259,8 @@ nft_rule_find(struct nft_handle *h, struct nftnl_chain *c, void *data, int rulen
>  	struct nftnl_rule_iter *iter;
>  	bool found = false;
>  
> +	fetch_rule_cache(h, c);

fetch_rule_cache() does not perform any cache consistency check. This
function is good to be called from nft_build_cache() path. However, if
you call it away from it, you have to be sure the cache you are ending
up with is consistency. There are several netlink dump operations in a
row in fetch_rule_cache(), this is likely to happen I'm afraid.
