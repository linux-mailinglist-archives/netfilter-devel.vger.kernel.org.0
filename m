Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA0F10E790
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Dec 2019 10:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLBJXP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Dec 2019 04:23:15 -0500
Received: from correo.us.es ([193.147.175.20]:38460 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfLBJXP (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:23:15 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 53EDB96ED5
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Dec 2019 10:23:12 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 446E5DA70C
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Dec 2019 10:23:12 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 39F10DA709; Mon,  2 Dec 2019 10:23:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 20F47DA703;
        Mon,  2 Dec 2019 10:23:10 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 02 Dec 2019 10:23:10 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id F04374265A5A;
        Mon,  2 Dec 2019 10:23:09 +0100 (CET)
Date:   Mon, 2 Dec 2019 10:23:10 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables_offload: Fix check the
 NETDEV_UNREGISTER in netdev event
Message-ID: <20191202092310.iu36uv66qyahsrou@salvia>
References: <1573618867-9755-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573618867-9755-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:21:07PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> It should check the NETDEV_UNREGISTER in  nft_offload_netdev_event
> 
> Fixes: 06d392cbe3db ("netfilter: nf_tables_offload: remove rules when the device unregisters")
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  net/netfilter/nf_tables_offload.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
> index e25dab8..b002832 100644
> --- a/net/netfilter/nf_tables_offload.c
> +++ b/net/netfilter/nf_tables_offload.c
> @@ -446,6 +446,9 @@ static int nft_offload_netdev_event(struct notifier_block *this,
>  	struct net *net = dev_net(dev);
>  	struct nft_chain *chain;
>  
> +	if (event != NETDEV_UNREGISTER)
> +		return 0;

Actually I cannot apply this.

        if (event != NETDEV_UNREGISTER &&
            event != NETDEV_CHANGENAME)
                return NOTIFY_DONE;

You also have to check for change name and use NOTIFY_DONE as return
value instead. Sorry.
