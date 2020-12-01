Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F92C99F0
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Dec 2020 09:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgLAItM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Dec 2020 03:49:12 -0500
Received: from correo.us.es ([193.147.175.20]:52616 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbgLAItL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:49:11 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8FEB520A532
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Dec 2020 09:48:28 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 82F1E11C377
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Dec 2020 09:48:28 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 81FC611C376; Tue,  1 Dec 2020 09:48:28 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 712F011C365;
        Tue,  1 Dec 2020 09:48:26 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 01 Dec 2020 09:48:26 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 5358742EE38F;
        Tue,  1 Dec 2020 09:48:26 +0100 (CET)
Date:   Tue, 1 Dec 2020 09:48:26 +0100
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Wang Shanker <shankerwangmiao@gmail.com>
Cc:     netfilter-devel@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2] netfilter: nfnl_acct: remove data from struct net
Message-ID: <20201201084826.GB26468@salvia>
References: <2D679487-4F6A-405E-AC4E-B47539F1969A@gmail.com>
 <20201115110432.GA23896@salvia>
 <BC5D575D-5AA9-40AD-AEF6-67BF2111BCD4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BC5D575D-5AA9-40AD-AEF6-67BF2111BCD4@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:17:24PM +0800, Wang Shanker wrote:
> This patch removes nfnl_acct_list from struct net, making it possible to
> compile nfacct module out of tree and reducing the default memory
> footprint for the netns structure.

Applied.

But I have removed the reference to the out-of-tree module from the
patch description.
