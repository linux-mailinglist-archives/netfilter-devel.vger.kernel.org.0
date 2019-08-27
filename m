Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0629E5C5
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Aug 2019 12:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfH0Khx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Aug 2019 06:37:53 -0400
Received: from correo.us.es ([193.147.175.20]:45266 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfH0Khw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:37:52 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 277A867B9D
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Aug 2019 12:37:49 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 19AD8FB362
        for <netfilter-devel@vger.kernel.org>; Tue, 27 Aug 2019 12:37:49 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0F335CA0F3; Tue, 27 Aug 2019 12:37:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 16572DA8E8;
        Tue, 27 Aug 2019 12:37:47 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 27 Aug 2019 12:37:47 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id E7E3842EE393;
        Tue, 27 Aug 2019 12:37:46 +0200 (CEST)
Date:   Tue, 27 Aug 2019 12:37:47 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 05/14] nft: Fetch sets when updating rule cache
Message-ID: <20190827103747.ju3n5oci7de266au@salvia>
References: <20190821092602.16292-1-phil@nwl.cc>
 <20190821092602.16292-6-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821092602.16292-6-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:25:53AM +0200, Phil Sutter wrote:
> diff --git a/iptables/nft.c b/iptables/nft.c
> index 28e63aad15878..633c33ddddb15 100644
> --- a/iptables/nft.c
> +++ b/iptables/nft.c
> +static int set_list_fetch_elem_cb(struct nftnl_set *s, void *data)
> +{
> +        char buf[MNL_SOCKET_BUFFER_SIZE];
> +	struct nft_handle *h = data;
> +        struct nlmsghdr *nlh;
> +
> +	nlh = nftnl_nlmsg_build_hdr(buf, NFT_MSG_GETSETELEM, h->family,
> +				    NLM_F_DUMP, h->seq);
> +        nftnl_set_elems_nlmsg_build_payload(nlh, s);
> +
> +	return mnl_talk(h, nlh, set_elem_cb, s);

Weird indentation here.
