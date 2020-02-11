Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 838C9158B80
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 Feb 2020 09:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgBKIxb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 Feb 2020 03:53:31 -0500
Received: from correo.us.es ([193.147.175.20]:60366 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbgBKIxb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:53:31 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 95334EB90B
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Feb 2020 09:53:29 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 67CABFA64B
        for <netfilter-devel@vger.kernel.org>; Tue, 11 Feb 2020 09:53:29 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id A1311DA854; Tue, 11 Feb 2020 09:53:22 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2AD6EDA864;
        Tue, 11 Feb 2020 09:52:42 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 11 Feb 2020 09:52:42 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 0BA8342EF42C;
        Tue, 11 Feb 2020 09:52:42 +0100 (CET)
Date:   Tue, 11 Feb 2020 09:52:40 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2] xtables-translate: Fix for interface name
 corner-cases
Message-ID: <20200211085240.ivexmgfusvziqbex@salvia>
References: <20200210124828.32400-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210124828.32400-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 10, 2020 at 01:48:28PM +0100, Phil Sutter wrote:
> There are two special situations xlate_ifname() didn't cover for:
> 
> * Interface name containing '*': This went unchanged, creating a command
>   nft wouldn't accept. Instead translate into '\*' which doesn't change
>   semantics.
> 
> * Interface name being '+': Can't translate into nft wildcard character
>   as nft doesn't accept asterisk-only interface names. Instead decide
>   what to do based on 'invert' value: Skip match creation if false,
>   match against an invalid interface name if true.
> 
> Also add a test to make sure future changes to this behaviour are
> noticed.

Phil, this is fine. Thanks.
