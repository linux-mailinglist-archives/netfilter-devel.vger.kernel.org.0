Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6211A27FEEA
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Oct 2020 14:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgJAM0n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 1 Oct 2020 08:26:43 -0400
Received: from correo.us.es ([193.147.175.20]:49472 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731888AbgJAM0m (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 1 Oct 2020 08:26:42 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 913CDB56ED
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Oct 2020 14:26:41 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 83905DA73D
        for <netfilter-devel@vger.kernel.org>; Thu,  1 Oct 2020 14:26:41 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 79421DA791; Thu,  1 Oct 2020 14:26:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 643B7DA78D;
        Thu,  1 Oct 2020 14:26:39 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 01 Oct 2020 14:26:39 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 46D3242EF9E4;
        Thu,  1 Oct 2020 14:26:39 +0200 (CEST)
Date:   Thu, 1 Oct 2020 14:26:38 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Devin Bayer <dev@doubly.so>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] nft: migrate man page examples with `meter` directive to
 sets
Message-ID: <20201001122638.GA17685@salvia>
References: <b35b744f-a29c-d76b-6969-8cf6371c2a1a@doubly.so>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b35b744f-a29c-d76b-6969-8cf6371c2a1a@doubly.so>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Applied with small nitpick.

On Thu, Oct 01, 2020 at 11:30:27AM +0200, Devin Bayer wrote:
> +# declare a set, bound to table "filter", in family "ip".
> +# Timeout and size are mandatory because we will add elements from packet
> path.
> +# Entries will timeout after one minute, after which they might be
> +# re-added if limit condition persists.
> +nft add set ip filter blackhole \
> +    "{ type ipv4_addr; timeout 1m; size 65536 }"
> +
> +# declare a set to store the limit per saddr.
> +# This must be separate from blackhole since the timeout is different
> +nft add set ip filter flood \
> +    "{ type ipv4_addr; flags dynamic; timeout 10s; size 128000 }"

Missing semi-colons after size.

Please, double-check that what I have applied looks correct to you.

Thanks.
