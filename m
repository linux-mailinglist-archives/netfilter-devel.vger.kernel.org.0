Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D1105351
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 14:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKUNlE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 08:41:04 -0500
Received: from correo.us.es ([193.147.175.20]:45100 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKUNlE (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:41:04 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A2F8DFC5ED
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 14:40:59 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 96098DA72F
        for <netfilter-devel@vger.kernel.org>; Thu, 21 Nov 2019 14:40:59 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8B2E28012A; Thu, 21 Nov 2019 14:40:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id ADBAEDA7B6;
        Thu, 21 Nov 2019 14:40:57 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 21 Nov 2019 14:40:57 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 89AE242EF4E0;
        Thu, 21 Nov 2019 14:40:57 +0100 (CET)
Date:   Thu, 21 Nov 2019 14:40:59 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Michal Rostecki <mrostecki@opensuse.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] mnl: Fix -Wimplicit-function-declaration warnings
Message-ID: <20191121134059.j7qcb5dat7ilsnkq@salvia>
References: <20191121123332.5245-1-mrostecki@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121123332.5245-1-mrostecki@opensuse.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 21, 2019 at 01:33:32PM +0100, Michal Rostecki wrote:
> This change fixes the following warnings:
> 
> mnl.c: In function ‘mnl_nft_flowtable_add’:
> mnl.c:1442:14: warning: implicit declaration of function ‘calloc’ [-Wimplicit-function-declaration]
>   dev_array = calloc(len, sizeof(char *));
>               ^~~~~~
> mnl.c:1442:14: warning: incompatible implicit declaration of built-in function ‘calloc’
> mnl.c:1442:14: note: include ‘<stdlib.h>’ or provide a declaration of ‘calloc’
> mnl.c:1449:2: warning: implicit declaration of function ‘free’ [-Wimplicit-function-declaration]
>   free(dev_array);
>   ^~~~
> mnl.c:1449:2: warning: incompatible implicit declaration of built-in function ‘free’
> mnl.c:1449:2: note: include ‘<stdlib.h>’ or provide a declaration of ‘free’

Applied, thanks.
