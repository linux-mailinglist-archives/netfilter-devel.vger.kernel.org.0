Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6815A28AB27
	for <lists+netfilter-devel@lfdr.de>; Mon, 12 Oct 2020 02:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgJLAC1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 11 Oct 2020 20:02:27 -0400
Received: from correo.us.es ([193.147.175.20]:33692 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgJLAC1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 11 Oct 2020 20:02:27 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 68C98E7811
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 02:02:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5BBAADA704
        for <netfilter-devel@vger.kernel.org>; Mon, 12 Oct 2020 02:02:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3BE27DA78A; Mon, 12 Oct 2020 02:02:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 58C15DA730;
        Mon, 12 Oct 2020 02:02:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 12 Oct 2020 02:02:24 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3CBAC41FF201;
        Mon, 12 Oct 2020 02:02:24 +0200 (CEST)
Date:   Mon, 12 Oct 2020 02:02:23 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        "longguang.yue" <bigclouds@163.com>, yuelongguang@gmail.com
Subject: Re: [PATCH v8 net-next] ipvs: inspect reply packets from DR/TUN real
 servers
Message-ID: <20201012000223.GA14420@salvia>
References: <20201005201347.13644-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005201347.13644-1-ja@ssi.bg>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:13:47PM +0300, Julian Anastasov wrote:
> From: longguang.yue <bigclouds@163.com>
> 
> Just like for MASQ, inspect the reply packets coming from DR/TUN
> real servers and alter the connection's state and timeout
> according to the protocol.
> 
> It's ipvs's duty to do traffic statistic if packets get hit,
> no matter what mode it is.

Applied, thanks.
