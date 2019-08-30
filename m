Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01184A35B0
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Aug 2019 13:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfH3Lb0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 30 Aug 2019 07:31:26 -0400
Received: from correo.us.es ([193.147.175.20]:50302 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfH3Lb0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:31:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A2260172C76
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Aug 2019 13:31:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 931DFD2B1D
        for <netfilter-devel@vger.kernel.org>; Fri, 30 Aug 2019 13:31:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 88464DA4CA; Fri, 30 Aug 2019 13:31:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6565BB8001;
        Fri, 30 Aug 2019 13:31:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 30 Aug 2019 13:31:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3FF0042EE399;
        Fri, 30 Aug 2019 13:31:19 +0200 (CEST)
Date:   Fri, 30 Aug 2019 13:31:20 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v6] meta: add ibrpvid and ibrvproto support
Message-ID: <20190830113120.iidmxqsiwigpyair@salvia>
References: <1567137693-11148-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567137693-11148-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 30, 2019 at 12:01:33PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This allows you to match the bridge pvid and vlan protocol, for
> instance:
> 
> nft add rule bridge firewall zones meta ibrvproto vlan
> nft add rule bridge firewall zones meta ibrpvid 100

Applied, thanks.
