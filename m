Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5436142BF
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 May 2019 00:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfEEWSx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 May 2019 18:18:53 -0400
Received: from mail.us.es ([193.147.175.20]:49520 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfEEWSw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 May 2019 18:18:52 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2538611ED80
        for <netfilter-devel@vger.kernel.org>; Mon,  6 May 2019 00:18:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 14560DA705
        for <netfilter-devel@vger.kernel.org>; Mon,  6 May 2019 00:18:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 09CEDDA702; Mon,  6 May 2019 00:18:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 013D9DA701;
        Mon,  6 May 2019 00:18:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 06 May 2019 00:18:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D0B4A4265A31;
        Mon,  6 May 2019 00:18:47 +0200 (CEST)
Date:   Mon, 6 May 2019 00:18:47 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Eric Garver <eric@garver.life>
Cc:     netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>
Subject: Re: [PATCH nft] evaluate: force full cache update on rule index
 translation
Message-ID: <20190505221847.72wvcyijkvrvxp6a@salvia>
References: <20190501163510.29723-1-eric@garver.life>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501163510.29723-1-eric@garver.life>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, May 01, 2019 at 12:35:10PM -0400, Eric Garver wrote:
> If we've done a partial fetch of the cache and the genid is the same the
> cache update will be skipped without fetching the rules. This causes the
> index to handle lookup to fail. To remedy the situation we flush the
> cache and force a full update.

@Eric: Would you mind to post a reproducer? I'd like to make a test
for tests/shell/ infrastructure to make sure future changes don't
break this.

@Phil: Not related to this, but do you think it would be good to
rework rule index insertion to support for NFTA_RULE_POSITION_ID?

Thanks!

> Fixes: 816d8c7659c1 ("Support 'add/insert rule index <IDX>'")
> Signed-off-by: Eric Garver <eric@garver.life>
> ---
>  src/evaluate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evaluate.c b/src/evaluate.c
> index 3593eb80a6a6..a2585291e7c4 100644
> --- a/src/evaluate.c
> +++ b/src/evaluate.c
> @@ -3182,7 +3182,11 @@ static int rule_translate_index(struct eval_ctx *ctx, struct rule *rule)
>  	struct rule *r;
>  	int ret;
>  
> -	/* update cache with CMD_LIST so that rules are fetched, too */
> +	/* Update cache with CMD_LIST so that rules are fetched, too. The explicit
> +	 * release is necessary because the genid may be the same, in which case
> +	 * the update would be a no-op.
> +	 */
> +	cache_release(&ctx->nft->cache);
>  	ret = cache_update(ctx->nft, CMD_LIST, ctx->msgs);
>  	if (ret < 0)
>  		return ret;
> -- 
> 2.20.1
> 
