Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9273116FF76
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Feb 2020 14:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgBZNDc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Feb 2020 08:03:32 -0500
Received: from correo.us.es ([193.147.175.20]:41966 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZNDc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:03:32 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0E4F111EBAA
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Feb 2020 14:03:23 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D1522FC60A
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Feb 2020 14:03:22 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 63FABFEFB4; Wed, 26 Feb 2020 14:02:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7C126FC525;
        Wed, 26 Feb 2020 14:02:41 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 26 Feb 2020 14:02:41 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5495B42EF42C;
        Wed, 26 Feb 2020 14:02:41 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:02:48 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/2] ipset patches for nf
Message-ID: <20200226130248.e6mtozrjsywwsc6k@salvia>
References: <20200222113005.5647-1-kadlec@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222113005.5647-1-kadlec@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Feb 22, 2020 at 12:30:03PM +0100, Jozsef Kadlecsik wrote:
> Hi Pablo,
> 
> Please consider to apply the next two patches to the nf tree. The first one
> is larger than usual, but the issue could not be solved simpler. Also, it's
> a resend of the patch I submitted a few days ago, with a one line fix on
> top of that: the size of the comment extensions was not taken into account
> at reporting the full size of the set.
> 
> - Fix "INFO: rcu detected stall in hash_xxx" reports of syzbot
>   by introducing region locking and using workqueue instead of timer based
>   gc of timed out entries in hash types of sets in ipset.
> - Fix the forceadd evaluation path - the bug was also uncovered by the syzbot.

Pulled, thanks Jozsef.
