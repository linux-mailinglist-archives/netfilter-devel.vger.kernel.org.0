Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31316B1BD9
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbfIMK6M (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 06:58:12 -0400
Received: from correo.us.es ([193.147.175.20]:46988 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbfIMK6L (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:58:11 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CFCB81878A6
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Sep 2019 12:58:07 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C046BA7E11
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Sep 2019 12:58:07 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B5E2BDA72F; Fri, 13 Sep 2019 12:58:07 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A3632A7E1D;
        Fri, 13 Sep 2019 12:58:05 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 13 Sep 2019 12:58:05 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 817B542EE38F;
        Fri, 13 Sep 2019 12:58:05 +0200 (CEST)
Date:   Fri, 13 Sep 2019 12:58:06 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v6 0/4] netfilter: nf_tables_offload: clean
 offload things when the device unregister
Message-ID: <20190913105806.aiuvvkfqh23ak62e@salvia>
References: <1568177604-26989-1-git-send-email-wenxu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568177604-26989-1-git-send-email-wenxu@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:53:20PM +0800, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> This series clean the offload things for both chain and rules when the
> related device unregister
> 
> this version modify the 2/4 and 3/4 and only refactor the
> nft_flow_offload_chain/rule function with no add other functions

Series applied, I had to make a few edits on your patch descriptions.
