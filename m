Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657B819AF1B
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Apr 2020 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbgDAPwh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Apr 2020 11:52:37 -0400
Received: from correo.us.es ([193.147.175.20]:43000 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733068AbgDAPwh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:52:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 38F5FDA70F
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Apr 2020 17:52:35 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2B9B0132C8B
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Apr 2020 17:52:35 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2117C132C80; Wed,  1 Apr 2020 17:52:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 341BA132C80;
        Wed,  1 Apr 2020 17:52:33 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 01 Apr 2020 17:52:33 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 17BDC4301DE0;
        Wed,  1 Apr 2020 17:52:33 +0200 (CEST)
Date:   Wed, 1 Apr 2020 17:52:32 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] concat: provide proper dtype when parsing typeof
 udata
Message-ID: <20200401155232.cl7n5doffleurgnr@salvia>
References: <20200401140844.27314-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401140844.27314-1-fw@strlen.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:08:44PM +0200, Florian Westphal wrote:
> Pablo reports following list bug:
> table ip foo {
>         map whitelist {
>                 typeof ip saddr . ip daddr : meta mark
>                 elements = { 0x0 [invalid type] . 0x0 [invalid type] : 0x00000001,
>                              0x0 [invalid type] . 0x0 [invalid type] : 0x00000002 }
>         }
> }
> 
> Problem is that concat provided 'invalid' dtype.
> 
> Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Patch works fine here, thanks Florian.
