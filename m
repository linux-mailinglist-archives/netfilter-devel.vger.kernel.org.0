Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833EB1E1325
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2020 19:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbgEYREt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 May 2020 13:04:49 -0400
Received: from correo.us.es ([193.147.175.20]:49394 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388410AbgEYREt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 May 2020 13:04:49 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1B13CF22EA
        for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2020 19:04:48 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0CAF2DA796
        for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2020 19:04:48 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 00C23DA78D; Mon, 25 May 2020 19:04:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 099D1DA701;
        Mon, 25 May 2020 19:04:46 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 25 May 2020 19:04:46 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id D2BC642EE396;
        Mon, 25 May 2020 19:04:45 +0200 (CEST)
Date:   Mon, 25 May 2020 19:04:45 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [net PATCH] netfilter: ipset: Fix subcounter update skip
Message-ID: <20200525170445.GA26581@salvia>
References: <20200514113121.32474-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514113121.32474-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 14, 2020 at 01:31:21PM +0200, Phil Sutter wrote:
> If IPSET_FLAG_SKIP_SUBCOUNTER_UPDATE is set, user requested to not
> update counters in sub sets. Therefore IPSET_FLAG_SKIP_COUNTER_UPDATE
> must be set, not unset.

Applied, thanks.
