Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055A2AF24B
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Sep 2019 22:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725263AbfIJUeW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Sep 2019 16:34:22 -0400
Received: from correo.us.es ([193.147.175.20]:35030 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfIJUeW (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:34:22 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 251B81878A6
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Sep 2019 22:34:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 14E9FA7EC2
        for <netfilter-devel@vger.kernel.org>; Tue, 10 Sep 2019 22:34:18 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0A5AAA7EC1; Tue, 10 Sep 2019 22:34:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BE34FDA72F;
        Tue, 10 Sep 2019 22:34:15 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 10 Sep 2019 22:34:15 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.177.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 6BEBE4265A5A;
        Tue, 10 Sep 2019 22:34:15 +0200 (CEST)
Date:   Tue, 10 Sep 2019 22:34:15 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     wenxu@ucloud.cn
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v5 0/4] netfilter: nf_tables_offload: clean
 offload things when the device unregister
Message-ID: <20190910203415.2jb7c437kk3wxq5e@salvia>
References: <1568010126-3173-1-git-send-email-wenxu@ucloud.cn>
 <20190910200206.t222zrsvfakrpi6t@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910200206.t222zrsvfakrpi6t@salvia>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:02:06PM +0200, Pablo Neira Ayuso wrote:
> On Mon, Sep 09, 2019 at 02:22:02PM +0800, wenxu@ucloud.cn wrote:
> > From: wenxu <wenxu@ucloud.cn>
> > 
> > This series clean the offload things for both chain and rules when the
> > related device unregister
> > 
> > This version just rebase the master and make __nft_offload_get_chain
> > fixes mutex and offload flag problem
> 
> applied.

Sorry, I have to keep this back, compilation breaks if I remove patch
3/4 and 4/4. It would be good not to add new code that goes over the
80-chars per column boundary.
