Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1755528B56D
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Oct 2020 15:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgJLNDc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 12 Oct 2020 09:03:32 -0400
Received: from correo.us.es ([193.147.175.20]:53108 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgJLNDb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:03:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 295C6CE778
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 15:03:30 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1B4A0DA78E
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 15:03:30 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 10F29DA72F; Mon, 12 Oct 2020 15:03:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2BCC2DA730;
        Mon, 12 Oct 2020 15:03:28 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 12 Oct 2020 15:03:28 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0FAEE42EE38E;
        Mon, 12 Oct 2020 15:03:28 +0200 (CEST)
Date:   Mon, 12 Oct 2020 15:03:27 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] json: Fix memleak in set_dtype_json()
Message-ID: <20201012130327.GA27782@salvia>
References: <20201008171013.17076-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008171013.17076-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 08, 2020 at 07:10:13PM +0200, Phil Sutter wrote:
> Turns out json_string() already dups the input, so the temporary dup
> passed to it is lost.

LGTM.

> Fixes: e70354f53e9f6 ("libnftables: Implement JSON output support")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  src/json.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/json.c b/src/json.c
> index 121dfb247d967..a8824d3fc05a9 100644
> --- a/src/json.c
> +++ b/src/json.c
> @@ -62,7 +62,7 @@ static json_t *set_dtype_json(const struct expr *key)
>  
>  	tok = strtok(namedup, " .");
>  	while (tok) {
> -		json_t *jtok = json_string(xstrdup(tok));
> +		json_t *jtok = json_string(tok);
>  		if (!root)
>  			root = jtok;
>  		else if (json_is_string(root))
> -- 
> 2.28.0
> 
