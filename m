Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A3AC2529
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Sep 2019 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbfI3Qa6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Sep 2019 12:30:58 -0400
Received: from correo.us.es ([193.147.175.20]:45302 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbfI3Qa6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:30:58 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0E83D4A7061
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Sep 2019 18:30:54 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F40B2CA0F3
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Sep 2019 18:30:53 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E9CB1CE39C; Mon, 30 Sep 2019 18:30:53 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D6BBAB7FF2;
        Mon, 30 Sep 2019 18:30:51 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 30 Sep 2019 18:30:51 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id B5F7E42EF9E3;
        Mon, 30 Sep 2019 18:30:51 +0200 (CEST)
Date:   Mon, 30 Sep 2019 18:30:53 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 17/24] xtables-restore: Carry in_table in
 struct nft_xt_restore_parse
Message-ID: <20190930163053.m4vlsfmgjrp6jifo@salvia>
References: <20190925212605.1005-1-phil@nwl.cc>
 <20190925212605.1005-18-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925212605.1005-18-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 25, 2019 at 11:25:58PM +0200, Phil Sutter wrote:
> This is a requirement for outsourcing line parsing code into a dedicated
> function.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  iptables/nft-shared.h      |  1 +
>  iptables/xtables-restore.c | 17 ++++++++---------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
> index 9d62913461fa4..facad6d02a7ec 100644
> --- a/iptables/nft-shared.h
> +++ b/iptables/nft-shared.h
> @@ -237,6 +237,7 @@ struct nft_xt_restore_parse {
>  	int		testing;
>  	const char	*tablename;
>  	bool		commit;
> +	bool		in_table;

I don't think this belong here.

If you want to add a structure, then add something like:

struct nft_xt_parse_ctx {
        char    buffer[10240];
        char    *curtable;
        int     in_table;
};

to store all the internal context, not mix things like internal
parsing context with the object that describes the parser
configuration.
