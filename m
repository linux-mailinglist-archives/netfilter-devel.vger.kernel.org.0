Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10EB11BF83
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Dec 2019 22:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLKV4D (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Dec 2019 16:56:03 -0500
Received: from correo.us.es ([193.147.175.20]:60268 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfLKV4D (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:56:03 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 850843066C2
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Dec 2019 22:56:00 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 776D9DA70C
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Dec 2019 22:56:00 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6D281DA702; Wed, 11 Dec 2019 22:56:00 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7A8DFDA705;
        Wed, 11 Dec 2019 22:55:58 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 11 Dec 2019 22:55:58 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 55ACF4265A5A;
        Wed, 11 Dec 2019 22:55:58 +0100 (CET)
Date:   Wed, 11 Dec 2019 22:55:58 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH nf-next 6/7] netfilter: nft_tunnel: add the missing
 nla_nest_cancel()
Message-ID: <20191211215558.saqx4aueqa6owezd@salvia>
References: <cover.1575779993.git.lucien.xin@gmail.com>
 <40a34ac68b79886f755ec076cbf787ecf7fdc014.1575779993.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40a34ac68b79886f755ec076cbf787ecf7fdc014.1575779993.git.lucien.xin@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Dec 08, 2019 at 12:41:36PM +0800, Xin Long wrote:
> When nla_put_xxx() fails under nla_nest_start_noflag(),
> nla_nest_cancel() should be called, so that the skb can
> be trimmed properly.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
