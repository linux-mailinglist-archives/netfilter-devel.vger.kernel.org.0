Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E864A1D7C87
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2020 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgERPPo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 May 2020 11:15:44 -0400
Received: from correo.us.es ([193.147.175.20]:55068 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERPPo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 May 2020 11:15:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8B29915C111
        for <netfilter-devel@vger.kernel.org>; Mon, 18 May 2020 17:15:42 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7D71DDA710
        for <netfilter-devel@vger.kernel.org>; Mon, 18 May 2020 17:15:42 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 72D6CDA701; Mon, 18 May 2020 17:15:42 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 921B1DA705;
        Mon, 18 May 2020 17:15:40 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 18 May 2020 17:15:40 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6A92F42EF42A;
        Mon, 18 May 2020 17:15:40 +0200 (CEST)
Date:   Mon, 18 May 2020 17:15:40 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 2/2] nft: Drop save_counters callback from
 family_ops
Message-ID: <20200518151540.GB2495@salvia>
References: <20200511133817.11106-1-phil@nwl.cc>
 <20200511133817.11106-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511133817.11106-2-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, May 11, 2020 at 03:38:17PM +0200, Phil Sutter wrote:
> All families use the same callback function, just fold it into the sole
> place it's called.

LGTM.
