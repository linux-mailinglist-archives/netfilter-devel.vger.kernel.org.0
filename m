Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAE22D3164
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Dec 2020 18:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgLHRnn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Dec 2020 12:43:43 -0500
Received: from correo.us.es ([193.147.175.20]:60336 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgLHRnm (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:43:42 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id BEDD37FC33
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 18:42:52 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A1660FC5E8
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 18:42:52 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id D7697DA722; Tue,  8 Dec 2020 18:42:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8B01BDA8F4
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 18:42:48 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 08 Dec 2020 18:42:48 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 72C1841E4800
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 18:42:48 +0100 (CET)
Date:   Tue, 8 Dec 2020 18:42:56 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nftables: fix incorrect element timeout
Message-ID: <20201208174256.GA25594@salvia>
References: <20201208173716.10875-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208173716.10875-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Dec 08, 2020 at 06:37:16PM +0100, Pablo Neira Ayuso wrote:
> Use nf_msecs_to_jiffies64 and nf_jiffies64_to_msecs as provided by
> 8e1102d5a159 ("netfilter: nf_tables: support timeouts larger than 23
> days"), otherwise ruleset listing breaks.

Please, discard this patch. This has been replaced by:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20201208173810.14018-1-pablo@netfilter.org/

Sorry for the noise.
