Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE391419A6
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Jan 2020 21:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgARUoC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Jan 2020 15:44:02 -0500
Received: from correo.us.es ([193.147.175.20]:55786 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgARUoB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:44:01 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6E1D039626C
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Jan 2020 21:44:00 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 60BDEDA712
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Jan 2020 21:44:00 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5656DDA70F; Sat, 18 Jan 2020 21:44:00 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6DD00DA715;
        Sat, 18 Jan 2020 21:43:58 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 18 Jan 2020 21:43:58 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 50ACD41E4800;
        Sat, 18 Jan 2020 21:43:58 +0100 (CET)
Date:   Sat, 18 Jan 2020 21:43:57 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] src: Simplify struct pkt_buff: remove
 tail
Message-ID: <20200118204357.dg5b7qo5aqbesg4s@salvia>
References: <20200117113203.17313-1-duncan_roe@optusnet.com.au>
 <20200117140955.23823-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117140955.23823-1-duncan_roe@optusnet.com.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jan 18, 2020 at 01:09:55AM +1100, Duncan Roe wrote:
[...]
> diff --git a/src/internal.h b/src/internal.h
> index 0cfa425..dafb33a 100644
> --- a/src/internal.h
> +++ b/src/internal.h
> @@ -9,6 +9,7 @@
>  #else
>  #	define EXPORT_SYMBOL
>  #endif
> +#define PKTB_TAIL (pktb->data + pktb->len)

Instead of a macro, I'd suggest you add (something like):

static inline uint8_t *pktb_tail(struct pktbuff *pktb)
{
        return pktb->data + pktb->len;
}

Thanks.
