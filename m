Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7CF2A0E24
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Oct 2020 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgJ3SzZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 30 Oct 2020 14:55:25 -0400
Received: from correo.us.es ([193.147.175.20]:46054 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgJ3SzZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:55:25 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2CD6389605
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Oct 2020 19:55:23 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1DC46DA730
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Oct 2020 19:55:23 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 13563DA704; Fri, 30 Oct 2020 19:55:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E0424DA73F;
        Fri, 30 Oct 2020 19:55:20 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 30 Oct 2020 19:55:20 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C435442EF42C;
        Fri, 30 Oct 2020 19:55:20 +0100 (CET)
Date:   Fri, 30 Oct 2020 19:55:20 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     timon.ulrich@kabelmail.de
Cc:     Timon Ulrich <t.ulrich@anapur.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] raw2packet: fix comma instead of semicolon
Message-ID: <20201030185520.GA31879@salvia>
References: <20201030143047.307-1-timon.ulrich@kabelmail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201030143047.307-1-timon.ulrich@kabelmail.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 30, 2020 at 03:30:47PM +0100, timon.ulrich@kabelmail.de wrote:
> From: Timon Ulrich <t.ulrich@anapur.de>

Applied, thanks.

> Signed-off-by: Timon Ulrich <t.ulrich@anapur.de>
> ---
>  filter/raw2packet/ulogd_raw2packet_BASE.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/filter/raw2packet/ulogd_raw2packet_BASE.c b/filter/raw2packet/ulogd_raw2packet_BASE.c
> index fd2665a..9117d27 100644
> --- a/filter/raw2packet/ulogd_raw2packet_BASE.c
> +++ b/filter/raw2packet/ulogd_raw2packet_BASE.c
> @@ -905,7 +905,7 @@ static int _interp_arp(struct ulogd_pluginstance *pi, uint32_t len)
>  	okey_set_u16(&ret[KEY_ARP_OPCODE], ntohs(arph->arp_op));
>  
>  	okey_set_ptr(&ret[KEY_ARP_SHA], (void *)&arph->arp_sha);
> -	okey_set_ptr(&ret[KEY_ARP_SPA], (void *)&arph->arp_spa),
> +	okey_set_ptr(&ret[KEY_ARP_SPA], (void *)&arph->arp_spa);
>  	okey_set_ptr(&ret[KEY_ARP_THA], (void *)&arph->arp_tha);
>  	okey_set_ptr(&ret[KEY_ARP_TPA], (void *)&arph->arp_tpa);
>  
> -- 
> 2.17.1
> 
> 
