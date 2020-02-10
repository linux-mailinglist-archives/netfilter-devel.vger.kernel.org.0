Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703B8158598
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Feb 2020 23:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJWcA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Feb 2020 17:32:00 -0500
Received: from correo.us.es ([193.147.175.20]:56218 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgBJWcA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:32:00 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BB2A5E8B6C
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Feb 2020 23:31:57 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AE6A8DA705
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Feb 2020 23:31:57 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A368DDA702; Mon, 10 Feb 2020 23:31:57 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 962BCDA709;
        Mon, 10 Feb 2020 23:31:55 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 10 Feb 2020 23:31:55 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 77BB5426CCB9;
        Mon, 10 Feb 2020 23:31:55 +0100 (CET)
Date:   Mon, 10 Feb 2020 23:31:53 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Laurent Fasnacht <fasnacht@protonmail.ch>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft include v2 7/7] scanner: remove
 parser_state->indesc_idx
Message-ID: <20200210223153.siwzx76uhnxurkj2@salvia>
References: <20200210101709.9182-1-fasnacht@protonmail.ch>
 <20200210101709.9182-8-fasnacht@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210101709.9182-8-fasnacht@protonmail.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:17:28AM +0000, Laurent Fasnacht wrote:
> Now that we have a proper stack implementation, we don't need an
> additional counter for the number of buffer state pushed.
> 
> Signed-off-by: Laurent Fasnacht <fasnacht@protonmail.ch>
> ---
>  include/parser.h | 1 -
>  src/scanner.l    | 6 ------
>  2 files changed, 7 deletions(-)
> 
> diff --git a/include/parser.h b/include/parser.h
> index 66db92d8..636d1c88 100644
> --- a/include/parser.h
> +++ b/include/parser.h
> @@ -15,7 +15,6 @@
>  
>  struct parser_state {
>  	struct input_descriptor		*indesc;
> -	unsigned int			indesc_idx;
>  	struct list_head		indesc_list;
>  
>  	struct list_head		*msgs;
> diff --git a/src/scanner.l b/src/scanner.l
> index 8407a2a1..39e7ae0f 100644
> --- a/src/scanner.l
> +++ b/src/scanner.l
> @@ -674,12 +674,10 @@ static void scanner_push_indesc(struct parser_state *state,
>  		list_add(&indesc->list, &state->indesc->list);
>  	}
>  	state->indesc = indesc;
> -	state->indesc_idx++;
>  }
>  
>  static void scanner_pop_indesc(struct parser_state *state)
>  {
> -	state->indesc_idx--;
>  	if (!list_empty(&state->indesc_list)) {
>  		state->indesc = list_entry(state->indesc->list.prev, struct input_descriptor, list);
>  	} else {
> @@ -968,10 +966,6 @@ void scanner_destroy(struct nft_ctx *nft)
>  {
>  	struct parser_state *state = yyget_extra(nft->scanner);
>  
> -	do {
> -		yypop_buffer_state(nft->scanner);

nft_pop_buffer_state calls free().

Are you sure this can be removed without incurring in memleaks?

Thanks.

> -	} while (state->indesc_idx--);
> -
>  	input_descriptor_list_destroy(state);
>  	yylex_destroy(nft->scanner);
>  }
> -- 
> 2.20.1
> 
> 
