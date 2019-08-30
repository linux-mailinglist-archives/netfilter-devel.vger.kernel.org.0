Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED2A2BAA
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Aug 2019 02:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfH3Asv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Aug 2019 20:48:51 -0400
Received: from correo.us.es ([193.147.175.20]:54676 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfH3Asu (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:48:50 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C6D8F27F8AF
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Aug 2019 02:48:45 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B96F4DA4CA
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Aug 2019 02:48:45 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AF367DA8E8; Fri, 30 Aug 2019 02:48:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 99730DA72F;
        Fri, 30 Aug 2019 02:48:43 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 30 Aug 2019 02:48:43 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 70B754265A5A;
        Fri, 30 Aug 2019 02:48:43 +0200 (CEST)
Date:   Fri, 30 Aug 2019 02:48:44 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_meta_bridge: Fix get
 NFT_META_BRI_IIFVPROTO in network byteorder
Message-ID: <20190830004844.bngqog2jt5oo3plk@salvia>
References: <1567004553-15231-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567004553-15231-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:02:33PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> Get the vlan_proto of ingress bridge in network byteorder

Applied, thanks.
