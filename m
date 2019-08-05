Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0518156C
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Aug 2019 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfHEJ1X (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Aug 2019 05:27:23 -0400
Received: from correo.us.es ([193.147.175.20]:56002 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfHEJ1W (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:27:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4AF9ABA1A6
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Aug 2019 11:27:20 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3AA5D1150DD
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Aug 2019 11:27:20 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2FE7C1150D8; Mon,  5 Aug 2019 11:27:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 005BCA8EF;
        Mon,  5 Aug 2019 11:27:18 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 05 Aug 2019 11:27:18 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (149.103.108.93.rev.vodafone.pt [93.108.103.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 501E24265A31;
        Mon,  5 Aug 2019 11:27:17 +0200 (CEST)
Date:   Mon, 5 Aug 2019 11:26:49 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michael Braun <michael-dev@fami-braun.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] netfilter: nfnetlink_log:add support for VLAN information
Message-ID: <20190805092649.phaocwxkktfqbgqz@salvia>
References: <20190805072814.14922-1-michael-dev@fami-braun.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805072814.14922-1-michael-dev@fami-braun.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:28:14AM +0200, Michael Braun wrote:
> Currently, there is no vlan information (e.g. when used with a vlan aware
> bridge) passed to userspache, HWHEADER will contain an 08 00 (ip) suffix
> even for tagged ip packets.
> 
> Therefore, add an extra netlink attribute that passes the vlan tag to
> userspace. Userspace might need to handle PCP/DEI included in this field.
> 
> Signed-off-by: Michael Braun <michael-dev@fami-braun.de>
> ---
>  include/uapi/linux/netfilter/nfnetlink_log.h | 1 +
>  net/netfilter/nf_log_common.c                | 2 ++
>  net/netfilter/nfnetlink_log.c                | 6 ++++++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/include/uapi/linux/netfilter/nfnetlink_log.h b/include/uapi/linux/netfilter/nfnetlink_log.h
> index 20983cb195a0..d15f74d47f48 100644
> --- a/include/uapi/linux/netfilter/nfnetlink_log.h
> +++ b/include/uapi/linux/netfilter/nfnetlink_log.h
> @@ -54,6 +54,7 @@ enum nfulnl_attr_type {
>  	NFULA_HWLEN,			/* hardware header length */
>  	NFULA_CT,                       /* nf_conntrack_netlink.h */
>  	NFULA_CT_INFO,                  /* enum ip_conntrack_info */
> +	NFULA_VLAN_TAG,                 /* __u16 vlan tag */

Nitpick: Would you rename this to NFULA_VLAN_TCI? Both fields in the
vlan header refer to tag, either for protocol or control.

Thanks.
