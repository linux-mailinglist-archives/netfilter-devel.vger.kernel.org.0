Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 186F460C8E
	for <lists+netfilter-devel@lfdr.de>; Fri,  5 Jul 2019 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfGEUp0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 5 Jul 2019 16:45:26 -0400
Received: from mail.us.es ([193.147.175.20]:42896 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfGEUp0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:45:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8826CFB6C0
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 22:45:24 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 799B4351A
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jul 2019 22:45:24 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6F4A9DA708; Fri,  5 Jul 2019 22:45:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7881DDA4CA;
        Fri,  5 Jul 2019 22:45:22 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 05 Jul 2019 22:45:22 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5813C4265A2F;
        Fri,  5 Jul 2019 22:45:22 +0200 (CEST)
Date:   Fri, 5 Jul 2019 22:45:21 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     nikolay@cumulusnetworks.com, netfilter-devel@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH 4/7 nf-next v2] netfilter: nft_meta_bridge: add
 NFT_META_BRI_IIFPVID support
Message-ID: <20190705204521.u2mq22wt5h2u6nnr@salvia>
References: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
 <1562332598-17415-4-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562332598-17415-4-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 05, 2019 at 09:16:35PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> nft add table bridge firewall
> nft add chain bridge firewall zones { type filter hook prerouting priority - 300 \; }
> nft add rule bridge firewall zones counter ct zone set vlan id map { 100 : 1, 200 : 2 }
> 
> As above set the bridge port with pvid, the received packet don't contain
> the vlan tag which means the packet should belong to vlan 200 through pvid.
> With this pacth user can get the pvid of bridge ports.
> 
> So add the following rule for as the first rule in the chain of zones.
> 
> nft add rule bridge firewall zones counter meta vlan set meta briifpvid

Applied, thanks.
