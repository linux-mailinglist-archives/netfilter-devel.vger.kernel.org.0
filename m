Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D5AD7FE
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Sep 2019 13:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfIILfx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Sep 2019 07:35:53 -0400
Received: from correo.us.es ([193.147.175.20]:37084 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbfIILfx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:35:53 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D67A3EBAC3
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Sep 2019 13:35:47 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C4727B8011
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Sep 2019 13:35:47 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B99CAB8004; Mon,  9 Sep 2019 13:35:47 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-106.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        PDS_TONAME_EQ_TOLOCAL_SHORT,SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A22AC8E58B;
        Mon,  9 Sep 2019 13:35:45 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 09 Sep 2019 13:35:45 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [47.60.45.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6BF3A42EE38E;
        Mon,  9 Sep 2019 13:35:45 +0200 (CEST)
Date:   Mon, 9 Sep 2019 13:35:45 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu <wenxu@ucloud.cn>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v4 4/4] netfilter: nf_offload: clean offload
 things when the device unregister
Message-ID: <20190909113545.yp62vvclxkiz4urj@salvia>
References: <1567952336-23669-1-git-send-email-wenxu@ucloud.cn>
 <1567952336-23669-5-git-send-email-wenxu@ucloud.cn>
 <20190908162148.eble5o6zuo7k5zx4@salvia>
 <ff25e42a-a6b3-8445-047e-82ffe8e50ed3@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff25e42a-a6b3-8445-047e-82ffe8e50ed3@ucloud.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 09, 2019 at 11:52:31AM +0800, wenxu wrote:
> On 9/9/2019 12:21 AM, Pablo Neira Ayuso wrote:
[...]
> So you means drop the missing mutex and offload flags patches. And
> put all in the __nft_offload_get_chain patch?

Exactly.
