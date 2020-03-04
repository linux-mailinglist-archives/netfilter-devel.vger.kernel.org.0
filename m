Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9717878F
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2020 02:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbgCDB0L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Mar 2020 20:26:11 -0500
Received: from correo.us.es ([193.147.175.20]:54542 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgCDB0K (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:26:10 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D19176D4E8
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Mar 2020 02:25:54 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C34B8DA3C3
        for <netfilter-devel@vger.kernel.org>; Wed,  4 Mar 2020 02:25:54 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B68CEDA7B6; Wed,  4 Mar 2020 02:25:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DF120DA736;
        Wed,  4 Mar 2020 02:25:52 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 04 Mar 2020 02:25:52 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id C17DF4251480;
        Wed,  4 Mar 2020 02:25:52 +0100 (CET)
Date:   Wed, 4 Mar 2020 02:26:06 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2 0/4] netfilter: seq_file .next functions should
 increase position index
Message-ID: <20200304012606.v4jhr65hgsgsvoht@salvia>
References: <497a82c1-7b6a-adf4-a4ce-df46fe436aae@virtuozzo.com>
 <5328139a-1c65-74a5-c748-1aabc18ef26c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5328139a-1c65-74a5-c748-1aabc18ef26c@virtuozzo.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:05:29AM +0300, Vasily Averin wrote:
> v2: resend with improved patch description
> 
> In Aug 2018 NeilBrown noticed 
> commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> "Some ->next functions do not increment *pos when they return NULL...
> Note that such ->next functions are buggy and should be fixed. 

Series applied, thanks.
