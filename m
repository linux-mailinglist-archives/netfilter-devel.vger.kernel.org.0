Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4DEE80E
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Nov 2019 20:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfKDTPx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 4 Nov 2019 14:15:53 -0500
Received: from correo.us.es ([193.147.175.20]:43556 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbfKDTPx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:15:53 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 89CC9EB464
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 20:15:48 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7A3BF2DC8F
        for <netfilter-devel@vger.kernel.org>; Mon,  4 Nov 2019 20:15:48 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6FB79D1929; Mon,  4 Nov 2019 20:15:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 95353DA72F;
        Mon,  4 Nov 2019 20:15:46 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 04 Nov 2019 20:15:46 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 7259A41E4801;
        Mon,  4 Nov 2019 20:15:46 +0100 (CET)
Date:   Mon, 4 Nov 2019 20:15:48 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/3] ipset patches for nf
Message-ID: <20191104191548.g72ib4wsfve2ces3@salvia>
References: <20191101163554.10561-1-kadlec@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101163554.10561-1-kadlec@blackhole.kfki.hu>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 01, 2019 at 05:35:51PM +0100, Jozsef Kadlecsik wrote:
> Hi Pablo,
> 
> Please pull the next ipset patches for the nf tree:
> 
> - Fix the error code in ip_set_sockfn_get() when copy_to_user() is used,
>   from Dan Carpenter.
> - The IPv6 part was missed when fixing copying the right MAC address
>   in the patch "netfilter: ipset: Copy the right MAC address in bitmap:ip,mac
>   and hash:ip,mac sets", it is completed now by Stefano Brivio.
> - ipset nla_policies are fixed to fully support NL_VALIDATE_STRICT and
>   the code is converted from deprecated parsings to verified ones.

Applied, thanks!
