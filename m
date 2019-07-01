Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B017484DF
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 16:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfFQOFN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 10:05:13 -0400
Received: from mail.us.es ([193.147.175.20]:57996 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbfFQOFM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:05:12 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D4583103281
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 16:05:10 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C3768DA708
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 16:05:10 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B8D3FDA707; Mon, 17 Jun 2019 16:05:10 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C1AC2DA705;
        Mon, 17 Jun 2019 16:05:08 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 17 Jun 2019 16:05:08 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id A1A2D4265A2F;
        Mon, 17 Jun 2019 16:05:08 +0200 (CEST)
Date:   Mon, 17 Jun 2019 16:05:08 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     =?iso-8859-1?Q?St=E9phane?= Veyret <sveyret@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v5] netfilter: nft_ct: add ct expectations support
Message-ID: <20190617140508.t5vwimnf3ocbjwbh@salvia>
References: <20190525133058.18001-1-sveyret@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190525133058.18001-1-sveyret@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, May 25, 2019 at 03:30:58PM +0200, St�phane Veyret wrote:
> This patch allows to add, list and delete expectations via nft objref
> infrastructure and assigning these expectations via nft rule.
> 
> This allows manual port triggering when no helper is defined to manage a
> specific protocol. For example, if I have an online game which protocol
> is based on initial connection to TCP port 9753 of the server, and where
> the server opens a connection to port 9876, I can set rules as follow:
> 
> table ip filter {
>     ct expectation mygame {
>         protocol udp;
>         dport 9876;
>         timeout 2m;
>         size 1;
>     }
> 
>     chain input {
>         type filter hook input priority 0; policy drop;
>         tcp dport 9753 ct expectation set "mygame";
>     }
> 
>     chain output {
>         type filter hook output priority 0; policy drop;
>         udp dport 9876 ct status expected accept;
>     }
> }

Applied, thanks for your patience.
